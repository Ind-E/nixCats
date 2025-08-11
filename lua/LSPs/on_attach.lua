return function (_, bufnr)
  local nmap = function (keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>le", vim.diagnostic.open_float, "[e]rror float")
  nmap("<leader>lp", function ()
    vim.diagnostic.jump({ count = -1, float = true })
  end, "goto [p]revious diagnostic")
  nmap("<leader>ln", function ()
    vim.diagnostic.jump({ count = 1, float = true })
  end, "goto [n]ext diagnostic")
  nmap("<leader>ll", vim.diagnostic.setloclist, "diagnostics [l]ist")

  nmap("<leader>la", vim.lsp.buf.code_action, "code [a]ction")
  nmap("<leader>ld", vim.lsp.buf.definition, "goto [d]efinition")
  nmap("<leader>lD", vim.lsp.buf.type_definition, "type [D]efinition")
  nmap("<leader>lh", vim.lsp.buf.hover, "[h]over")
  nmap("<leader>ls", vim.lsp.buf.signature_help, "[s]igntaure help")
  nmap("<leader>lr", vim.lsp.buf.rename, "[r]ename symbol")
  nmap("<leader>li", vim.lsp.buf.implementation, "[i]mplementations")
  nmap("<leader>lR", vim.lsp.buf.references, "[R]eferences")
end
