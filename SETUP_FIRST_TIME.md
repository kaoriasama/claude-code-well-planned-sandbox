# Claude Code 安全環境構築ガイド（初回セットアップ）

初めて Claude Code を使う人向けの環境構築ガイドです。  
「速度より安全性」を優先した設計になっています。

---

## 前提条件

- macOS（Apple Silicon 推奨）
- Claude Pro / Max サブスクリプション
- ターミナルの基本操作（`cd`, `ls`, `mkdir`）ができる

---

## Step 1：Claude Code のインストール

### 1-1. Homebrew がなければインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 1-2. Node.js のインストール

```bash
brew install node
```

### 1-3. Claude Code のインストール

```bash
brew install anthropic/tap/claude-code
```

### 1-4. 初回認証

```bash
claude
```

ブラウザが開くので Claude.ai アカウントでログイン。  
認証完了後、`Ctrl+C` で一旦終了。

---

## Step 2：ディレクトリ構造の作成

```bash
mkdir -p ~/ClaudeWorkspace
mkdir -p ~/ClaudeWorkspace/archive
```

構造：

```
~/ClaudeWorkspace/
├── (プロジェクトフォルダをここに配置)
└── archive/           # 完了したプロジェクトの退避先
```

---

## Step 3：テンプレートの配置

このリポジトリの `factory/` フォルダを `~/ClaudeWorkspace/` にコピーします。

```bash
cp -r factory ~/ClaudeWorkspace/
```

必要に応じてフォルダ名を変更（例：`project_1`）：

```bash
mv ~/ClaudeWorkspace/factory ~/ClaudeWorkspace/project_1
```



---

## Step 3.5：Hook スクリプトに実行権限を付与


```bash
chmod +x ~/ClaudeWorkspace/factory/.claude/hooks/check_package_install.sh
```

成功時は何も表示されません。確認:

```bash
ls -la ~/ClaudeWorkspace/factory/.claude/hooks/check_package_install.sh
```

`-rwxr-xr-x` のように `x` が含まれていれば OK です。

---

## Step 4：Desktop App の設定（CLAUDE.md 共有用）

CLI と Desktop App が同じ CLAUDE.md を参照できるようにします。

### 4-1. Claude Desktop App を開く

### 4-2. Settings → Extensions

### 4-3. Filesystem 拡張機能を有効化

- アクセス許可フォルダに `~/ClaudeWorkspace/（プロジェクト名）` を指定
- **プロジェクトフォルダのみ**を指定すること（ホームディレクトリ全体は NG）

### 4-4. 運用ルール

Desktop App が提案する以下の操作は**拒否**してください：

- ファイルの編集
- ファイルの作成
- ファイルの削除

**許可するのは「読み取り」のみ**です。

---

## Step 5：動作確認

### 5-1. CLI の確認

```bash
cd ~/ClaudeWorkspace/（プロジェクト名）
claude
```

起動後、以下を試す：

```
CLAUDE.md の内容を見せてください
```

内容が表示されれば成功。

### 5-2. Desktop App の確認

Desktop App で：

```
~/ClaudeWorkspace/（プロジェクト名）/CLAUDE.md を読んでください
```

許可を求められたら「Allow」→ 内容が表示されれば成功。


---
### Step 7: CLAUDE.md の編集

`factory/CLAUDE.md` をテキストエディタで開き、
`## Environment` セクションを自分の環境に合わせて編集します。


---

## 基本ワークフロー

```
┌─────────────────────────────────────────────────────┐
│ Desktop App（計画立案）                              │
│                                                     │
│ 「CLAUDE.mdを読んで、以下のタスクの計画を立てて」    │
│           ↓                                         │
│   [Allow] で読み取り許可                            │
│           ↓                                         │
│   最新の制約を反映した計画を出力                     │
└─────────────────────────────────────────────────────┘
                        ↓ コピー
┌─────────────────────────────────────────────────────┐
│ CLI（実行）                                          │
│                                                     │
│ cd ~/ClaudeWorkspace/（プロジェクト名）              │
│ claude                                              │
│ 計画を貼り付けて実行                                 │
│ サンドボックス内で安全に動作                         │
└─────────────────────────────────────────────────────┘
```


---



## 覚えておくと便利なこと

### スラッシュコマンド

基本的に覚える必要はありません。Desktop App が計画に含めてくれます。

ただし `/compact`（コンテキスト圧縮）は長いセッションで役立ちます。

### セッション終了時の習慣

```
今回のセッションで学んだことを CLAUDE.md の Lessons Learned に追記してください
```

---

## トラブルシューティング

### 「Permission denied」エラー

`settings.json` の `allow` に必要な権限があるか確認。

### 書き込みがブロックされる

サンドボックスが正常に動作している証拠。  
`Write(./**)` が `allow` に含まれているか確認。

### Desktop App でハンマーアイコンが出ない

Settings → Extensions で Filesystem が有効か確認。

### `claude: command not found`

PATH が通っていません。以下を試してください:

```bash
# インストール先を探す
which claude
ls ~/.local/bin/claude
ls ~/.claude/bin/claude
```

見つかったパスを PATH に追加:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Hook が動作しない

改行コードを確認してください:

```bash
file ~/ClaudeWorkspace/factory/.claude/hooks/check_package_install.sh
```

「with CRLF line terminators」と出た場合:

```bash
sed -i '' 's/\r$//' ~/ClaudeWorkspace/factory/.claude/hooks/check_package_install.sh
```


---

## 次のステップ

2つ目以降のプロジェクトを作成する場合は `SETUP_NEW_PROJECT.md` を参照してください。
