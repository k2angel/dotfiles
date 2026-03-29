vim.api.nvim_create_autocmd("FileType", {
pattern = { nix },
callback = function()
  if vim.bo.filetype == "nix" then
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
end,
})

vim.opt.undofile = true
local undodir = vim.fn.expand("~/.local/state/nvim/undo")
if vim.fn.isdirectory(undodir) == 0 then
vim.fn.mkdir(undodir, "p");
end
vim.opt.undodir = undodir
vim.opt.undolevels = 10000

