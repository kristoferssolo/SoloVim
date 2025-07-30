;extends
;; Inject into sqlx::query!(r#"..."#, ...) as sql
([
  (string_literal)
  (raw_string_literal)
  ] @injection.content
 (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by|ORDER BY|order by)?")
 (#offset! @injection.content 0 3 0 -2)
 (#set! injection.language "sql")
 (#set! injection.include-children)
 )

;; Inject HTML into view! macro blocks for leptos
(
 (macro_invocation
   macro: (identifier) @macro_name
   (token_tree) @injecttion.content
   )
 (#eq? @macro_name "view")
 (#set! injection.language "html")
 (#set! injection.combined)
)
