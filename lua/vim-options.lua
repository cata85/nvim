Mapper = require("./utils/mapper")

vim.opt.guicursor = ""
vim.cmd([[highlight CursorLine cterm=underline term=underline ctermbg=NONE guibg=NONE]])
vim.cmd([[highlight LineNr guibg=NONE guifg=#00faf2]])

vim.opt.nu = true
vim.opt.relativenumber = true
vim.cmd("set signcolumn=yes:2")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = {
    tab = "|·",
    lead = "·",
    trail = "⌫",
}
vim.cmd("filetype plugin indent on")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.scrolloff = 20
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"
vim.wo.number = true

vim.g.mapleader = " "

--------------------------------------------------------
-- map(mode, keys, cmd, opts, category, id, description)
--------------------------------------------------------

-- File functions
Mapper.map("n", "<leader>q", ":q!<CR>", { noremap = true }, "File", "Quit", "Quits out of the file without saving.")
Mapper.map("n", "<leader>x", ":x<CR>", { noremap = true }, "File", "Save Quit", "Saves the file and then quits.")
Mapper.map("n", "<leader>w", ":w<CR>", { noremap = true }, "File", "Save", "Saves the file.")

-- Navigations
Mapper.map(
    "i",
    "<C-L>",
    "<Esc>A",
    { noremap = true },
    "Move",
    "Move EOL (Insert)",
    "Moves cursor to the end of line in insert mode."
)
Mapper.map(
    "i",
    "<C-H>",
    "<Esc>I",
    { noremap = true },
    "Move",
    "Move Beginning Of Line (Insert)",
    "Moves cursor to the beginning of line in insert mode."
)

-- Macro functions
Mapper.map("n", "<leader>rq", "@q", { noremap = true }, "Macro", "RepeatQ", "Repeats the Q macro.")

-- Navigate vim panes better
Mapper.map(
    "n",
    "<c-k>",
    ":wincmd k<CR>",
    { noremap = true },
    "Window",
    "Focus Up",
    "Changes focus to the window above."
)
Mapper.map(
    "n",
    "<c-j>",
    ":wincmd j<CR>",
    { noremap = true },
    "Window",
    "Focus Down",
    "Changes focus to the window below."
)
Mapper.map(
    "n",
    "<c-h>",
    ":wincmd h<CR>",
    { noremap = true },
    "Window",
    "Focus Left",
    "Changes focus to the window to the left."
)
Mapper.map(
    "n",
    "<c-l>",
    ":wincmd l<CR>",
    { noremap = true },
    "Window",
    "Focus Right",
    "Changes Focus to the window to the right."
)

Mapper.map(
    "n",
    "<Right>",
    ":wincmd L<CR>",
    { noremap = true },
    "Window",
    "Move Window Right",
    "Moves the window to the right."
)
Mapper.map(
    "n",
    "<Left>",
    ":wincmd H<CR>",
    { noremap = true },
    "Window",
    "Move Window Left",
    "Moves the window to the left."
)
Mapper.map(
    "n",
    "<Up>",
    ":wincmd K<CR>",
    { noremap = true },
    "Window",
    "Move Window Above",
    "Moves the window to the top."
)
Mapper.map(
    "n",
    "<Down>",
    ":wincmd J<CR>",
    { noremap = true },
    "Window",
    "Move Window Below",
    "Moves the window to the bottom."
)

-- Move blocks of code around in Visual Mode
Mapper.map(
    "v",
    "J",
    ":m '>+1<CR>gv=gv",
    { noremap = true },
    "Move",
    "Move Code Block Down",
    "Moves the Block of selected code down."
)
Mapper.map(
    "v",
    "K",
    ":m '<-2<CR>gv=gv",
    { noremap = true },
    "Move",
    "Move Code Block Up",
    "Moves the Block of selected code up."
)

-- Moves line below to line with space, leaves cursor same position
Mapper.map("n", "J", "mzJ`z", { noremap = true }, "", "", "")

-- Moves up and down while leaving cursor in the middle
Mapper.map(
    "n",
    "<C-d>",
    "<C-d>zz",
    { noremap = true },
    "Move",
    "Move Down Center",
    "Moves the cusor down the page and centers."
)
Mapper.map(
    "n",
    "<C-u>",
    "<C-u>zz",
    { noremap = true },
    "Move",
    "Move Up Center",
    "Moves the cursor up the page and centers."
)

-- Goes to next search term while leaving cursor in the middle
Mapper.map(
    "n",
    "n",
    "nzzzv",
    { noremap = true },
    "Search",
    "Next Center",
    "Goes to the next search result and centers the cursor."
)
Mapper.map(
    "n",
    "N",
    "Nzzzv",
    { noremap = true },
    "Search",
    "Previous Center",
    "Goes to the previous search result and centers the cursor."
)

-- Pastes over word while keeping the copy register the same
Mapper.map(
    "x",
    "<leader>p",
    '"_dP',
    { noremap = true },
    "Store",
    "Paste Keep",
    "Pastes over the highlighted area and keeps what was pasted moving the highlighted to blackhole."
)

-- Paste match indentation
Mapper.map(
    "n",
    "p",
    "p=`]",
    { noremap = true },
    "Store",
    "Paste Match Indent",
    "Pastes the text and matches the indentation."
)

-- Always linewise paste the last yanked text
Mapper.map(
    "n",
    "P",
    ":put! \"0=`]<CR>",
    { noremap = true },
    "Store",
    "Paste Line",
    "Pastes the last yanked text as a line."
)

-- Yank to system clipboard
Mapper.map(
    "n",
    "<leader>y",
    '"+y',
    { noremap = true },
    "Store",
    "Copy System Clipboard",
    "Copies to the system clipboard."
)
Mapper.map(
    "v",
    "<leader>y",
    '"+y',
    { noremap = true },
    "Store",
    "Copy System Clipboard (Visual)",
    "Copies highlighted area to system clipboard."
)
Mapper.map(
    "n",
    "<leader>Y",
    '"+Y',
    { noremap = true },
    "Store",
    "Append System Clipboard",
    "Appends to the system clipboard."
)
Mapper.map(
    "v",
    ",leader>Y",
    '"+Y',
    { noremap = true },
    "Store",
    "Append System Clipboard (Visual)",
    "Appends area to the system clipboard."
)

-- Delete to blackhole register
Mapper.map(
    "n",
    "<leader>d",
    '"_d',
    { noremap = true },
    "Store",
    "Delete Blackhole",
    "Deletes to the blackhole register."
)
Mapper.map(
    "v",
    "<leader>d",
    '"_d',
    { noremap = true },
    "Store",
    "Delete Blackhole (Visual)",
    "Deletes area to the blackhole register."
)

-- Get rid of Q
Mapper.map("n", "Q", "<nop>", { noremap = true }, "Misc", "Q Ignore", "Gets rid of the letter Q.")

-- Format
Mapper.map("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { noremap = true }, "Code", "Format", "Formats the code.")

-- Replace current word text for all occurances
Mapper.map(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true },
    "Replace",
    "Replace Word All",
    "Replaces all occurances of the word with change."
)

Mapper.map(
    "n",
    "<leader>h",
    ":nohlsearch<CR>",
    { noremap = true },
    "Misc",
    "Turn Off Highlight",
    "Turns of the search result highlights."
)

Mapper.map(
    "v",
    "y",
    "may`a",
    { noremap = true },
    "Store",
    "Yank Keep Cursor Position",
    "Yanks the highlighted area and keeps the cursor position."
)
