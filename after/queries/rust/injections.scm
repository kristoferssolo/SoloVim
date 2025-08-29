;extends
;; Inject into sqlx::query!(r#"..."#, ...) as sql
((raw_string_literal) @injection.content
 (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by|ORDER BY|order by)?")
 (#offset! @injection.content 0 3 0 -2)
 (#set! injection.language "sql")
 (#set! injection.include-children)
 )

((string_literal) @injection.content
 (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by|ORDER BY|order by)?")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "sql")
 (#set! injection.include-children)
 )

; (
;  macro_invocation
;  (identifier) @name
;  (#eq? @name "view")
;  (token_tree) @injection.content
;  ; (#offset! @injection.content 0 1 0 -1)
;  (#set! injection.language "typescriptreact")
;  (#set! injection.include-children)
;  )
