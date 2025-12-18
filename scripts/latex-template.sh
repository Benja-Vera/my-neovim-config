#!/usr/bin/env bash
set -e

TEMPLATES="$HOME/.config/nvim/templates"
TEMPLATE="$1"
TARGET="$2"

if [ -z "$TEMPLATE" ] || [ -z "$TARGET" ]; then
  echo "Usage: latex-template <template> <target-dir>"
  exit 1
fi

cp -r "$TEMPLATES/$TEMPLATE" "$TARGET"
