# dotfiles

[![Security Policy](https://img.shields.io/badge/Security-Policy-blue?style=flat-square&logo=github)](.github/SECURITY.md)
[![Dependabot Enabled](https://img.shields.io/badge/Dependabot-Enabled-brightgreen?style=flat-square&logo=dependabot)](https://github.com/skyblueao77/dotfiles/security)
[![Secret Scanning](https://img.shields.io/badge/Secret_Scanning-Active-success?style=flat-square&logo=github)](https://github.com/skyblueao77/dotfiles/security)

WSL2（Ubuntu）で使うシェル、Git、SSH、プロンプトの設定と、開発環境の初期セットアップスクリプトを管理するリポジトリです。

## 構成

```text
.
├── fish/
│   └── config.fish          # Fish の設定、エイリアス、各ツールの初期化
├── git/
│   └── gitconfig             # Git の共通設定
├── ssh/
│   └── config                # GitHub SSH 接続設定（443番ポート）
├── starship/
│   └── starship.toml         # Starship の設定
├── scripts/
│   ├── bootstrap.sh          # 全セットアップの一括実行
│   ├── packages.sh           # APT パッケージの導入
│   ├── setup-node.sh         # Node.js LTS の導入
│   ├── setup-runtimes.sh     # uv、Juliaup、Starship の導入
│   └── setup-links.sh        # 設定ファイルのシンボリックリンク作成
├── .gitignore
└── README.md
```

## 管理している設定

- **Fish**: `~/.config/fish/config.fish`
  - `eza`、`bat`、`fd` のコマンド名・エイリアスを設定
  - `zoxide`、`fzf`、Starship を利用可能な場合に初期化
  - `~/.local/bin` を PATH に追加
- **Git**: `~/.gitconfig`
  - デフォルトブランチ、改行コード、push、SSH署名、Git LFS などを設定
  - 個人情報を含む `git/gitconfig.local` があれば `~/.gitconfig.local` として追加読み込み
- **SSH**: `~/.ssh/config`
  - GitHub を `ssh.github.com:443` 経由で接続
  - 秘密鍵は管理せず、`~/.ssh/id_ed25519` を参照
- **Starship**: `~/.config/starship.toml`
  - スキャンタイムアウトを設定

## 導入されるツール

### APT パッケージ

`scripts/packages.sh` で次のパッケージを導入します。

`bat`、`build-essential`、`ca-certificates`、`cmake`、`curl`、`eza`、`fd-find`、`fish`、`fzf`、`git`、`git-lfs`、`gnupg`、`jq`、`make`、`ninja-build`、`ripgrep`、`rsync`、`sqlite3`、`tree`、`unzip`、`wget`、`zip`、`zoxide`

パッケージ導入後、`git lfs install` も実行します。

### ランタイム・開発ツール

- **Node.js 24.x LTS**（NodeSource 経由。`npm` も導入）
- **uv**（Python の環境・パッケージ管理）
- **Juliaup**（Julia のバージョン管理）
- **Starship**（プロンプト）

## セットアップ

### 前提

- WSL2 の Ubuntu
- `sudo` が利用可能であること
- インターネット接続
- GitHub 用の SSH 鍵を別途用意していること

`setup-links.sh` は設定ファイルの場所として `~/dotfiles` を参照します。したがって、現在のスクリプトをそのまま使う場合は、リポジトリを `~/dotfiles` に配置してください。

```bash
git clone https://github.com/skyblueao77/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 一括セットアップ

パッケージ、Node.js、開発ツール、シンボリックリンクを順番に設定します。

```bash
bash scripts/bootstrap.sh
```

処理内容は次の順序です。

1. `scripts/packages.sh` — APT パッケージと Git LFS
2. `scripts/setup-node.sh` — Node.js 24.x LTS と npm
3. `scripts/setup-runtimes.sh` — uv、Juliaup、Starship
4. `scripts/setup-links.sh` — 各設定ファイルのリンク

### 個別セットアップ

必要な処理だけ実行する場合は、次のスクリプトを使います。

```bash
bash scripts/packages.sh
bash scripts/setup-node.sh
bash scripts/setup-runtimes.sh
bash scripts/setup-links.sh
```

## シンボリックリンクとバックアップ

`scripts/setup-links.sh` は次のファイルをリンクします。

- `fish/config.fish` → `~/.config/fish/config.fish`
- `git/gitconfig` → `~/.gitconfig`
- `git/gitconfig.local`（存在する場合） → `~/.gitconfig.local`
- `ssh/config` → `~/.ssh/config`
- `starship/starship.toml` → `~/.config/starship.toml`

既存のファイルやリンクがある場合は、`~/.dotfiles-backup/` に移動してからリンクを作成します。すでに正しいリンクがある場合は変更しません。

セットアップ後は新しい設定を読み込むため、Fish を起動します。

```bash
exec fish
```

## ローカル設定と機密情報

個人ごとの Git 設定は `git/gitconfig.local` に記述できます。このファイルは `.gitignore` 対象です。

SSH 秘密鍵、API キー、パスワード、`known_hosts`、Fish の実行時状態などもコミットしないよう `.gitignore` で除外しています。SSH 秘密鍵はこのリポジトリに配置せず、利用環境側で設定してください。

## 動作確認

```bash
ssh -T git@github.com
git config --global --list
node --version
npm --version
uv --version
juliaup --version
starship --version
```
