#!/usr/bin/env bash
# Installs Flutter directly from the flutter/flutter git repo, pinned to
# the same version CI uses (see .github/workflows/build-apk.yml), instead
# of relying on a third-party devcontainer feature.
set -euo pipefail

REPO_DIR="$(pwd)"
FLUTTER_VERSION="3.47.2"
INSTALL_DIR="$HOME/flutter"

# If a previous attempt (ours or the Dart extension's) left a partial/broken
# clone behind, remove it so we can clone cleanly instead of erroring out.
if [ -d "$INSTALL_DIR" ] && [ ! -d "$INSTALL_DIR/.git" ]; then
  rm -rf "$INSTALL_DIR"
fi

if [ ! -d "$INSTALL_DIR" ]; then
  git clone https://github.com/flutter/flutter.git -b stable "$INSTALL_DIR"
fi

(
  cd "$INSTALL_DIR"
  git fetch --tags --quiet
  git checkout "$FLUTTER_VERSION" --quiet
)

if ! grep -q 'flutter/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/flutter/bin:$PATH"' >> "$HOME/.bashrc"
fi

export PATH="$INSTALL_DIR/bin:$PATH"

flutter config --no-analytics
flutter precache

cd "$REPO_DIR"
flutter pub get
