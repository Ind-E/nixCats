return function (_, bufnr)
  local nmap = function (keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>e", vim.diagnostic.open_float, "Error Float")

  nmap("<leader>r", vim.lsp.buf.rename, "Rename Symbol")
  nmap("<leader>a", vim.lsp.buf.code_action, "Code Action")

  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("gy", vim.lsp.buf.type_definition, "Goto Type Definition")
  nmap("gi", vim.lsp.buf.implementation, "Implementations")
end
