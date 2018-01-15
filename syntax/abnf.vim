" Vim syntax file
" Language: ABNF
" Maintainer: Matthew L Daniel <mdaniel@gmail.com>
" Last Change: 2006-06-06
" Version: 1.0.1
" Based On: BNF (by Michael Brailsford)

" Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

setlocal iskeyword+=-
syn case ignore
setlocal ignorecase

" Abnf does not allow comments wherever you please - they are considered
" whitespace and whitespace may only appear in designated locations
syn match abnfNonRuleComment /^;.*$/
syn match abnfComment /;.*$/ contained
" Without the "contained", this doesn't show up :-(
syn keyword abnfCoreRules contained
            \ ALPHA BIT CHAR CR CRLF CTL DIGIT DQUOTE HEXDIG 
            \ HTAB LF LWSP OCTET SP VCHAR WSP 
            \ UNICODE BEYONDASCII BEYONDG0
            \ C1 BEYONDC1 BEYONDG1 LATIN1 BEYONDLATIN1
            \ NONUCHAR UCHAR UCHARBEYONDBMP UCHARBEYONDLATIN1
            \ UCHARBEYONDC1 UCHARBEYONDASCII
            \ PPUACHAR SPUAACHAR SPUABCHAR PUACHAR
            \ UVCHARBEYONDBMP UVCHARBEYONDLATIN1
            \ UVCHARBEYONDASCII UVCHARBEYONDC1 UVCHAR
            \ UWSPBEYONDASCII UWSP PAD HOP BPH NBH IND 
            \ NEL SSA ESA HTS HTJ VTS PLD PLU RI SS2 SS3
            \ DCS PU1 PU2 STS CCH MW SPA EPA SOS SGCI SCI CSI
            \ ST OSC PM APC NBSP SHY LS PS
syn match abnfQuotedRuleName /<[^<>]*>/ contained
syn match abnfRepeat /[[:digit:]]\|\%([[:digit:]]*\*[[:digit:]]*\)/ contained
syn match abnfRuleName /[[:alpha:]][-[:alnum:]]*/ contained

" Production has to be defined after RuleName
syn region abnfProduction start=+^\a+ end=+=+me=e-1 contained

syn match abnfSpecial /=\|(\|)\|\[\|\]\|\// contained
syn match abnfString /"[^"]*"/ contained

" I tried to get these to union, but Vim7 doesn't think so
"syn match abnfTerminalChar contained 
"            \ /%b[01]\+\%(\.[01]\+\)*\%(-[01]\+\)\?/
"syn match abnfTerminalChar contained 
"            \ /%d[[:digit:]]\+\%(\.[[:digit:]]\+\)*\%(-[[:digit:]]\+\)\?/
syn match abnfTerminalChar contained 
            \ /%[bdx][[:xdigit:]]\+\%(\.[[:xdigit:]]\+\)*\%(-[[:xdigit:]]\+\)\?/

syn region abnfBlock start=/^\zs\a\+/ end=/^$/ contains=CONTAINED

if !exists('abnf_ignore_whitespace')
" is there a way to make the match work in both contexts?
    syn match abnfIncompleteStatement /^\s\+$/ contained
    syn match abnfWhiteError /^\s\+$/
endif

if exists('abnf_strict')
  hi def link abnfNonRuleComment Error
endif
if !exists('abnf_ignore_whitespace')
    hi def link abnfIncompleteStatement Error
    hi def link abnfWhiteError Error
endif

hi def link abnfBlock Statement
hi def link abnfComment Comment 
hi def link abnfCoreRules Keyword
hi def link abnfTerminalChar Character
hi def link abnfProduction Define
hi def link abnfQuotedRuleName abnfRuleName
hi def link abnfRepeat Number
hi def link abnfRuleName Identifier
hi def link abnfString String
hi def link abnfSpecial SpecialChar

let b:current_syntax = 'abnf'
