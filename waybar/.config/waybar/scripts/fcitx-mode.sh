#!/usr/bin/env bash
# Waybar custom module: fcitx5 input-method indicator.
# fcitx5-remote exit-state: 0 = no IM, 1 = inactive (direct/English), 2 = active (あ/Mozc).
case "$(fcitx5-remote 2>/dev/null)" in
    2) printf '{"text":"あ","tooltip":"日本語 (Mozc)","class":"active"}\n' ;;
    1) printf '{"text":"A","tooltip":"English (Direct)","class":"inactive"}\n' ;;
    *) printf '{"text":"","tooltip":"Input method off","class":"off"}\n' ;;
esac
