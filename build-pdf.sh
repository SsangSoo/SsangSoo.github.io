#!/usr/bin/env bash
# index.html 내용을 바꾼 뒤 실행하면, 페이지의 인쇄용(A4) 레이아웃으로 resume.pdf를 다시 만듭니다.
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
