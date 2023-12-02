#!/bin/sh
echo -ne '\033c\033]0;Hand of the Gods\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/hand-of-the-gods.x86_64" "$@"
