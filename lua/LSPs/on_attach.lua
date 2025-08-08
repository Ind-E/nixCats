return function (_, bufnr)
  local nmap = function (keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gre", vim.diagnostic.open_float, "[e]rror float")
  nmap("grD", function ()
    vim.diagnostic.jump({ count = -1, float = true })
  end, "goto previous [D]iagnostic")
  nmap("grd", function ()
    vim.diagnostic.jump({ count = 1, float = true })
  end, "goto next [d]iagnostic")
  nmap("grl", vim.diagnostic.setloclist, "open diagnostics [l]ist")
end
