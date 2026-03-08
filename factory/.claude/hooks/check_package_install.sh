#!/bin/bash

# Claude Code Hook: パッケージインストールコマンドの検査
# PreToolUse で Bash コマンド実行前に呼ばれる

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | grep -o '"command":"[^"]*"' | sed 's/"command":"//;s/"$//')

# --- curl | bash パターンの完全ブロック ---
if echo "$COMMAND" | grep -qE 'curl\s+.*\|\s*(bash|sh|zsh)'; then
  echo '{"decision":"block","reason":"curl | bash パターンは禁止されています。スクリプトの内容を確認してから実行してください。"}'
  exit 0
fi

# --- npm/npx/pip コマンドの検査 ---
if echo "$COMMAND" | grep -qE '(npm install|npm i |npx |pip install|pip3 install)'; then

  # --ignore-scripts なしの npm install をブロック
  if echo "$COMMAND" | grep -qE 'npm (install|i) ' && ! echo "$COMMAND" | grep -q '\-\-ignore-scripts'; then
    echo '{"decision":"block","reason":"npm install には --ignore-scripts を付けてください。postinstall スクリプトによる自動コード実行を防ぎます。"}'
    exit 0
  fi

  # 複数パッケージの一括インストールをブロック
  PACKAGES=$(echo "$COMMAND" | sed -E 's/.*npm (install|i) //' | sed 's/--[^ ]*//g' | xargs)
  PACKAGE_COUNT=$(echo "$PACKAGES" | wc -w | xargs)
  if [ "$PACKAGE_COUNT" -gt 1 ]; then
    echo '{"decision":"block","reason":"パッケージは一つずつインストールしてください。一括インストールでは個別の検証が困難です。"}'
    exit 0
  fi

  # npx をブロック
  if echo "$COMMAND" | grep -qE '(^|\s)npx\s'; then
    echo '{"decision":"block","reason":"npx は検証なしに外部コードを実行します。npm install で検証済みパッケージをインストールしてから実行してください。"}'
    exit 0
  fi

fi

# --- eval のブロック ---
if echo "$COMMAND" | grep -qE '\beval\b'; then
  echo '{"decision":"block","reason":"eval を含むコマンドは安全性の確認が困難です。別の方法を検討してください。"}'
  exit 0
fi

# --- 検査通過 ---
echo '{"decision":"approve"}'
exit 0
