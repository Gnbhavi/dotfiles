# ================================================
# FISH CONFIG - PORTABLE DEV SETUP (Python • LaTeX • Rust)
# Just copy this one file anywhere and you're ready to code
# ================================================

# 1. PATH (Homebrew + common dev paths)
# fish_add_path /opt/homebrew/bin          # mac
fish_add_path /usr/local/bin
fish_add_path ~/.cargo/bin # Rust (will be created later)
fish_add_path ~/.local/bin

# 2. Editor (you already love nvim)
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

# 3. Emacs mode (your old zsh was emacs - keep it simple & fast)
fish_default_key_bindings

# ================================================
# 4. Prompt: Tide (clean, modern, git-aware, fast)
# Run `tide configure` once after this block to customize
# ================================================

# If Tide is not installed yet → install it automatically (one-time)
if not type -q tide
    fisher install IlanCosman/tide@v6
    echo "Tide installed — now run: tide configure"
end

# ================================================
# 5. Fuzzy magic: fzf + previews + clean cd tab
# ================================================

# Install fzf.fish if missing (best fzf integration for fish)
if not type -q fzf_configure_bindings
    fisher install PatrickF1/fzf.fish
end

# Load fzf base + plugin bindings
fzf --fish | source

# --- FZF PREVIEWS WITH BAT, PDF, IMAGES ---

# --- FZF PREVIEWS CLEAN (no images) ---
set -Ux FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target,.DS_Store
  --preview 'if test -d {}; ls --color=always {}; \
             else if string match -r \".*\\.pdf\" {}; pdftotext {} - | head -n 50; \
             else bat --style=numbers --color=always --line-range :500 {}; end'
  --preview-window=right:60%
  --bind 'shift-up:preview-page-up,shift-down:preview-page-down'"
# --------------------------------------
# ------------------------------------------

# --- ZOXIDE (smart cd) ---
if not type -q zoxide
    fisher install ajeetdsouza/zoxide
end
#
zoxide init fish --cmd cd | source
# -------------------------
#
#
# --- BAT (better cat) ---
if not type -q bat
    echo "Install bat with: brew install bat  # macOS"
end

alias cat="bat --style=plain --paging=never"
# --------------------------------------------
#
#
# --- EXA (modern ls) ---
if not type -q eza
    echo "Install eza "
end

alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias la="eza -la --icons --group-directories-first"
# -----------------------------------------------
#
#
# --- My fixed color overrides ---
function my_colors
    set -U fish_color_error red
    set -U fish_color_command green
    set -U fish_color_param white
    set -U fish_color_comment yellow
    set -U fish_color_autosuggestion brgrey
end

# Run after Tide initializes
if functions -q tide
    my_colors
end

abbr -a nvim_test 'env NVIM_APPNAME=nvim-test nvim'

if not type -q yazi
    echo "Install Yazi"
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end
