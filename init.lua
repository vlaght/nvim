vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        repo,
        "--branch=stable",
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
local on_attach = function(client, _)
    vim.api.nvim_set_keymap(
        "n",
        "gD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "gF",
        "<cmd>lua vim.lsp.buf.format()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "grc",
        "<cmd>lua vim.lsp.buf.incoming_calls()<CR>",
        { noremap = true, silent = true }
    )

    if client.name == "ruff" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

local lspconfig = require "lspconfig"

lspconfig.ruff.setup {
    on_attach = on_attach,
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
}

lspconfig.gopls.setup {}
-- show tree on startup
-- local nvim_tree_api = require "nvim-tree.api"
-- nvim_tree_api.tree.toggle()

-- AUTO-HOVER CALL WHEN INSIDE A SYMBOL
--- Create an augroup for managing hover behavior
vim.api.nvim_create_augroup("HoverSymbol", { clear = true })

local hover_window = nil
local ignored_lsp_clients = {
    "GitHub Copilot",
}

-- Trigger hover when the cursor is on a symbol
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    group = "HoverSymbol",
    pattern = "*",
    callback = function()
        -- Skip hover if no LSP is attached to the current buffer
        local filtered_clients = vim.tbl_filter(function(client)
            return not vim.tbl_contains(ignored_lsp_clients, client.name)
        end, vim.lsp.get_clients { bufnr = 0 })

        if vim.tbl_isempty(filtered_clients) or hover_window ~= nil then
            return
        end

        -- Check if the hover window is already open
        if hover_window and vim.api.nvim_win_is_valid(hover_window) then
            return
        end

        -- Safely call hover if the symbol exists
        local success = pcall(vim.lsp.buf.hover)
        if success then
            -- Find the hover window (it is usually the last floating window)
            local wins = vim.api.nvim_tabpage_list_wins(0)
            for _, win in ipairs(wins) do
                local config = vim.api.nvim_win_get_config(win)
                if config.relative ~= "" then
                    hover_window = win
                    break
                end
            end
        end
    end,
})

-- Close the hover window when the cursor moves
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    group = "HoverSymbol",
    pattern = "*",
    callback = function()
        if hover_window and vim.api.nvim_win_is_valid(hover_window) then
            vim.api.nvim_win_close(hover_window, true)
            hover_window = nil
        end
    end,
})

vim.schedule(function()
    require "mappings"
end)

vim.opt.relativenumber = true
