local lsp_zero = require('lsp-zero')

lsp_zero.preset("recommended")

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp_zero.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp_zero.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
      buffer = bufnr,
      preserve_mappings = true
  })

  vim.keymap.set("n", "<C-f>", vim.lsp.buf.format)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
end)


lsp_zero.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    -- ['phpstan'] = {'php'},
    ['prettier'] = {'html'},
    ['clang-format'] = {'c','cpp'},
    ['rust_analyzer'] = {'rust'},
  }
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    lsp_zero.default_setup,
  },
})

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = true
})


