; Inject into sqlx::query!(r#"..."#, ...) as sql
([
   (string_literal)
   (raw_string_literal)
 ] @sql
 (#match? @sql "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
 (#offset! @sql 1 0 0 0))
