local M = {}

local query = [[
SELECT COALESCE(json_agg(datname ORDER BY datname), '[]'::json)
FROM pg_catalog.pg_database
WHERE NOT datistemplate AND datallowconn
  AND pg_catalog.has_database_privilege(oid, 'CONNECT')
]]

local function encode(value)
	return (value:gsub("([^%w%-%._~])", function(char)
		return string.format("%%%02X", char:byte())
	end))
end

local function service_file()
	local path = vim.env.PGSERVICEFILE
	return path and path ~= "" and path or vim.fn.expand("~/.pg_service.conf")
end

local function services(path)
	local result, seen = {}, {}
	if vim.fn.filereadable(path) == 1 then
		for _, line in ipairs(vim.fn.readfile(path)) do
			local name = line:match("^%s*%[([^%]]+)%]")
			if name and not seen[name] then
				seen[name] = true
				table.insert(result, name)
			end
		end
	end
	table.sort(result)
	return result
end

local function database_list(value)
	if type(value) ~= "table" or not vim.islist(value) then
		return false
	end
	for _, name in ipairs(value) do
		if type(name) ~= "string" or name == "" then
			return false
		end
	end
	return true
end

function M.setup()
	local cache_path = vim.fn.stdpath("cache") .. "/dadbod-clusters.json"
	local path = service_file()
	local databases = {}
	local selected = {}
	local busy = false
	local ok, cached = pcall(function()
		return vim.json.decode(table.concat(vim.fn.readfile(cache_path), "\n"))
	end)
	if ok and type(cached) == "table" and cached.service_file == path and type(cached.databases) == "table" then
		for service, names in pairs(cached.databases) do
			if database_list(names) then
				databases[service] = names
			end
		end
		if type(cached.selected) == "table" then
			for service, name in pairs(cached.selected) do
				if type(name) == "string" then
					selected[service] = name
				end
			end
		end
	end

	local function save()
		local saved = pcall(function()
			vim.fn.mkdir(vim.fn.fnamemodify(cache_path, ":h"), "p")
			vim.fn.writefile({
				vim.json.encode({ service_file = path, databases = databases, selected = selected }),
			}, cache_path)
		end)
		if not saved then
			vim.notify("Could not save Dadbod discovery cache", vim.log.levels.WARN)
		end
	end

	local function apply()
		local connections = {}
		for _, service in ipairs(services(path)) do
			local label = service:upper():gsub("%-", " ")
			local suffix = "?service=" .. encode(service)
			local database = selected[service]
			if database and databases[service] and not vim.tbl_contains(databases[service], database) then
				selected[service], database = nil, nil
			end
			if database then
				table.insert(connections, {
					name = label .. " / " .. database,
					url = "postgresql:///" .. encode(database) .. suffix,
				})
			else
				-- Keep the drawer compact; discovered databases live in the picker.
				table.insert(connections, { name = label, url = "postgresql:///" .. suffix })
			end
		end
		table.sort(connections, function(a, b)
			return a.name == b.name and a.url < b.url or a.name < b.name
		end)
		local dev = vim.fn.DotenvGet("DATABASE_URL")
		if type(dev) == "string" and dev ~= "" then
			table.insert(connections, 1, { name = "dev", url = dev })
		end
		vim.g.dbs = connections
	end

	local function update_drawer()
		local current = vim.api.nvim_get_current_win()
		local visible = false
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "dbui" then
				visible = true
			end
		end
		if visible then
			vim.fn["db_ui#close"]()
		end
		vim.fn["db_ui#reset_state"]()
		if visible then
			vim.fn["db_ui#open"]("")
		end
		if vim.api.nvim_win_is_valid(current) then
			vim.api.nvim_set_current_win(current)
		end
	end

	local function sync_path()
		local next_path = service_file()
		if next_path ~= path then
			path, databases, selected = next_path, {}, {}
		end
	end

	local function complete_service(prefix)
		return vim.tbl_filter(function(name)
			return name:sub(1, #prefix) == prefix
		end, services(service_file()))
	end

	vim.api.nvim_create_user_command("DBUISelectDatabase", function(command)
		if busy then
			vim.notify("Wait for cluster discovery to finish before selecting a database", vim.log.levels.WARN)
			return
		end
		sync_path()
		local targets = services(path)
		local picker_path = path
		local function choose_database(service)
			if not service or path ~= picker_path then
				return
			end
			local names = databases[service]
			if not names then
				vim.notify("Run :DBUIRefreshClusters " .. service .. " to discover its databases", vim.log.levels.WARN)
				return
			end
			if #names == 0 then
				vim.notify("No accessible databases discovered for " .. service, vim.log.levels.WARN)
				return
			end
			vim.ui.select(names, { prompt = "Database on " .. service }, function(database)
				if not database or path ~= picker_path then
					return
				end
				selected[service] = database
				apply()
				save()
				update_drawer()
			end)
		end
		if command.args ~= "" then
			if vim.tbl_contains(targets, command.args) then
				choose_database(command.args)
			else
				vim.notify("Unknown PostgreSQL service: " .. command.args, vim.log.levels.ERROR)
			end
		elseif #targets == 0 then
			vim.notify("No PostgreSQL services found in " .. path, vim.log.levels.WARN)
		else
			vim.ui.select(targets, { prompt = "PostgreSQL cluster" }, choose_database)
		end
	end, {
		nargs = "?",
		complete = complete_service,
		desc = "Select the active database for a PostgreSQL cluster",
	})

	vim.api.nvim_create_user_command("DBUIRefreshClusters", function(command)
		if busy then
			vim.notify("Cluster discovery is already running", vim.log.levels.WARN)
			return
		end
		sync_path()
		local targets = services(path)
		if command.args ~= "" then
			if not vim.tbl_contains(targets, command.args) then
				vim.notify("Unknown PostgreSQL service: " .. command.args, vim.log.levels.ERROR)
				return
			end
			targets = { command.args }
		end
		if #targets == 0 then
			vim.notify("No PostgreSQL services found in " .. path, vim.log.levels.WARN)
			return
		end
		busy = true
		local remaining, succeeded, failed = #targets, 0, {}
		vim.notify("Discovering databases on " .. #targets .. " PostgreSQL cluster(s)")
		local function complete(service, result)
			local decoded, names = pcall(vim.json.decode, result.stdout or "")
			if result.code == 0 and decoded and database_list(names) then
				databases[service] = names
				succeeded = succeeded + 1
			else
				table.insert(failed, service)
			end
			remaining = remaining - 1
			if remaining ~= 0 then
				return
			end
			busy = false
			apply()
			if succeeded > 0 then
				save()
			end
			update_drawer()
			local message = "Discovered databases on " .. succeeded .. " cluster(s)"
			if #failed > 0 then
				table.sort(failed)
				message = message
					.. ". Discovery failed for: "
					.. table.concat(failed, ", ")
					.. ". Kept previous connections."
			end
			vim.notify(message, #failed > 0 and vim.log.levels.WARN or vim.log.levels.INFO)
		end
		for _, service in ipairs(targets) do
			local started = pcall(
				vim.system,
				{
					"psql",
					"-X",
					"-w",
					"-A",
					"-t",
					"-v",
					"ON_ERROR_STOP=1",
					"--dbname",
					"postgresql:///?service=" .. encode(service),
					"-c",
					query,
				},
				{
					text = true,
					timeout = 15000,
					env = {
						PGSERVICEFILE = path,
						PGCONNECT_TIMEOUT = "5",
						PGOPTIONS = (vim.env.PGOPTIONS or "")
							.. " -c statement_timeout=5000 -c default_transaction_read_only=on",
					},
				},
				vim.schedule_wrap(function(result)
					complete(service, result)
				end)
			)
			if not started then
				vim.schedule(function()
					complete(service, { code = -1 })
				end)
			end
		end
	end, {
		nargs = "?",
		complete = complete_service,
		desc = "Discover PostgreSQL databases from cluster services",
	})
	apply()
end

return M
