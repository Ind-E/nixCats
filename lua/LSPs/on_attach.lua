return function (_, bufnr)
  local nmap = function (keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>le", vim.diagnostic.open_float, "[e]rror float")
  nmap("<leader>lp", function ()
    vim.diagnostic.jump({ count = -1, float = true })
  end, "goto [p]revious Diagnostic")
  nmap("<leader>ln", function ()
    vim.diagnostic.jump({ count = 1, float = true })
  end, "goto [n]ext diagnostic")
  nmap("<leader>ll", vim.diagnostic.setloclist, "open diagnostics [l]ist")
end
