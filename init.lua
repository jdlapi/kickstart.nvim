--[[
Default vim reference
a  append
b  back
c  change
d  delete
e  end
f  find
i  insert
m  mark
n  next
o  open
p  put
r  replace
s  substitute
t  till
u  undo
v  visual
w  word
x  x
y  yank

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Disable netrw to use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set GIT_EDITOR to use nvr if Neovim and nvr are available
if vim.fn.has 'nvim' == 1 and vim.fn.executable 'nvr' == 1 then
  vim.env.GIT_EDITOR = "nvr -cc 'lua lazyGitToggle()' --remote +'set bufhidden=hide'"
end

-- Disable text wrap
vim.wo.wrap = false

-- Disable swapfile
vim.o.swapfile = false

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set default tab settings
vim.opt.expandtab = true       -- enable expandtab (use tabs instead of spaces)
vim.opt.tabstop = 4            -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4         -- Set shift width to 4 spaces

-- Automatically add newline to the end of a file
vim.opt.fixendofline = false

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable virtual text by default
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,  -- Disable virtual text diagnostics
    signs = false,          -- Enable signs in the gutter (if desired)
    update_in_insert = false,  -- Disable diagnostics updates while typing
  }
)

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' }) Replaced this with a command to move between buffers
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' }) Replaced this with a command to move between buffers

-- [[ Custom Keymaps ]]
-- PLACE YOUR CUSTOM KEYMAPS HERE
vim.keymap.set('n', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
vim.keymap.set('i', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
vim.keymap.set('t', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
vim.keymap.set('v', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
vim.keymap.set('n', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
vim.keymap.set('i', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
vim.keymap.set('t', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
vim.keymap.set('v', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<cr><cmd>bprev<cr>', { desc = 'Delete the current buffer' })
vim.keymap.set('t', '<leader>x', '<cmd>bdelete<cr><cmd>bprev<cr>', { desc = 'Delete the current buffer' })
vim.keymap.set('n', '<leader>bv', '', { desc = '[B]reak/split vertically' })
vim.keymap.set('t', '<leader>bv', '<cmd>vsplit<cr>', { desc = '[B]reak/split vertically' })
vim.keymap.set('n', '<leader>bh', '<cmd>split<cr>', { desc = '[B]reak/split horizontally' })
vim.keymap.set('t', '<leader>bh', '<cmd>split<cr>', { desc = '[B]reak/split horizontally' })
vim.keymap.set('n', '<leader>bc', '<cmd>close<cr>', { desc = '[B]reak/split close' })
vim.keymap.set('t', '<leader>bc', '<cmd>close<cr>', { desc = '[B]reak/split close' })
vim.keymap.set('n', '<leader>i', '<cmd>Inspect<cr>', { desc = '[I]nspect under the cursor' })
vim.keymap.set('n', '<Tab>', '>>', { desc = 'Indent the line under the cursor' })
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent the currently selected text' })
vim.keymap.set('n', '<S-Tab>', '<<', { desc = 'Outdent the line under the cursor' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Outdent the currently selected text' })
vim.keymap.set('n', 'gp', 'v`]o`[', { desc = '[G]rab the previously [P]ut text' })
-- vim.keymap.set('n', '<leader>fd', '<cmd>FormatDisable<cr>', { desc = 'Disable autoformat-on-save' })
vim.keymap.set('x', 'p', '"_dP', { desc = '[P]ut without yanking' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[W]rite the current buffer' })
vim.keymap.set('n', '<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = '[T]oggle [D]iagnostics', silent = true, noremap = true })

-- Track the current state of virtual_text
local virtual_text_enabled = false
vim.keymap.set('n', '<leader>tv', function()
  virtual_text_enabled = not virtual_text_enabled  -- Toggle the state
-- <<><><><><<<(<<>> () match test () <> hello <>)>>>>
-- (<> test ()<>)
-- (<> hello>

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = virtual_text_enabled,
      signs = virtual_text_enabled,
    }
  )
end, { desc = '[T]oggle [V]irtual Text', silent = true, noremap = true })
vim.keymap.set('n', '<leader>te', function()
  local filepath = vim.fn.expand('%:p')
  vim.cmd('e ++bin')
  vim.opt_local.endofline = not vim.opt_local.endofline:get()
  vim.opt_local.fileformat = 'unix'
  vim.opt.binary = false
  vim.opt_local.binary = false
  vim.cmd('w')
  vim.cmd('e ' .. vim.fn.fnameescape(filepath))
end, {})

-- Smart select
local function smartSelect(op, around)
  local command_letter = 'i'
  if around then
    command_letter = 'a'
  end
  local command = command_letter .. 'w'
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  col = col + 1
  local line = vim.api.nvim_get_current_line()

  local opening_pairs = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['<'] = '>',
    ['"'] = '"',
    ["'"] = "'",
    ['`'] = '`',
  }

  local closing_pairs = {}
  for open, close in pairs(opening_pairs) do
    closing_pairs[close] = open
  end

  -- Function to check balance of opening and closing characters in the line
  local function check_balance(starting_index, ending_index, reverse)
    local char_to_match = line:sub(starting_index, starting_index)
    local count = 0
    local match_count = 0
    local idx = reverse and starting_index - 1 or starting_index + 1

    while (reverse and idx > ending_index) or (not reverse and idx < ending_index) do
      local char = line:sub(idx, idx)
      if char == char_to_match then
        count = count + 1
      elseif char == opening_pairs[char_to_match] or char == closing_pairs[char_to_match] then
        match_count = match_count + 1
      end

      if match_count > count then
        return false
      end

      -- Move to the next index
      idx = reverse and idx - 1 or idx + 1
    end

    return true
  end

  -- Searches for `ending_char` from `starting_index`, moving forward or backward
  local function find_valid_match(char, char_index, reverse)
    local match_char = reverse and closing_pairs[char] or opening_pairs[char] --might be reversed
    local symetrical_pair = char == match_char
    local step = reverse and -1 or 1
    local index = col + step
    while index >= 1 and index <= #line do
      if line:sub(index, index) == match_char then
        if symetrical_pair then
          local left_count = 0
          local right_count = 0
          if reverse then
            left_count = select(2, line:sub(1, col - 1):gsub(vim.pesc(char), ""))
            right_count = select(2, line:sub(col, #line):gsub(vim.pesc(char), ""))
          else
            left_count = select(2, line:sub(1, col):gsub(vim.pesc(char), ""))
            right_count = select(2, line:sub(col + 1, #line):gsub(vim.pesc(char), ""))
          end

          if left_count % 2 == 1 and right_count % 2 == 1 then
            return index
          end
        else
          if check_balance(char_index, col, reverse) and check_balance(index, col, not reverse) then --might be reversed
            return index
          end
        end
      end
      index = index + step
    end
    return 0
  end

  local search_distance = math.min(col, #line - col + 1)

  for offset = 0, search_distance do
    -- Check left for an opening char and look right for its pair
    local left_index = col - offset
    if left_index >= 1 then
      local char = line:sub(left_index, left_index)
      local match = opening_pairs[char]
      if match and find_valid_match(char, left_index, false) > 0 then
        command = command_letter .. char
        break
      end
    end

    -- Check right for a closing char and look left for its pair
    local right_index = col + offset
    if right_index <= #line then
      local char = line:sub(right_index, right_index)
      local match = closing_pairs[char]
      if match and find_valid_match(char, right_index, true) > 0 then
        command = command_letter .. char
        break
      end
    end
  end

  -- fallback if no match found
  vim.notify(op .. command)
  -- vim.cmd("normal " .. op .. command)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(op .. command, true, false, true), 'n', true)
end
vim.keymap.set('n', 'c<SPACE>', function() smartSelect('c', false) end, { desc = '[c][i]nner smart select' })
vim.keymap.set('n', 'y<SPACE>', function() smartSelect('y', false) end, { desc = '[y][i]nner smart select' })
vim.keymap.set('n', 'v<SPACE>', function() smartSelect('v', false) end, { desc = '[v][i]nner smart select' })
vim.keymap.set('n', 'd<SPACE>', function() smartSelect('d', false) end, { desc = '[v][i]nner smart select' })
vim.keymap.set('n', 'c<CR>', function() smartSelect('c', true) end, { desc = '[C][a]round smart select' })
vim.keymap.set('n', 'y<CR>', function() smartSelect('y', true) end, { desc = '[Y][a]round smart select' })
vim.keymap.set('n', 'v<CR>', function() smartSelect('v', true) end, { desc = '[V][a]round smart select' })
vim.keymap.set('n', 'd<CR>', function() smartSelect('d', true) end, { desc = '[v][a]nner smart select' })


-- [[ Custom Commands ]]
-- PLACE YOUR CUSTOM COMMANDS HERE
-- vim.api.nvim_create_user_command('FormatDisable', function(args)
--   if args.bang then
--     -- FormatDisable! will disable formatting just for this buffer
--     vim.b.disable_autoformat = true
--   else
--     vim.g.disable_autoformat = true
--   end
-- end, {
--   desc = 'Disable autoformat-on-save',
--   bang = true,
-- })
-- vim.api.nvim_create_user_command('FormatEnable', function()
--   vim.b.disable_autoformat = false
--   vim.g.disable_autoformat = false
-- end, {
--   desc = 'Re-enable autoformat-on-save',
-- })

-- [[Custom Autocommands]]
-- PLACE YOUR CUSTOM AUTOCOMMANDS HERE
-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = "*",
--   command = "SessionRestore"
-- })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  --'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically (I commented this out becuase it was causing problems with inconsistently tabbed php files)

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  -- BEGIN Justin Lapicola's plugins
  --
  { -- NVIM-TREE
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        update_focused_file = {
          enable = true,
        },
      }
    end,
  },
  { -- TOGGLETERM
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
    config = function()
      require('toggleterm').setup {
        on_open = function()
          vim.keymap.del('n', '<C-k>')
          vim.keymap.del('i', '<C-k>')
          vim.keymap.del('t', '<C-k>')
          vim.keymap.del('v', '<C-k>')
          vim.keymap.del('n', '<C-j>')
          vim.keymap.del('i', '<C-j>')
          vim.keymap.del('t', '<C-j>')
          vim.keymap.del('v', '<C-j>')
        end,
        on_close = function()
          vim.keymap.set('n', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
          vim.keymap.set('i', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
          vim.keymap.set('t', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
          vim.keymap.set('v', '<C-k>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer in the current list' })
          vim.keymap.set('n', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
          vim.keymap.set('i', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
          vim.keymap.set('t', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
          vim.keymap.set('v', '<C-j>', '<cmd>bprev<cr>', { desc = 'Move to the prev buffer in the current list' })
        end,
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
          width = 235,
          height = 57,
          -- row = <value>,
          -- col = <value>,
          -- winblend = 3,
          -- zindex = <value>,
          -- title_pos = 'left' | 'center' | 'right', position of the title of the floating window
        },
      }

      local map = vim.keymap.set
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }
      local lazydocker = Terminal:new { cmd = 'lazydocker', hidden = true }
      local toggleterm = Terminal:new { hidden = true }

      function LazyGitToggle()
        lazygit:toggle(1, 'float')
      end

      function LazyDockerToggle()
        lazydocker:toggle(1, 'float')
      end

      function ToggleTermToggle()
        toggleterm:toggle(1, 'float')
      end

      map('n', '<C-,>', '<cmd>lua LazyGitToggle()<CR>', { noremap = true, silent = true })
      map('i', '<C-,>', '<cmd>lua LazyGitToggle()<CR>', { noremap = true, silent = true })
      map('t', '<C-,>', '<cmd>lua LazyGitToggle()<CR>', { noremap = true, silent = true })
      map('v', '<C-,>', '<cmd>lua LazyGitToggle()<CR>', { noremap = true, silent = true })

      map('n', '<C-.>', '<cmd>lua LazyDockerToggle()<CR>', { noremap = true, silent = true })
      map('i', '<C-.>', '<cmd>lua LazyDockerToggle()<CR>', { noremap = true, silent = true })
      map('t', '<C-.>', '<cmd>lua LazyDockerToggle()<CR>', { noremap = true, silent = true })
      map('v', '<C-.>', '<cmd>lua LazyDockerToggle()<CR>', { noremap = true, silent = true })

      map('n', '<C-\\>', '<cmd>lua ToggleTermToggle()<CR>', { noremap = true, silent = true })
      map('i', '<C-\\>', '<cmd>lua ToggleTermToggle()<CR>', { noremap = true, silent = true })
      map('t', '<C-\\>', '<cmd>lua ToggleTermToggle()<CR>', { noremap = true, silent = true })
      map('v', '<C-\\>', '<cmd>lua ToggleTermToggle()<CR>', { noremap = true, silent = true })
    end,
  },
  { -- SMEARCURSOR
    'sphamba/smear-cursor.nvim',
    version = '*',
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
    },
  },
  { -- NEOSCROLL
    'karb94/neoscroll.nvim',
    opts = {
      mappings = {
        '<C-u>', '<C-d>',
        '<C-b>', '<C-f>',
        '<C-y>', '<C-e>',
        'zt', 'zz', 'zb',
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.0,
      easing = 'linear',
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
      ignored_events = {
        'WinScrolled', 'CursorMoved'
      },
    },
  },
  { -- HOP
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'etovxqpdygfbblzhckisuran',
    },
    config = function()
      require('hop').setup {}
      local hop = require 'hop'
      vim.keymap.set('', 'f', function()
        hop.hint_char1 {}
      end, { remap = true })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
    end,
  },
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
      enable_cmp_source = false,
        virtual_text = {
          enabled = true,

          -- These are the defaults

          -- Set to true if you never want completions to be shown automatically.
          manual = false,
          -- A mapping of filetype to true or false, to enable virtual text.
          filetypes = {},
          -- Whether to enable virtual text of not for filetypes not specifically listed above.
          default_filetype_enabled = true,
          -- How long to wait (in ms) before requesting completions after typing stops.
          idle_delay = 75,
          -- Priority of the virtual text. This usually ensures that the completions appear on top of
          -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
          -- desired.
          virtual_text_priority = 65535,
          -- Set to false to disable all key bindings for managing completions.
          map_keys = true,
          -- The key to press when hitting the accept keybinding but no completion is showing.
          -- Defaults to \t normally or <c-n> when a popup is showing. 
          accept_fallback = nil,
          -- Key bindings for managing completions in virtual text mode.
          key_bindings = {
              -- Accept the current completion.
              accept = "<C-Up>",
              -- Accept the next word.
              accept_word = false,
              -- Accept the next line.
              accept_line = false,
              -- Clear the virtual text.
              clear = false,
              -- Cycle to the next completion.
              next = "<C-Right>",
              -- Cycle to the previous completion.
              prev = "<C-Left>",
          }
        }
      })
    end
  },
  -- {
  --   'Exafunction/codeium.vim',
  --   event = 'BufEnter',
  --   config = function()
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set('i', '<C-Enter>', function()
  --       return vim.fn['codeium#Accept']()
  --     end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<C-Space>', function()
  --       return vim.fn['codeium#CycleCompletions'](1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<C-Backspace>', function()
  --       return vim.fn['codeium#Clear']()
  --     end, { expr = true, silent = true })
  --   end,
  -- },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
        pattern = opts.filetype_exclude,
        callback = function()
          require('ufo').detach()
        end,
      })

      vim.opt.foldlevelstart = 99
      require('ufo').setup(opts)
    end,
  },
  -- {
  --   'folke/persistence.nvim',
  --   event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  --   opts = {
  --     -- add any custom options here
  --   },
  -- },
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'--,localoptions'
      require('auto-session').setup {
        log_level = 'error',
        no_restore = {
          function()
            -- Restore nvim-tree after a session is restored
            local nvim_tree_api = require 'nvim-tree.api'
            nvim_tree_api.tree.open()
            nvim_tree_api.tree.change_root(vim.fn.getcwd())
            nvim_tree_api.tree.reload()
          end,
        },
        post_restore_cmds = {
          function()
            -- Restore nvim-tree after a session is restored
            local nvim_tree_api = require 'nvim-tree.api'
            nvim_tree_api.tree.open()
            nvim_tree_api.tree.change_root(vim.fn.getcwd())
            nvim_tree_api.tree.reload()
          end,
        },

        pre_save_cmds = { 'NvimTreeClose' },
      }
    end,
  },
  {
    'ja-ford/delaytrain.nvim',
    version = '*',
    config = function()
      require('delaytrain').setup {
        delay_ms = 0, -- How long repeated usage of a key should be prevented
        grace_period = 5, -- How many repeated keypresses are allowed
        keys = { -- Which keys (in which modes) should be delayed
          ['nv'] = { 'h', 'j', 'k', 'l' },
          ['nvi'] = { '<Left>', '<Down>', '<Up>', '<Right>' },
        },
        ignore_filetypes = { 'help', 'NvimTr*' },
      }
    end,
  },
  --
  -- END Justin Lapicola's plugins
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            n = {
              ['<c-d>'] = require('telescope.actions').delete_buffer,
            },
            i = {
              ['<C-h>'] = 'which_key',
              ['<c-d>'] = require('telescope.actions').delete_buffer,
              -- ['<c-enter>'] = 'to_fuzzy_refine',
            },
          },
        },
        pickers = {
          find_files = {
            additional_args = { '--fixed-strings' },
          },
          grep_string = {
            additional_args = { '--fixed-strings' },
          },
          live_grep = {
            additional_args = { '--fixed-strings' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sc', builtin.highlights, { desc = '[S]earch [C]olor Highlights' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n' }) -- I removed 'x' mode

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              -- completion = {
              --   callSnippet = 'Replace',
              -- },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        phpactor = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        html = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        ember = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        jsonls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        omnisharp = {
            capabilities = {
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            },

            cmd = {
              "omnisharp",                   -- the Mason-installed binary
              "--languageserver",            -- run in LSP mode
              "--hostPID", tostring(vim.fn.getpid()),  -- tie it to Neovim’s PID
            },

            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
          },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = 'n',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   local lsp_format_opt
      --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      --     return
      --   end
      --   if disable_filetypes[vim.bo[bufnr].filetype] then
      --     lsp_format_opt = 'never'
      --   else
      --     lsp_format_opt = 'fallback'
      --   end
      --   return {
      --     timeout_ms = 500,
      --     lsp_format = lsp_format_opt,
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<CR>'] = cmp.mapping.confirm { select = true },
          -- ['<Tab>'] = cmp.mapping.select_next_item(),
          -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          -- ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --
  --   -- 'folke/tokyonight.nvim',
  --   -- 'polirritmico/monokai-nightasty.nvim',
  --   --'askfiy/visual_studio_code.nvim',
  --   'Mofiqul/vscode.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'vscode'
  --     vim.opt.background = 'light'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'auto', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {
          Folded = { bg = '#e9ebf1' },
          -- CursorColumn = { bg = '#e9ebf1' },
          UfoFoldedEllipsis = { bg = 'None', fg = '#7c7f93' },
          CodeiumSuggestion = { fg = 'HotPink' },
        },
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }

      vim.cmd.colorscheme 'catppuccin-latte'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup({
        mappings = {
          add = 'ea', -- Add surrounding in Normal and Visual modes
          --e.g. eaiw) - [e]nclose [A]dd [I]nner [W]ord [)]Paren
          --e.g. eaa}) - [e]nclose [A]dd [A]round [}]Braces [)]Paren
          delete = 'ed', -- Delete surrounding
          --e.g.    ed"   - [e]nclose [D]elete ["]quotes
          replace = 'er', -- Replace surrounding
          --e.g.     er)'  - [e]nclose [R]eplace [)]Paren by [']quote
          find = 'ef', -- Find surrounding (to the right)
          find_left = 'eF', -- Find surrounding (to the left)
          highlight = 'eh', -- Highlight surrounding
          update_n_lines = 'en', -- Update `n_lines`
        }
      })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<S-CR>",
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, 
{
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
