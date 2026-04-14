return {
	typeCheckingMode = "off",
	analysis = {
		autoSearchPaths = true,
		diagnosticMode = "openFilesOnly",
		useLibraryCodeForTypes = true,
		disableOrganizeImports = true,
		diagnosticSeverityOverrides = {
			reportUnusedVariable = "none",
			reportUndefinedVariable = "warning",
		},
	},
}
