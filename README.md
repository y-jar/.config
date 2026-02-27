This is the start of my config file journey



## Direct Install

If you don't have Node.js installed, use these commands to pull specific configs directly into your ~/.config folder.
Neovim Config
```Bash
mkdir -p ~/.config/nvim && curl -L https://github.com/y-jar/.config/tarball/main/nvim | tar -xz -C ~/.config/nvim --strip-components=1
```

Fastfetch Config
```Bash
mkdir -p ~/.config/fastfetch && curl -L https://github.com/y-jar/.config/tarball/main/fastfetch | tar -xz -C ~/.config/fastfetch --strip-components=1
```

Kitty Config
```Bash
mkdir -p ~/.config/kitty && curl -L https://github.com/y-jar/.config/tarball/main/kitty | tar -xz -C ~/.config/kitty --strip-components=1
```
