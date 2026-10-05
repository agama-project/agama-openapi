#! /bin/bash
set -euo pipefail

# Disable patsub_replacement (Bash 5.2+) so '&' in passwords is treated literally
# rather than being replaced with the matched pattern string.
shopt -u patsub_replacement 2>/dev/null || true

# This helper script creates the "osc" configuration file with OBS credentials

CONFIG_FILE="$HOME/.config/osc/oscrc"

# do not overwrite the existing config accidentally
if [ -e "$CONFIG_FILE" ]; then
  echo "ERROR: $CONFIG_FILE already exists"
  exit 1
fi

TEMPLATE=$(dirname "${BASH_SOURCE[0]}")/oscrc.template
mkdir -p "$(dirname "$CONFIG_FILE")"
umask 077
template_content=$(<"$TEMPLATE")
content="${template_content//@OBS_USER@/$OBS_USER}"
content="${content//@OBS_PASSWORD@/$OBS_PASSWORD}"
printf '%s\n' "$content" > "$CONFIG_FILE"
