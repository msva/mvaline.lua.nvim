-- luacheck: globals vim

local hi = vim.api.nvim_set_hl

hi(0, "Scroll_100", {ctermfg=160, ctermbg=234, cterm={bold=1,}, bg="#1c1c1c", bold=1, fg="#d70000",})
hi(0, "Scroll_90", {ctermfg=166, ctermbg=234, cterm={bold=1,}, bg="#1c1c1c", bold=1, fg="#d75f00",})
hi(0, "Scroll_70", {ctermfg=172, ctermbg=234, cterm={bold=1,}, bg="#1c1c1c", bold=1, fg="#d78700",})
hi(0, "Scroll_50", {ctermfg=178, ctermbg=234, cterm={bold=1,}, bg="#1c1c1c", bold=1, fg="#d7af00",})
hi(0, "Scroll_30", {ctermfg=184, ctermbg=234, cterm={bold=1,}, bg="#1c1c1c", bold=1, fg="#d7d700",})
hi(0, "Scroll_10", {ctermfg=190, ctermbg=234, cterm={bold=1,}, bg="#1c1c1c", bold=1, fg="#d7ff00",})

hi(0, "LinePos_80", {ctermfg=52,  ctermbg=252, cterm={bold=1,}, bg="#d0d0d0", bold=1, fg="#5f0000",})
hi(0, "LinePos_70", {ctermfg=94,  ctermbg=252, cterm={bold=1,}, bg="#d0d0d0", bold=1, fg="#873f00",})
hi(0, "LinePos_30", {ctermfg=58,  ctermbg=252, cterm={bold=1,}, bg="#d0d0d0", bold=1, fg="#5f3f00",})
hi(0, "LinePos_1", {ctermfg=22,  ctermbg=252, cterm={bold=1,}, bg="#d0d0d0", bold=1, fg="#005f00",})

hi(0, "CurArrow", {ctermfg=252, ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#d0d0d0",})
hi(0, "ScrollArrow", {ctermfg=234, fg="#1c1c1c",})
--                   ctermbg=234, cterm={bold=1,}, bold=1,
hi(0, "CurPos", {ctermfg=234, ctermbg=252, cterm={bold=1,}, bg="#d0d0d0", bold=1, fg="#1c1c1c",})

hi(0, "NormalMode", {ctermfg=22,  ctermbg=148, cterm={bold=1,}, bold=1, bg="#afd700", fg="#005f00",})
hi(0, "NormalModeArrow", {ctermfg=148, ctermbg=234, cterm={bold=1,}, bold=1, fg="#afd700", bg="#1c1c1c",})
hi(0, "NormalModeArrowPaste", {ctermfg=148, ctermbg=166, cterm={bold=1,}, bold=1, fg="#afd700", bg="#d75f00",})

hi(0, "InsertMode", {ctermfg=252, ctermbg=31,  cterm={bold=1,}, bold=1, bg="#0087af", fg="#d0d0d0",})
hi(0, "InsertModeArrow", {ctermfg=31,  ctermbg=234, cterm={bold=1,}, bold=1, fg="#0087af", bg="#1c1c1c",})
hi(0, "InsertModeArrowPaste", {ctermfg=31,  ctermbg=166, cterm={bold=1,}, bold=1, fg="#0087af", bg="#d75f00",})

hi(0, "VisualMode", {ctermfg=94,  ctermbg=214, cterm={bold=1,}, bold=1, bg="#ffaf00", fg="#875f00",})
hi(0, "VisualModeArrow", {ctermfg=214, ctermbg=94,  cterm={bold=1,}, bold=1, bg="#875f00", fg="#ffaf00",})
hi(0, "VisualSelMode", {ctermfg=214, ctermbg=94,  cterm={bold=1,}, bold=1, bg="#875f00", fg="#ffaf00",})
hi(0, "VisualSelModeArrow", {ctermfg=94,  ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#875f00",})
hi(0, "VisualModeArrowPaste", {ctermfg=94,  ctermbg=166, cterm={bold=1,}, bold=1, bg="#d75f00", fg="#875f00",})

hi(0, "ReplaceMode", {ctermfg=252, ctermbg=160, cterm={bold=1,}, bold=1, bg="#d70000", fg="#d0d0d0",})
hi(0, "ReplaceModeArrow", {ctermfg=160, ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#d70000",})
hi(0, "ReplaceModeArrowPaste", {ctermfg=160, ctermbg=166, cterm={bold=1,}, bold=1, bg="#d75f00", fg="#d70000",})

hi(0, "PasteMode", {ctermfg=231, ctermbg=166, cterm={bold=1,}, bold=1, bg="#d75f00", fg="#d0d0d0",})
hi(0, "PasteArrow", {ctermfg=166, ctermbg=234, cterm={bold=1,}, bold=1, fg="#d75f00", bg="#1c1c1c",})
hi(0, "Panel", {ctermfg=239, fg="#4a4a4a",})
--                   ctermbg=234, cterm={bold=1,}, bold=1,
hi(0, "isRO", {ctermfg=196, ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#ff0000",})
hi(0, "FileName", {ctermfg=244, ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#808080",})
hi(0, "FileNameArrow", {ctermfg=234, fg="#1c1c1c",})
--                   ctermbg=234, cterm={bold=1,}, bold=1,
hi(0, "Modified", {ctermfg=9,   ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#ff0000",})
hi(0, "Saved", {ctermfg=22,  ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#00ff00",})
hi(0, "VCSI_svn", {ctermfg=14,  ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#00ffee",})
hi(0, "VCSI_git", {ctermfg=10,  ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#54ff54",})
hi(0, "VCSI_hg", {ctermfg=13,  ctermbg=234, cterm={bold=1,}, bold=1, bg="#1c1c1c", fg="#ff00ae",})


