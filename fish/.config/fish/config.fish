if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set the cursor shapes for the different vi modes.
# set fish_cursor_default     block
# set fish_cursor_insert      block   blink
# set fish_cursor_replace_one underscore

# Fish Default Keybindings(emacs)
fish_default_key_bindings

# set fish_greeting

function fish_title
    echo $TERM
end

# Environment variable
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_DATA_DIRS /usr/local/share:/usr/share
set -gx DENO_INSTALL $HOME/.deno
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf
set -gx CUDA_CACHE_PATH $XDG_CACHE_HOME/nv
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx EDITOR nvim

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH
# set -gx BUN_INSTALL $HOME/.bun
set -gx BUN_INSTALL $XDG_DATA_HOME/bun


# Add path variable
fish_add_path $HOME/.local/bin --append
fish_add_path $DENO_INSTALL/bin
fish_add_path $HOME/.local/share/JetBrains/Toolbox/scripts
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.local/zig

# Node Version Manager
source $HOME/.config/asdf/asdf.fish

starship init fish | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/stoney/.ghcup/bin $PATH # ghcup-env
