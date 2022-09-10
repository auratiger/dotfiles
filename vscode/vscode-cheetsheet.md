# CheatSheet

## VIM SHORTCUTS

### Normal

key         | command                                 | Description                      | Plugin
------------|-----------------------------------------|----------------------------------|---------------------
:           | actions.showCommand                     | open command menu                | Code
Shift+Shift |                                         | open file search                 | Intellij keybindings
L           | nextEditor                              | changes to next tab              |
H           | previousEditor                          | changes to previous tab          |
zj          | unfoldRecursively                       | opens fold                       |
zk          | foldRecursively                         | close fold                       |
K           | $                                       | go to end of line                | Vim
H           | ^                                       | go to end of line                | Vim
Y           | y$                                      | copy to end of line              | Vim
ge          | marker.next                             | go to next error                 | Vim
gE          | marker.prev                             | go to prev error                 | Vim
,b          | toggleBreakpoint                        | toggle breakpoint                | Vim
Q           | closeActiveEditor                       | close tab                        | Vim
ZZ          | revertAndCloseActiveEditor              | close tab no save                | Vim
gh          |                                         | Shows hovered line description   |
ctrl+e      | workbench.view.explorer                 | toggles file explorer            |
----------- | ----------------------------            | -------------------------------- | --------------
Alt+h       | focusLeftGroup                          | focus left window                |
Alt+j       | focusBelowGroup                         | focus down window                |
Alt+k       | focusAboveGroup                         | focus up window                  |
Alt+l       | focusRightGroup                         | focus right window               |
Alt+q       | closeEditorsInGroup                     | closes focused editor            |
Alt+Q       | closeEditorsInOtherGroups               | closes all other editors         |
Alt+i       | splitEditor                             | split file vertical              |
Alt+o       | splitEditorOrthogonal                   | split file horizontal            |
----------- | ----------------------------            | -------------------------------- | --------------
<leader>n   | toggleSidebarVisibility                 | toggle sidebar                   | Vim
<leader>sr  | reactSnippets.search                    | react snippets                   | reactSnippets
<leader>r   | rename                                  | rename all occurrences           |
<leader>R   | startFindReplaceAction                  | open find and replace            |
<leader>g   | toggleFileBlame                         | toggles git blame                | gitlens
<leader>q   | createsTypeScriptFile                   | create ts file                   | quokka
<leader>m   | selectandstart                          | opens run configuration          |
<leader>c   | closeActiveEditor                       | close active buffer              | Vim
----------- | ----------------------------            | -------------------------------- | --------------
<leader>bu  | reopenClosedEditor                      | reopen last closed buffer        |
<leader>bo  | showEditorsInActiveGroup                | shows menu of active tabs        |
<leader>bl  | closeEditorsToTheLeft                   | close buffers to the right       |
<leader>br  | closeEditorsToTheRight                  | close buffers to the left        |
<leader>+<  | workbench.action.moveEditorLeftInGroup  | move buffer to the left          |
<leader>+>  | workbench.action.moveEditorRightInGroup | move buffer to the right         |
<leader>by  | copyRelativeFilePath                    | copy relative file path          |
<leader>bY  | copyFilePath                            | copy file path                   |
----------- | ----------------------------            | -------------------------------- | --------------
<leader>tt  | toggleTerminal                          | open terminal                    |
<leader>tq  | killAll                                 | kill all terminal instances      |
----------- | ----------------------------            | -------------------------------- | --------------
<leader>f   | quickOpen                               | opens file search                |
<leader>ff  | quickOpen                               | opens file search                |
<leader>fo  | focusSidebar                            | focus opened file in explorer    | Vim
<leader>fc  | replaceInFiles                          | replace word in all files        |
<leader>fs  | search                                  | search for word in files         |
<leader>fr  | renameFile                              | renames file name                | fileutils
<leader>fn  | newFile                                 | creates new file                 | fileutils
<leader>fd  | removeFile                              | deletes file                     | fileutils
<leader>fm  | moveFile                                | moves file location              | fileutils
<leader>fp  | duplicateFile                           | copies file to location          | fileutils
<leader>fl  | openRecent                              | opens recent project menu        |

### Visual

Key        | Command                | Description               | Plugin
-----------|------------------------|---------------------------|-------------------
:          | showCommands           | open command menu         | Code
>          | indentLines            | indents right             |
<          | outdentLines           | indents left              |
af         |                        | spread selection          |
<leader>f  | macColorPicker         | opens color picker        | macOS Color Picker
<leader>fc | replaceInFiles         | replace word in all files |
<leader>R  | startFindReplaceAction | open find and replace     |

## Code Shortcuts

Key                    | Command | Description
-----------------------|---------|-------------------------------------
(ctrl/cmd) + shift + L |         | selects all matches of selected word
(ctrl/cmd) + j         |         | toggle terminal
, t                    |         | exit out of file explorer

<!-- gh: equivalent to hovering your mouse over wherever the cursor is. Handy for seeing types and error messages without reaching for the mouse! -->
<!-- af - visual mode command which selects increasingly large blocks of text. For example, if you had "blah (foo [bar 'ba|z'])" -->