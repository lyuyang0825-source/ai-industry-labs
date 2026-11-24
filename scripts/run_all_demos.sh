#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== clinote（医疗文书质控）"
cd products/clinote
python3 -m clinote.cli -i samples/outpatient_zh_01.txt --out-dir demo_out
python3 -m clinote.cli -i samples/outpatient_zh_02_bad.txt --out-dir demo_out
cd "$ROOT"

echo "== shorts-factory（短视频生产）"
cd products/shorts_factory
if command -v ffmpeg >/dev/null 2>&1; then
  python3 -m shorts_factory.cli --brief samples/brief_zh_01.json --out-dir demo_out --render
else
  echo "未安装 ffmpeg，跳过样片渲染"
  python3 -m shorts_factory.cli --brief samples/brief_zh_01.json --out-dir demo_out
fi
cd "$ROOT"

echo "== support-copilot（AI 客服）"
cd products/support_copilot
python3 -m support_copilot.cli --lint
python3 -m support_copilot.cli --demo
python3 -m support_copilot.cli --eval data/tickets/ticket_01_good.json
cd "$ROOT"

echo "== driveloop（智驾长尾场景）"
cd products/driveloop
python3 -m driveloop.cli --demo
cd "$ROOT"

echo
echo "全部 demo 完成："
echo "  products/clinote/demo_out/"
echo "  products/shorts_factory/demo_out/"
echo "  products/support_copilot/demo_out/"
echo "  products/driveloop/demo_out/report.html"
