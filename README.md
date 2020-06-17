# Dotfiles

My BASH + Vim configuration for home usage.

*This is not a completed auto-configuration that makes magic changes in system. This is just a couple of files. If you want to use this configuration you have to install all needed apt packages and vim plugins manually one by one. They are listed in comments in the files. You must understand what are you doing and what are you installing. If you don't understand where to place these files in your system or how to install the recommended packages, you probably shouldn't use this configuration.*


## Features
### .bashrc
- Custom BASH prompt
- Various useful aliases and functions for everyday tasks
- Improved HISTORY setttings
- Informative titles for terminal
- Gems from home directory and snap packages added to the PATH

The full list of installed packages is in the comments in *bashrc*.


### .vimrc
- Tabs -> 4 spaces by default
- UNIX line endings by default
- Editorconfig
- Syntax highlighting (HTML, Pug, Liquid, CSS, modern JS)
- NERDTree
- Airline
- Omni auto-completion
- Syntastic
- ESLint
- Stylelint
- Grammar checker

The full list of recommended packages to install (with links to GitHub) and colors for vim and for terminal are described in comments in *vimrc*.


### Other configs

Previously, this repository included .eslint, .stylelint and .gitignore files. I rejected the idea to have global configs like these. They should be adapted for the concrete project. Check out the <a href='https://github.com/sfi0zy/promo-core'>promo-core</a> boilerplate as an example of my recent base configuration for front-end projects.


## LICENSE

MIT License

Copyright (c) 2018-2020 Ivan Bogachev

