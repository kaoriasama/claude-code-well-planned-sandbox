# 新規プロジェクト作成ガイド（2回目以降）

すでに初回セットアップが完了している人向けのガイドです。  
新しいプロジェクト用のサンドボックス環境を追加します。

---

## 所要時間：約2分

---

## Step 1：テンプレートをコピー

このリポジトリの `factory/` フォルダを `~/ClaudeWorkspace/` にコピーし、名前を変更します。

```bash
cp -r factory ~/ClaudeWorkspace/（新しいプロジェクト名）
```

例：

```bash
cp -r factory ~/ClaudeWorkspace/new_project_name
```

---

## Step 2：Desktop App の Filesystem 設定を更新

1. Claude Desktop App → Settings → Extensions
2. Filesystem の設定を開く
3. アクセス許可フォルダに新しいプロジェクトを**追加**

```
~/ClaudeWorkspace/new_project_name
```

※ 既存プロジェクトの設定は残したままで OK

---

## Step 3：CLAUDE.md をカスタマイズ（任意）

新しいプロジェクトの `CLAUDE.md` を編集して、プロジェクト固有の制約を追加：

```bash
nano ~/ClaudeWorkspace/（新しいプロジェクト名）/CLAUDE.md
```

例：

```markdown
## Project Specific
- このプロジェクトは自然言語処理に特化
- 多言語テキストを扱う
- 出力は日本語
```

---

## Step 4：動作確認

```bash
cd ~/ClaudeWorkspace/（新しいプロジェクト名）
claude
```

```
CLAUDE.md の内容を見せてください
```

---

## 複数プロジェクトの並行運用

異なるターミナルタブで、それぞれのプロジェクトフォルダに `cd` して `claude` を起動すれば、独立したセッションとして動作します。

```
ターミナル タブ1                    ターミナル タブ2
─────────────────────              ─────────────────────
cd ~/ClaudeWorkspace/project-a     cd ~/ClaudeWorkspace/project-b
claude                             claude
```

---

## プロジェクト完了時

```bash
mv ~/ClaudeWorkspace/（プロジェクト名） ~/ClaudeWorkspace/archive/
```

Desktop App の Filesystem 設定から該当フォルダを削除することを推奨。

---

## ローカル環境の全体像

```
~/ClaudeWorkspace/
├── project-a/          # アクティブ
├── project-b/          # アクティブ
├── project-c/          # アクティブ
└── archive/
    ├── old-project-1/  # 完了済み
    └── old-project-2/  # 完了済み
```
