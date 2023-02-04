return {

  -- THEMES
  { "lunarvim/colorschemes" },
  { "rose-pine/neovim" },

  -- THEME SETUP
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darkplus",
    },
  },

  -- smp and autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },

  -- copilot
  { "github/copilot.vim" },

  -- git signs
  { "lewis6991/gitsigns.nvim" },

  --git integration
  { "tpope/vim-fugitive" },

  -- zen-mode
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        backdrop = 0.85,
      })
    end,
  },

  -- tmux navigator
  { "christoomey/vim-tmux-navigator" },
}
