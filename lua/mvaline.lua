-- luacheck: globals vim T

-- some parts can be inspired by, or even taken from https://github.com/nvim-lualine/lualine.nvim
-- as my "initial" hand-made vimL-variant was SOOOOO SLOOOOOOOOOW,
-- and lualine have some nice solutions (but unfortunately doesn't fully fit my needs)


local fn = vim.fn

local line = fn.line
local expand = fn.expand
local exists = fn.exists
local empty = fn.empty
local nr2char = fn.nr2char

local g = vim.g
local b = vim.b

local go = vim.go
local bo = vim.bo

local M = {}

g.last_mode = ""

-- [[ Porting to lualine-way (reading files) TBD ]] {{{
-- {{{ [[ get git head ]]
-- @desc sets git_branch variable to branch name or commit hash if not on branch
-- @param head_file string full path of .git/HEAD file
local function get_git_head(head_file)
  local f_head = io.open(head_file)
  if f_head then
    local HEAD = f_head:read()
    f_head:close()
    local branch = HEAD:match('ref: refs/heads/(.+)$')
    if branch then
      current_git_branch = branch
    else
      current_git_branch = HEAD:sub(1, 15) -- fallback
    end
  end
  return
end -- }}}
-- }}}

function M.get_filename() -- {{{
	local fln = expand("%:t")
	-- local wp  = expand("%:p:h")
	local wd  = expand("%:p:h:t")
	if bo.filetype == 'help' then
		b.filename = fln
	elseif bo.filetype == 'gitcommit' then
		if fln == 'index' and wd == ".git" then
			b.filename = 'git status'
		elseif fln == 'COMMIT_EDITMSG' then
			b.filename = 'git commit'
		else
			b.filename = 'git'
		end
	elseif M.filetype() == "man" and exists(":Man") == 2 then
		local head = fn.getline(1)
		local s_head=head:match("^[^ ]+")
    local w_head
		w_head = s_head or "<empty>"
		local l_head=fn.tolower(w_head)
		b.filename = l_head:gsub("^([^%(]+)%(([^%)+])%)","%1.%2")
	else
		-- bo.filename = expand('%:p:t')
		b.filename = fln
		if empty(b.filename) > 0 then
			b.filename = '<empty>'
		end
	end
	return b.filename
end -- }}}

function M.VCS_branch() -- {{{ XXX: ***VERY*** non-optimal code. NEEDS REWORK
	if not b.vcs_branch then
		local vcs, branch
		local vcs_cmds = {
			git = "(git branch --quiet --show-current) 2>/dev/null",
			hg = "(hg branch) 2>/dev/null",
			-- svn = '(svn info | awk "/^URL:/{print gensub(/.*\//,\"\",\"g\",\$2)}") 2>/dev/null',
		}
		local vcs_formats = {
			default = "",
			git = "%%#VCSI_%s#"..nr2char(177).."%%#FileName#:%s",
			hg = "%%#VCSI_%s#"..nr2char(9791).."%%#FileName#:%s",
			svn = "%%#VCSI_%s#S%%#FileName#:%s",
		}
		for cvcs, cmd in pairs(vcs_cmds) do
			local res = fn.join(fn.split(fn.system(cmd))) -- TODO: think about not-so-dirty way
			if res:len() > 0 then
				vcs = cvcs
				branch = res
				break
			end
		end
		b.vcs_branch = vcs_formats[(vcs or "default")]:format(vcs, branch)
	end
	return b.vcs_branch
end -- }}}

function M.PercentPosition() -- {{{
  return math.floor((line(".") * 100) / line("$"))
end -- }}}

function M.filetype() -- {{{
	if not b.filetype then
		if bo.filetype:len() > 0 then
			b.filetype = bo.filetype
		else
			local fln = fn.glob("%")
			if fln:len() > 0 then
				b.filetype = fn.join(fn.split(fn.system("file -s -p -L -z -b --mime-type "..fln)))
				-- ^^ TODO: takes time (even on startup), moreover, sometimes there can be no `file` utility on the host
			else
				b.filetype = "none"
			end
		end
	end
	return b.filetype
end -- }}}

function M.get_icon(name) -- {{{
	local fallback = { -- {{{
		rar  = nr2char(57520), --  .
		rlar = nr2char(57521), --  .
		lar  = nr2char(57522), --  .
		llar = nr2char(57523), --  .
		-- rar  = nr2char(57520+(4*1)), --
		-- rlar = nr2char(57521+(4*1)), --
		-- lar  = nr2char(57522+(4*1)), --
		-- llar = nr2char(57523+(4*1)), --
		ro   = nr2char(57506), --  .
		lnum = nr2char(57505), --  .
		cnum = nr2char(57507), --  .
		ok   = nr2char(10003), -- ✓ .
		nok  = nr2char(10007), -- ✗ .
		time = nr2char(8986),  -- ⌚. (use bold for emoji)
		vcs  = nr2char(57504), --  .
		git  = nr2char(177),   -- ± .
		hg   = nr2char(9791),  -- ☿ .
	} -- }}}

	local ret = ""

	if g.statusline_icons and g.statusline_icons[name] then
		ret = g.statusline_icon[name]
	elseif fallback[name] then
		ret = fallback[name]
	end
	return ret
end -- }}}

function M.SL() -- {{{
	-- [ icons ] {{{
	local rar		= M.get_icon("rar")
	local lar		= M.get_icon("lar")
	local rlar	= M.get_icon("rlar")
	local llar	= M.get_icon("llar")


	local ro		= M.get_icon("ro")
	local ln		= M.get_icon("lnum")
	local cn		= M.get_icon("cnum")
	local ok		= M.get_icon("ok")
	local nok		= M.get_icon("nok")
	local time	= M.get_icon("time")
	local vcs		= M.get_icon("vcs")
	local git		= M.get_icon("git")
	local hg		= M.get_icon("hg")
	-- TODO: make arrows (well, maybe all icons) configurable
	-- }}}

	local mode = fn.mode()

	if mode ~= g.last_mode then
		g.last_mode = mode
	end
	--[[{{{
--        if l:mode ==# 'n'
--            hi User3 ctermfg=190
--        elseif l:mode ==# "i"
--            hi User2 ctermbg=231 ctermfg=24
--            hi User3 guibg=#0087af ctermbg=4
--            hi User4 ctermfg=117 ctermbg=24
--            hi User5 ctermfg=27 ctermbg=117
--            hi User6 ctermfg=117 ctermbg=4
--            hi User7 ctermbg=4
--        elseif l:mode ==# "R"
--            hi User2 ctermfg=255 ctermbg=160
--        elseif l:mode ==? "v" || l:mode ==# ""
--            hi User2 ctermfg=239 ctermbg=214
--        endif
	--}}}]]

	local def_cg =  {
		mode = "%#NormalMode# ",
		mode_ar = " %#NormalModeArrow#",
		mode_pst_ar = "%#NormalModeArrowPaste#",
	}
	local modes = { -- {{{
		n  = { n = b.statusline_mode_replace or "NORMAL"},
		no = { n = "N·OPER" },
		s  = { n = "SELECT" },
		S = { n = "S·LINE" },
		[""] = { n = "S·BLCK" },
		Rv = { n = "V·RPLCE" },
		c = { n = "COMMAND" },
		cv = { n = "VIM EX" },
		ce = { n = "EX" },
		R = {
			n = "REPLACE",
			cg = {
				mode = "%#ReplaceMode# ",
				mode_ar = " %#ReplaceModeArrow#",
				mode_pst_ar = " %#ReplaceModeArrowPaste#"
			}
		},
		r = { n = "PROMPT" },
		rm = { n = "MORE" },
		["r?"] = { n ="CONFIRM" },
		["!"] = { n ="SHELL" },
		t = { n = "TERMINAL" },
		i = {
			n = "INSERT",
			cg = {
				mode = "%#InsertMode# ",
				mode_ar = " %#InsertModeArrow#",
				mode_pst_ar = " %#InsertModeArrowPaste#"
			}
		},
		v = {
			cg = {
				mode = "%#VisualMode# ",
				mode_ar = " %#VisualSelModeArrow#",
				mode_pst_ar = " %#VisualModeArrowPaste#"
			},
			n = "VISUAL %#VisualModeArrow#"..rar.." %#VisualSelMode#x"
		},
		V = {
			cg = {
				mode = "%#VisualMode# ",
				mode_ar = " %#VisualSelModeArrow#",
				mode_pst_ar = " %#VisualModeArrowPaste#",
		 },
		 n = "V·LINE %#VisualModeArrow#"..rar.." %#VisualSelMode#x"
		},
		[""] = {
			cg = {
				mode = "%#VisualMode# ",
				mode_ar = " %#VisualSelModeArrow#",
				mode_pst_ar = " %#VisualModeArrowPaste#",
			},
			n="V·BLCK %#VisualModeArrow#"..rar.." %#VisualSelMode#x",
		},
	} -- }}}

	local mode_n  = modes[mode] and modes[mode].n or mode
	local mode_cg_t = modes[mode] and modes[mode].cg  or def_cg

	local vp = M.PercentPosition()
	local hp = fn.virtcol(".")

	local ft = M.filetype()

	local fln = M.get_filename()
--	if ft == "man"
--		fln = fn.substitute(fln,"\\~","","")
-- end

--	let &titlestring = substitute(&titlestring,'expand("%:t")','statusline#get_filename()',"g")

	local vcs_branch = M.VCS_branch()

	local sl = T{}

-- if !(&buftype=="help" || (&buftype == "nofile" && filetype=="NvimTree"))
		sl:insert(mode_cg_t.mode .. mode_n)
		if go.paste then
			sl:insert(
				mode_cg_t.mode_pst_ar
					.. rar
					.. ' %#PasteMode#PASTE'
					.. ' %#PasteArrow#'
					.. rar
			)
		else
			sl:insert(mode_cg_t.mode_ar .. rar)
		end
-- end
	sl:insert(' %<')

	if vcs_branch:len() > 0 then
		sl:insert('%#FileName#' .. vcs .. ' ')
		sl:insert('%#VCS_Icon#' .. vcs_branch .. ' ' .. rlar)
	end

	sl:insert('%#isRO#%{&readonly?"'..' '..ro..'":""}')
	sl:insert('%#FileName#')

	sl:insert(' '..fln)

	sl:insert('%#Modified#%{&modified?" '..nok..' ":" "}')
	sl:insert('%#Saved#%{(&modifiable&&!&modified)?" '..ok..' ":" "}')
	sl:insert('%#FileNameArrow#'..rar)

	sl:insert('%*')
	sl:insert('%<')
	sl:insert('%#Panel#')
	sl:insert('%<')

	sl:insert('%=')

	sl:insert(' %{&fileformat} ' .. llar .. ' %{&fileencoding} ' .. llar .. ' ' .. ft .. ' ')

	sl:insert('%#ScrollArrow#'..lar)

	local scr_suf, lin_suf
	if vp >= 90 then
		scr_suf=100
	elseif vp >= 70 and vp < 90 then
		scr_suf=90
	elseif vp >= 50 and vp < 70 then
		scr_suf=70
	elseif vp >=30 and vp < 50 then
		scr_suf=50
	elseif vp >= 10 and vp < 30 then
		scr_suf=30
	elseif vp < 10 then
		scr_suf=10
	end

	if hp > 77 then
		lin_suf=80
	elseif hp >= 73 and hp <= 77 then
		lin_suf=70
	elseif hp >= 35 and hp < 73 then
		lin_suf=30
	elseif hp < 35 then
		lin_suf=1
	end

	if hp < 10 then
		hp = hp.." "
	end


	sl:insert('%#Scroll_' .. scr_suf .. '# ' .. vp .. '%% ')
	sl:insert('%#CurArrow#' .. lar)
	sl:insert('%#CurPos# ' .. ln .. '%l' .. cn .. '%#LinePos_' .. lin_suf .. '#' .. hp .. '%*')

	return sl:concat()
end -- }}}
-- au(0,'VimEnter',function() <detect_vcs> end)

return M
