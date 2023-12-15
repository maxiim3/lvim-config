-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny



lvim.plugins = {
    {
        "tpope/vim-surround",

        -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
        -- setup = function()
        --  vim.o.timeoutlen = 500
        -- end
    },
    {
        "ThePrimeagen/harpoon"
    },
    {
        "wakatime/vim-wakatime"
    },{
        "prettier/vim-prettier"
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    }
}
-- color scheme setup
lvim.colorscheme = vim.cmd[[colorscheme tokyonight]]
lvim.transparent_window = true

lvim.keys.normal_mode["<C-pv>"] = ":Ex"

-- setting a transparent background
vim.api.nvim_set_hl(0, "normal", { bg = "none"})
vim.api.nvim_set_hl(0, "normalfloat", { bg = "none"})

-- Must have : displays number
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabultation stuff
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Wrap the line
vim.opt.wrap = true

-- Set undotree to handle backups in long time
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 16 
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- fugitive
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
-- Add file to harpoon
vim.keymap.set("n", "<Leader>!", mark.add_file)
-- Open Harpoon menu
vim.keymap.set("n", "<Leader>0", ui.toggle_quick_menu)
vim.keymap.set("n", "<Leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<Leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<Leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<Leader>4", function() ui.nav_file(4) end)


-- Custom warp function --
-- define the function
function WrapWithTag(tag)
  local start_line, end_line = unpack(vim.fn.getpos("'<"), 2, 3)
  local end_line_pos = unpack(vim.fn.getpos("'>"), 2, 3)
  if end_line_pos == 0 then
    end_line = end_line + 1
  end
  vim.api.nvim_command(start_line .. ',' .. end_line .. 's/\\%V.*\\%V/' .. '<'.. tag .. '>' .. '&<\\/' .. tag .. '>/')
end

-- define the command to call the function
vim.cmd [[
command! -nargs=1 -range Wrap call v:lua.WrapWithTag(<f-args>)
]]

    -- define the keymap
vim.api.nvim_set_keymap('v', '<leader>w', [[:'<,'>Wrap ]], {noremap = true, silent = false})


