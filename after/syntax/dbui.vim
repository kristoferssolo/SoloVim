" Color top-level connection names, preserving status icons and source details.
syntax match SoloVimDBDev /\%(^\S.\{-}\s\)\@<=dev\>.*$/ contains=dbui_connection_ok,dbui_connection_error,dbui_connection_source
syntax match SoloVimDBLocal /\%(^\S.\{-}\s\)\@<=LOCAL\>.*$/ contains=dbui_connection_ok,dbui_connection_error,dbui_connection_source
syntax match SoloVimDBTest /\%(^\S.\{-}\s\)\@<=TEST\>.*$/ contains=dbui_connection_ok,dbui_connection_error,dbui_connection_source
syntax match SoloVimDBProduction /\%(^\S.\{-}\s\)\@<=PROD\>.*$/ contains=dbui_connection_ok,dbui_connection_error,dbui_connection_source

highlight default link SoloVimDBDev DiagnosticInfo
highlight default link SoloVimDBLocal DiagnosticOk
highlight default link SoloVimDBTest DiagnosticWarn
highlight default link SoloVimDBProduction DiagnosticError
