return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup{}
    vim.keymap.set('n', '[b', ':bprev<CR>', {})
    vim.keymap.set('n', 'b]', ':bnext<CR>', {})
    vim.keymap.set('n', '<leader>q', ':bdelete<CR> <BAR> :bprev<CR>', {})
  end
}
