vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.api.nvim_create_autocmd("FileType", {
pattern = { nix },
callback = function()
  if vim.bo.filetype == "nix" then
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
end,
})

vim.opt.list = true
vim.opt.listchars = {
  space = "･",
  tab = "» ",
  trail = "_",
}

vim.opt.undofile = true
local undodir = vim.fn.expand("~/.local/state/nvim/undo")
if vim.fn.isdirectory(undodir) == 0 then
vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undolevels = 10000

require("onedarkpro").setup({
    highlights = {
        Comment = { italic = true },
        Directory = { bold = true },
        ErrorMsg = { italic = true, bold = true },
    },
    styles = {
        types = "NONE",
        methods = "NONE",
        numbers = "NONE",
        strings = "NONE",
        comments = "italic",
        keywords = "bold,italic",
        constants = "NONE",
        functions = "italic",
        operators = "NONE",
        variables = "NONE",
        parameters = "NONE",
        conditionals = "italic",
        virtual_text = "NONE",
    },
    options = {
        cursorline = true,
        transparency = true,
    },
})
vim.cmd("colorscheme onedark_vivid")
