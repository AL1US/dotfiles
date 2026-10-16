if status is-interactive
# Commands to run in interactive sessions can go here
set fish_greeting
# Default Proxy (127.0.0.1:10808)
end

# --- niri: автопереключение раскладки на английский для sudo -----------
# Номера раскладок смотри: niri msg keyboard-layouts
# (у тебя 0 = English (US), 1 = Russian)
set -g NIRI_EN_LAYOUT 0

function __niri_layout_idx
    niri msg -j keyboard-layouts 2>/dev/null | string match -r '"current_idx":\s*\K\d+'
end

function sudo --description 'sudo с автоматическим переключением раскладки на английский'
    set -l prev (__niri_layout_idx)
    set -l need false
    if test -n "$prev"; and test "$prev" != "$NIRI_EN_LAYOUT"
        set need true
        niri msg action switch-layout $NIRI_EN_LAYOUT 2>/dev/null
    end
    command sudo $argv
    set -l rc $status
    if test $need = true
        niri msg action switch-layout $prev 2>/dev/null
    end
    return $rc
end

# --- uv / pipx / local bin в PATH ---
fish_add_path "$HOME/.local/bin"
