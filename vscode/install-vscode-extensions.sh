#!/bin/bash

# install all packages for vscode

package_list={
2gua.rainbow-brackets
Angular.ng-template
Dart-Code.dart-code
Dart-Code.flutter
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
eamodio.gitlens
eg2.vscode-npm-script
esbenp.prettier-vscode
infeng.vscode-react-typescript
johnpapa.Angular2
k--kato.intellij-idea-keybindings
leo-labs.dotnet
MellowMarshmallow.groovy
ms-azuretools.vscode-docker
ms-dotnettools.csharp
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-vscode.cpptools
streetsidesoftware.code-spell-checker
VisualStudioExptTeam.vscodeintellicode
vscode-icons-team.vscode-icons
vscodevim.vim
}

for i in ${package_list[@]}; do
  code --install-extension $i
done
