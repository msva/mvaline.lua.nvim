-- luacheck: globals vim req

-- local f = req"lib.funcs"
-- local au = f.au
-- local fn = vim.fn

local g = vim.g
local o = vim.o

-- local go = vim.go
-- local wo = vim.wo

if g.mva_lines_loaded then
  return
end

g.mva_lines_loaded=1

--set tabline=%!statusline#TL()
o.statusline="%!v:lua.req'mvaline'.SL()"

--  au('WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost,CursorMoved,
--    CursorMovedI,CursorHold,CursorHoldI,Mode', '*', function() SL() end)
--  au('SessionLoadPost', '*', function() SL() end)
--  au('ColorScheme', '*', function() if not fn.has('vim_starting') then SL() end end)


-- o.titlestring = fn.substitute(o.titlestring,'%{expand("%:t")}',"%{v:lua.req'mvaline'.get_filename()}","g")

vim.cmd[[colorscheme mvaline]]
