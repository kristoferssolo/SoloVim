; Inject into sqlx::query!(r#"..."#, ...) as sql
(macro_invocation
 (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx"))

 (token_tree
   (raw_string_literal) @sql) 
   (#offset! @sql 1 0 0 0))
