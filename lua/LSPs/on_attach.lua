return function (_, bufnr)
  local nmap = function (keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>e", vim.diagnostic.open_float, "[e]rror float")

  nmap("<leader>r", vim.lsp.buf.rename, "[r]ename symbol")
  nmap("<leader>a", vim.lsp.buf.code_action, "code [a]ction")

  nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
  nmap("gy", vim.lsp.buf.type_definition, "[g]oto t[y]pe definition")
  nmap("gi", vim.lsp.buf.implementation, "[i]mplementations")
  -- ]d and [d are built-in

  -- nmap("<leader>k", vim.lsp.buf.hover, "[h]over")
end
