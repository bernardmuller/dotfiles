-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

cmp.setup = {
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      local copilot_keys = vim.fn["copilot#Accept"]()
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}

local keymap = vim.keymap

-- "jk" to escape insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlighting
keymap.set("n", "<leader>nh", ":noh<CR>")

-- move code
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- half page up and down
keymap.set("n", "<C-,>", "<C-d>zz")
keymap.set("n", "<C-.>", "<C-u>zz")

-- keep cursor centered when searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- yank into system clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+yy')

-- disable Q
keymap.set("n", "Q", "<nop>")
