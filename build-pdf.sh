#!/usr/bin/env bash
# 로컬 미리보기용: 페이지의 인쇄용(A4) 레이아웃으로 resume.pdf를 만듭니다.
# 배포되는 PDF는 GitHub Actions(.github/workflows/deploy.yml)가 push 때마다 자동으로 만들므로,
# 이 스크립트는 push 전에 결과를 미리 확인하고 싶을 때만 쓰면 됩니다. (resume.pdf는 git에 올라가지 않음)
# 사용법: Git Bash에서  ./build-pdf.sh
set -euo pipefail
cd "$(dirname "$0")"

CHROME=""
for c in \
  "/c/Program Files/Google/Chrome/Application/chrome.exe" \
  "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
  "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
  "/c/Program Files/Microsoft/Edge/Application/msedge.exe"; do
  if [ -f "$c" ]; then CHROME="$c"; break; fi
done
[ -n "$CHROME" ] || { echo "Chrome 또는 Edge를 찾을 수 없습니다." >&2; exit 1; }

DIR="$(pwd -W 2>/dev/null || pwd)"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=5000 \
  --print-to-pdf="$DIR/resume.pdf" \
  "file:///$DIR/index.html" 2>/dev/null

echo "resume.pdf 생성 완료"
