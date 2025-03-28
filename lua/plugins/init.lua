return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
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
      ensure_installed = { "lua", "python" },
    },
  },
  { "echasnovski/mini.nvim", branch = "stable" },
  -- {
  --   "jake-stewart/multicursor.nvim",
  --   branch = "1.0",
  --   config = function()
  --       local mc = require("multicursor-nvim")
  --       mc.setup()
  --
  --       local set = vim.keymap.set
  --
  --       -- Add or skip cursor above/below the main cursor.
  --       set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
  --       set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
  --       set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
  --       set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)
  --
  --       -- Add or skip adding a new cursor by matching word/selection
  --       set({"n", "x"}, "<leader>q", function() mc.matchAddCursor(1) end)
  --       set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
  --       set({"n", "x"}, "<leader>Q", function() mc.matchAddCursor(-1) end)
  --       set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)
  --
  --       -- Add and remove cursors with control + left click.
  --       -- set("n", "<c-leftmouse>", mc.handleMouse)
  --       -- set("n", "<c-leftdrag>", mc.handleMouseDrag)
  --       -- set("n", "<c-leftrelease>", mc.handleMouseRelease)
  --
  --       -- Disable and enable cursors.
  --       set({"n", "x"}, "<c-q>", mc.toggleCursor)
  --
  --       -- Mappings defined in a keymap layer only apply when there are
  --       -- multiple cursors. This lets you have overlapping mappings.
  --       mc.addKeymapLayer(function(layerSet)
  --
  --           -- Select a different cursor as the main one.
  --           layerSet({"n", "x"}, "<left>", mc.prevCursor)
  --           layerSet({"n", "x"}, "<right>", mc.nextCursor)
  --
  --           -- Delete the main cursor.
  --           layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)
  --
  --           -- Enable and clear cursors using escape.
  --           layerSet("n", "<esc>", function()
  --               if not mc.cursorsEnabled() then
  --                   mc.enableCursors()
  --               else
  --                   mc.clearCursors()
  --               end
  --           end)
  --       end)
  --
  --       -- Customize how cursors look.
  --       local hl = vim.api.nvim_set_hl
  --       hl(0, "MultiCursorCursor", { link = "Cursor" })
  --       hl(0, "MultiCursorVisual", { link = "Visual" })
  --       hl(0, "MultiCursorSign", { link = "SignColumn"})
  --       hl(0, "MultiCursorMatchPreview", { link = "Search" })
  --       hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
  --       hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  --       hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
  --   end
  -- },
  {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        }
      },
      opts = {
        log_level = "DEBUG",
      }
    }
  },
}
