# AI Industry Labs

四个行业、四个能跑起来的 AI 产品原型。不是 PPT，也不是“调个 API 的 demo”——每个产品都有明确的行业问题、可复现的输入输出、单元测试和一份说清边界的 README。

```
products/
├── clinote/          医疗：中文病历结构化 + 可溯源质控
├── shorts-factory/   短视频：选题 → 分镜 → 字幕/多平台 → 合规 → 样片
├── support-copilot/  AI 客服：可溯源回答 + 该转人工就转 + 会话质检
└── driveloop/        智能驾驶：长尾场景挖掘 → 场景卡 → OSC → 回归门禁
```

## 四个产品，四种“AI 该干的活”

| 产品 | 行业核心问题 | 产品做的事 | 不做的事 |
| --- | --- | --- | --- |
| **clinote** | 医生 43.2% 有 burnout，每周 13 小时用于间接诊疗；AI 病历会把“讨论过的检查”写成“已执行” | 把自由文本病历拆成 SOAP 与事实，跑 11 条规则，每条问题都带原文位置 | 不诊断、不开药、不替代医生签字 |
| **shorts-factory** | 2026 Q1 上线 12.8 万部微短剧，95% 是 AI 生成，但破亿率不足 0.2%——产能过剩、精品稀缺 | 把一句选题变成 19 镜分镜、口播稿、SRT、五平台规格、合规检查，并渲染出可看的样片 | 不承诺爆款，不替代编导的审美判断 |
| **support-copilot** | 2025 年上海消保委受理 AI 客服投诉 1087 件；某教育公司上线 AI 后满意度 -15%、转人工率 20%→45% | BM25 检索 + 强制转人工策略 + 数字溯源 + 工单/交接摘要 + 会话质检 | 不越权承诺退款/赔偿，不重复盘问用户 |
| **driveloop** | 采集数据可用率不足 5%，标注吃掉 80% 工作量，长尾场景出现频率 <0.03% | 从 CAN + 感知目标里挖 8 类事件，聚类成场景卡，生成 OSC 骨架与回归门禁 | 不做感知/规划算法，不替代仿真器 |

共同点：**都选“脏活、累活、必须可追溯的活”**，而不是再做一个聊天框。

## 快速开始

要求：Python 3.10+。短视频样片渲染额外需要 `ffmpeg` 与 Pillow（`pip install pillow`），其他产品零第三方依赖。

```bash
git clone <this-repo> && cd ai-industry-labs

# 一次跑完四个 demo
bash scripts/run_all_demos.sh

# 或分别跑
cd products/clinote        && python3 -m clinote.cli -i samples/outpatient_zh_01.txt --out-dir demo_out
cd products/shorts_factory && python3 -m shorts_factory.cli --brief samples/brief_zh_01.json --out-dir demo_out --render
cd products/support_copilot && python3 -m support_copilot.cli --demo
cd products/driveloop      && python3 -m driveloop.cli --demo
```

跑测试：

```bash
make test          # 四个产品全部单测（52 个）
```

## 每个产品都已跑通

| 产品 | 单测 | demo 结果 |
| --- | --- | --- |
| clinote | 10 passed | 规范样例阻断 0 / 重要 3 / 提示 3；问题样例正确报出缺段落、缺频次 |
| shorts-factory | 11 passed | 19 镜 / 60.0s / 口播 260 字 / 口播密度 4.3 字/秒；720×1280 样片与 1080×1440 封面 |
| support-copilot | 18 passed | 6 条对话：2 条直答、3 条带人工确认、1 条拒答；规范会话 100 分、问题会话 10 分 |
| driveloop | 13 passed | 6 个场景卡 + 6 份 OSC + 回归门禁 block（2 fail / 4 pass） |

产物都在各产品 `demo_out/` 下，可直接打开 `report.html`、`storyboard.md`、`demo.md` 查看。

## 设计原则

1. **可溯源优先于流畅**。每条结论都要能回到原文/知识条目/日志帧；找不到依据就拒答或转人工。
2. **会认怂**。置信度不足、涉及资金/安全/诊断，一律交人，并带上“已经问过什么”，不让用户重复陈述。
3. **规则先行，模型可插**。四个产品都能纯规则跑通，模型是增强项而不是单点依赖；这样才可测试、可回归、可解释。
4. **产物要能派活**。场景卡给标注员、工单给客服、分镜给剪辑、质控清单给医生——不是只输出一段漂亮话。
5. **合成数据只用来演示链路**，不用于证明效果；真实指标必须用真实数据重跑。

## 目录结构

```
ai-industry-labs/
├── docs/                       # 四个行业的调研与产品方向
│   ├── 01-healthcare.md
│   ├── 02-short-video.md
│   ├── 03-support.md
│   └── 04-driving.md
├── products/
│   ├── clinote/                # 医疗文书质控
│   ├── shorts-factory/         # 短视频生产流水线
│   ├── support-copilot/        # 客服副驾驶
│   └── driveloop/              # 智驾长尾场景
├── scripts/run_all_demos.sh
├── .github/workflows/ci.yml
├── Makefile
└── LICENSE (MIT)
```

每个产品目录内都是同样的骨架：`<pkg>/`（源码）、`samples|data/`（输入）、`tests/`（单测）、`demo_out/`（跑出来的产物）、`README.md`。

## 边界

- 四个产品都是**原型**，不是生产系统：没有账号体系、没有并发与持久化、没有对接真实 HIS/客服平台/车端链路。
- 医疗产品**不是医疗器械**，不提供诊断建议；客服产品不替代人工最终确认；智驾产品不构成安全认证。
- 仓库内所有样例均为合成或脱敏数据，不含真实患者信息、真实用户对话、真实车辆轨迹。

## License

MIT，见 [LICENSE](LICENSE)。
