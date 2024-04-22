return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'bashls', 'clangd', 'tsserver' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- LSP configuration
      local lspconf = require('lspconfig')
      lspconf.lua_ls.setup({})
      lspconf.bashls.setup({})
      lspconf.clangd.setup({})
      lspconf.tsserver.setup({})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
