#!/bin/bash
# 雙擊本檔即可將此資料夾推送到 GitHub（使用你已安裝並登入的 gh）。
cd "$(dirname "$0")" || exit 1

echo "==> 目錄：$(pwd)"

if ! command -v gh >/dev/null 2>&1; then
  echo "找不到 gh (GitHub CLI)。請先安裝：brew install gh"; exit 1
fi

# 確認已登入
gh auth status >/dev/null 2>&1 || { echo "gh 尚未登入，請先執行：gh auth login"; exit 1; }

git init -q
git add -A
git commit -q -m "Add ggb-create-macro skill" 2>/dev/null || echo "(無新變更可提交)"
git branch -M main

REMOTE="https://github.com/lochiwei/ggb-create-macro.git"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE"
else
  git remote add origin "$REMOTE"
fi

echo "==> 推送中..."
if git push -u origin main; then
  echo "✅ 完成：$REMOTE"
else
  echo "一般推送失敗，可能遠端已有不同歷史。如要強制覆蓋，執行："
  echo "    git push -u origin main --force"
fi

echo ""
read -n 1 -s -r -p "按任意鍵關閉..."
