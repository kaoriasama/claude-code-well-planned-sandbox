# Claude Code Well-Planned Sandbox

非エンジニア向けの、安全性を最優先した Claude Code サンドボックス環境テンプレートです。
プログラミング経験がなくても Claude Code を使い始められることを想定して設計しました。

Windows 環境で Claude Code 環境がない場合は、SETUP_FIRST_TIME.md を Claude（チャットモード）に渡して書き直させてください（自己責任でお願いします）。


## 設計思想

- 速度よりも安全性とユーザーのコントロールを優先する
- すべての操作にユーザーの明示的な許可を求める
- プロジェクトごとにサンドボックスを立てる
- 計画と実行の分離（Opus thinking 以上推奨）
- 計画に最大の時間を使う

## 主な構成

- **基本方針**: サンドボックスによるファイルシステム分離、全Bashコマンドの許可制実行、 ファイルシステム分離、Auto-Accept 不使用、Permission Bypass 無効化。Claudeが作業ディレクトリ外に影響を与えることを防ぎます。
- **PLANNING_FLOW.md**: タスクの目的把握からリスク評価、実行中の逸脱対応までをカバーする計画策定フレームワーク。Agent が項目の省略やフェーズの跳躍を判断しながら、ユーザーと対話的に計画を練り上げる
- **Package Installation Protocol**: サプライチェーン攻撃・タイポスクワッティング対策。パッケージの同定手順と pre-execution hooks による機械的なコマンド検査
- **settings.json**: 認証情報へのアクセス拒否、ネットワーク系コマンドの遮断、MCP 自動有効化の無効化


## 技術的に正直な注記

このテンプレートは Claude Code の既存セキュリティ機能（サンドボックス、許可制、Hooks）を正しく有効化・設定するものです。独自の高度なセキュリティ技術を提供するものではありません。防御の実質的な強度は Claude Code 本体のサンドボックス機能に依存します。

## 使い方

1. **[SETUP_FIRST_TIME.md](SETUP_FIRST_TIME.md)** — 初回の環境構築
2. **[SETUP_NEW_PROJECT.md](SETUP_NEW_PROJECT.md)** — 2つ目以降のプロジェクト作成

## 参考

Boris Cherny 氏の Plan Mode　重視の思想（https://x.com/bcherny/status/2007179832300581177?s=20 ）を参考にしつつ、非エンジニア向けの安全で理解負債を小さくする環境を目指し、「計画→承認→実行」の対話的なフローを採用しています。


