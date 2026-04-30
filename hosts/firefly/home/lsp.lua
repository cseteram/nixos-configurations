vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.lsp.enable('terraformls')

vim.keymap.set('i', '<C-space>', '<C-x><C-o>', { noremap = true, silent = true })

vim.keymap.set('i', '<C-j>', function()
  if vim.fn['pumvisible']() ~= 0 then
    return '<C-n>'
  end
end, { expr = true, noremap = true, silent = true })

vim.keymap.set('i', '<C-k>', function()
  if vim.fn['pumvisible']() ~= 0 then
    return '<C-p>'
  end
end, { expr = true, noremap = true, silent = true })

vim.keymap.set('i', '<tab>', function()
  if vim.fn['pumvisible']() ~= 0 then
    return '<C-y>'
  else
    return '<tab>'
  end
end, { expr = true, noremap = true, silent = true })

vim.keymap.set('i','<esc>', function()
  if vim.fn['pumvisible']() ~= 0 then
    return '<C-e>'
  else
    return '<esc>'
  end
end, { expr = true, noremap = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
