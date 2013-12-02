# Daniele Bellavista's Linux stuff

## Directories
1. __bash__: configuration for bash (bashrc, bash\_profile and so on...)
1. __config__: various configuration and templates, such as MoC and cmake.
2. __scripts__: utility scripts
3. __shell__: common configuration for shells (aliases, environment and functions).
3. __templates__: various template (tex, YouCompleteMe, Makefiles)
3. __vim__: vim configuration
3. __X__: X windows manager and desktop environment configuration
3. __zsh__: configuration for zsh

## How to install

The python script `install_configuration.py` provides a quick way to install
the configuration by means of symlinks.

The VIM plugins (in `vim/vim/bundle`) are all submodule! Remember to launch

```
git submodule init && git submodule update --init --recursive && git submodule foreach git pull origin master
```
