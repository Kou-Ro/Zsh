# Read color config
COLORS=(7 93)
COLORPATH="$ZDOTDIR/config/color"

readColor() {
  if [[ -e "$COLORPATH" ]]; then
    while read -r LINE || [ -n "${LINE}" ]; do
      if [[ ! "$(print "$LINE" | awk '{ print $1 }')" =~ ^# ]]; then
        if [[ "$(print "$LINE" | awk '{ print $1 }')" =~ ^COLOR[0-9]\{1,3\}$ && "$(print "$LINE" | awk '{ print $1 }')" != "COLOR0" ]]; then
          if [[ "$(print "$LINE" | awk '{ print $2 }')" =~ ^[0-9]+$ && "$(print "$LINE" | awk '{ print $2 }')" -le 255 ]]; then
            COLORS[$(print "$LINE" | awk '{ print $1 }' | sed -E "s/(COLOR)([0-9]+$)/\2/")]=$(print "$LINE" | awk '{ print $2 }')
          fi
        fi
      fi
    done <"$COLORPATH"
  fi
}

# output text with foreground color
# $1: input text
# $2: color
setFore() {
  echo "%F{$2}$1%f"
}

# output text with background color
# $1: input text
# $2: color
setBack() {
  echo "%K{$2}$1%k"
}

# output user info with color
user() {
  echo "$(setBack "$(setFore "%n@%m" "${COLORS[1]}")" "${COLORS[2]}")$(setBack "$(setFore "" "${COLORS[2]}")" "${COLORS[1]}")"
}

# output current directory info with color
dir() {
  echo "$(setBack "$(setFore " %~" "${COLORS[2]}")" "${COLORS[1]}")$(setFore "" "${COLORS[1]}")"
}

# output PROMPT
prompt() {
  readColor
  echo "$(user)$(dir) "
}

# unset variables and functions
unsets() {
  unset -v COLORS
  unset -v COLORPATH
  unset -f readColor
  unset -f setFore
  unset -f setBack
  unset -f user
  unset -f dir
  unset -f prompt
}