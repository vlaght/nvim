return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            indent = { enable = true },
            ensure_installed = { "lua", "python", "typescript", "javascript", "go" },
        },
    },
    { "echasnovski/mini.nvim", branch = "stable" },
    {
        "github/copilot.vim",
        lazy = false,
        branch = "release",
        config = function()
            vim.g.copilot_assume_mapped = true
        end,
    },
}
