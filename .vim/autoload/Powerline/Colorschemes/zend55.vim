call Pl#Hi#Allocate({
  \ 'black'          : 16,
  \ 'white'          : 231,
  \
  \ 'darkestred'     : 52,
  \ 'darkred'        : 88,
  \ 'mediumred'      : 124,
  \ 'brightred'      : 160,
  \ 'brightestred'   : 196,
  \
  \ 'darkestpurple'  : 55,
  \ 'mediumpurple'   : 98,
  \ 'brightpurple'   : 189,
  \
  \ 'brightestorange': 214,
  \
  \ 'gray0'          : 233,
  \ 'gray1'          : 235,
  \ 'gray2'          : 236,
  \ 'gray3'          : 239,
  \ 'gray4'          : 240,
  \ 'gray5'          : 241,
  \ 'gray6'          : 244,
  \ 'gray7'          : 245,
  \ 'gray8'          : 247,
  \ 'gray9'          : 250,
  \ 'gray10'         : 252,
\ })

let g:Powerline#Colorschemes#zend55#colorscheme = Pl#Colorscheme#Init([
  \ Pl#Hi#Segments(['SPLIT'],                                                     { 'n': ['gray10', 'gray0']                         } ),
  \ Pl#Hi#Segments(['mode_indicator'],                                            { 'n': ['gray10', 'gray6']                         } ),
  \ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'],                { 'n': ['gray10', 'gray4']                         } ),
  \ Pl#Hi#Segments(['fileinfo', 'filename'],                                      { 'n': ['gray10', 'gray2']                         } ),
  \ Pl#Hi#Segments(['fileinfo.filepath'],                                         { 'n': ['gray8']                                   } ),
  \ Pl#Hi#Segments(['static_str'],                                                { 'n': ['gray10', 'gray0']                          } ),
  \ Pl#Hi#Segments(['fileinfo.flags'],                                            { 'n': ['brightestred', ['bold']]                  } ),
  \ Pl#Hi#Segments(['current_function', 'fileformat', 'fileencoding', 'filetype',
		              \ 'pwd', 'virtualenv:statusline', 'charcode', 'currhigroup'],   { 'n': ['gray8', 'gray2']                          } ),
  \ Pl#Hi#Segments(['lineinfo'],                                                  { 'n': ['gray8', 'gray4']                          } ),
  \ Pl#Hi#Segments(['errors'],                                                    { 'n': ['brightestorange', 'gray0', ['bold']]      } ),
  \ Pl#Hi#Segments(['lineinfo.line.tot'],                                         { 'n': ['gray8']                                   } ),
  \ Pl#Hi#Segments(['paste_indicator', 'ws_marker'],                              { 'n': ['white', 'brightred']                      } ),
  \
  \ Pl#Hi#Segments(['gundo:static_str.name', 'command_t:static_str.name'],        { 'n': ['white', 'mediumred', ['bold']]            } ),
  \ Pl#Hi#Segments(['gundo:static_str.buffer', 'command_t:raw.line'],             { 'n': ['white', 'darkred']                        } ),
  \ Pl#Hi#Segments(['gundo:SPLIT', 'command_t:SPLIT'],                            { 'n': ['white', 'darkred']                        } ),
	\
  \ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'],                              { 'n': ['brightpurple', 'darkestpurple']           } ),
  \ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'],                     { 'n': ['white', 'mediumpurple']                   } ),
  \ Pl#Hi#Segments(['ctrlp:item'],                                                { 'n': ['darkestpurple', 'white', ['bold']]        } ),
  \ Pl#Hi#Segments(['ctrlp:marked'],                                              { 'n': ['brightestred', 'darkestpurple', ['bold']] } ),
  \ Pl#Hi#Segments(['ctrlp:count'],                                               { 'n': ['darkestpurple', 'white']                  } ),
  \ Pl#Hi#Segments(['ctrlp:SPLIT'],                                               { 'n': ['white', 'darkestpurple']                  } ),
\ ])
