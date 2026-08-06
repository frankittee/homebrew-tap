# Homebrew Tap

这是一个个人 Homebrew tap 仓库，可用于发布 Formula（命令行工具）和 Cask（macOS 应用）。

## 安装

将下面的 `<github-user>` 和 `<tap-name>` 替换为实际的 GitHub 用户名与仓库名。

```bash
brew tap <github-user>/<tap-name>
```

如果仓库名采用推荐格式 `homebrew-<tap-name>`，用户也可以直接安装其中的软件：

```bash
brew install <github-user>/<tap-name>/<formula>
brew install --cask <github-user>/<tap-name>/<cask>
```

### sing-box

本 tap 中的 sing-box 自动跟踪上游最新预发布版，包括 Alpha、Beta 或 RC：

```bash
brew install frankittee/tap/sing-box
```

如需安装稳定版，请直接使用 Homebrew Core：

```bash
brew install sing-box
```

预发布版由 `.github/workflows/update-sing-box.yml` 每天自动检查。发现新版本时，工作流会验证对应的 macOS/Linux、ARM64/AMD64 Release 资源及 SHA-256，然后更新 Formula 并提交。

## 仓库结构

```text
Formula/                 # Ruby Formula 文件
Casks/                   # Ruby Cask 文件
.github/workflows/       # Homebrew CI
templates/               # 新增 Formula/Cask 时使用的模板
```

## 发布 Formula

1. 复制 `templates/formula.rb.example` 到 `Formula/<name>.rb`。
2. 填写项目主页、源码归档 URL、SHA-256 和安装逻辑。
3. 在本地运行：

```bash
brew audit --strict --new-formula Formula/<name>.rb
brew install --build-from-source Formula/<name>.rb
brew test <name>
```

## 发布 Cask

1. 复制 `templates/cask.rb.example` 到 `Casks/<name>.rb`。
2. 填写下载地址、SHA-256、版本和应用名称。
3. 在本地运行：

```bash
brew audit --strict --new-cask Casks/<name>.rb
brew install --cask Casks/<name>.rb
```

## 更新版本

更新对应文件中的 `url`、`version` 和 `sha256`，然后提交。CI 会执行 Homebrew 的审计与测试。
