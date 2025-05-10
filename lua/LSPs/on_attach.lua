return function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>la', vim.lsp.buf.code_action, 'code [a]ction')
  nmap('<leader>ld', vim.lsp.buf.definition, 'goto [d]efinition')
  nmap('<leader>lD', vim.lsp.buf.type_definition, 'type [D]efinition')
  nmap('<leader>lh', vim.lsp.buf.hover, 'trigger [h]over')
  nmap('<leader>ls', vim.lsp.buf.signature_help, '[s]igntaure help')
  nmap('<leader>lf', vim.lsp.buf.format, '[f]ormat')
end
