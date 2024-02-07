local bo, o, wo, v, fn = vim.bo, vim.o, vim.wo, vim.v, vim.fn
local utils = require('./utils/utils')
local map, feedkeys = utils.map, utils.feedkeys

map('n', '<Esc>', function()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohlsearch()
  elseif bo.modifiable then
    utils.clear_lsp_references()
  elseif #vim.api.nvim_list_wins() > 1 then
    return feedkeys('<C-w>c')
  end

  utils.close_floating_windows()
end, 'Close window if not modifiable, otherwise clear LSP references')
