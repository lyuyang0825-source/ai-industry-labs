# AI Industry Labs

四个行业、四个**独立仓库**、四个能跑起来的 AI 产品原型。不是 PPT，也不是“调个 API 的 demo”——每个仓库都有明确的行业问题、可复现的输入输出、单元测试、行业调研与架构文档，以及一份说清边界的 README。

> 本仓库现在是**总览与索引**。四个产品已在 2026-11 拆分为独立仓库，日常迭代请看分仓；`products/` 保留为历史快照，不再作为主开发位置。

## 四个仓库

| 仓库 | 行业 | 一句话 | 验证 |
| --- | --- | --- | --- |
| [**clinote**](https://github.com/lyuyang0825-source/clinote) | 医疗 | 中文病历结构化 + 可溯源质控；每条问题都能回到原文 | 12 tests，3 份样例 |
| [**shorts-factory**](https://github.com/lyuyang0825-source/shorts-factory) | 短视频 | 选题→钩子→分镜→字幕→多平台→合规→样片 | 13 tests，60s/30s 两条样片 |
| [**support-copilot**](https://github.com/lyuyang0825-source/support-copilot) | AI 客服 | 可溯源回答、该转人工就转、交接不重复问 | 20 tests，10 条决策评测 |
| [**driveloop**](https://github.com/lyuyang0825-source/driveloop) | 智能驾驶 | 长尾场景挖掘 → 场景卡 → OSC → 回归门禁 | 13 tests，6 场景 + 门禁 |

四个仓库合计 **58 个单元测试**，每个仓库都带 GitHub Actions，推上去就能跑。

## 各自解决什么

| 产品 | 行业核心问题 | 产品做的事 | 不做的事 |
| --- | --- | --- | --- |
| **clinote** | 医生 43.2% 有 burnout，每周 13 小时用于间接诊疗；AI 病历会把“讨论过的检查”写成“已执行” | 把自由文本病历拆成 SOAP 与事实，跑 11 条规则，每条问题都带原文位置 | 不诊断、不开药、不替代医生签字 |
| **shorts-factory** | 2026 Q1 上线 12.8 万部微短剧，95% 是 AI 生成，但破亿率不足 0.2%——产能过剩、精品稀缺 | 把一句选题变成 19 镜分镜、口播稿、SRT、五平台规格、合规检查，并渲染出可看的样片 | 不承诺爆款，不替代编导的审美判断 |
| **support-copilot** | 2025 年上海消保委受理 AI 客服投诉 1087 件；某教育公司上线 AI 后满意度 -15%、转人工率 20%→45% | BM25 检索 + 强制转人工策略 + 数字溯源 + 工单/交接摘要 + 会话质检 | 不越权承诺退款/赔偿，不重复盘问用户 |
| **driveloop** | 采集数据可用率不足 5%，标注吃掉 80% 工作量，长尾场景出现频率 <0.03% | 从 CAN + 感知目标里挖 8 类事件，聚类成场景卡，生成 OSC 骨架与回归门禁 | 不做感知/规划算法，不替代仿真器 |

共同点：**都选“脏活、累活、必须可追溯的活”**，而不是再做一个聊天框。

## 共同设计原则

1. **可溯源优先于流畅**。每条结论都要能回到原文/知识条目/日志帧；找不到依据就拒答或转人工。
2. **会认怂**。置信度不足、涉及资金/安全/诊断，一律交人，并带上“已经问过什么”。
3. **规则先行，模型可插**。四个产品都能纯规则跑通，模型是增强项而不是单点依赖。
4. **产物要能派活**。场景卡给标注员、工单给客服、分镜给剪辑、质控清单给医生。
5. **合成数据只用来演示链路**，不用于证明效果；真实指标必须用真实数据重跑。

## 行业文档

| 文档 | 内容 |
| --- | --- |
| [01-healthcare.md](docs/01-healthcare.md) | 医生工时、AI 病历幻觉、结构化与质控方向 |
| [02-short-video.md](docs/02-short-video.md) | 微短剧供给过剩、成本结构、钩子与合规 |
| [03-support.md](docs/03-support.md) | AI 客服投诉、人机协同国标、质检指标 |
| [04-driving.md](docs/04-driving.md) | 数据可用率、标注成本、长尾挖掘与回归 |

每个分仓里还有更细的 `docs/industry.md`（行业篇）与 `docs/architecture.md`（架构与设计取舍）。

## 本地运行

总览仓库保留了一份可直接跑的历史快照：

```bash
git clone https://github.com/lyuyang0825-source/ai-industry-labs.git
cd ai-industry-labs
bash scripts/run_all_demos.sh
make test
```

日常使用请直接克隆对应分仓：

```bash
git clone https://github.com/lyuyang0825-source/clinote.git
git clone https://github.com/lyuyang0825-source/shorts-factory.git
git clone https://github.com/lyuyang0825-source/support-copilot.git
git clone https://github.com/lyuyang0825-source/driveloop.git
```

## 边界

- 四个产品都是**原型**，不是生产系统：没有账号体系、没有并发与持久化、没有对接真实 HIS/客服平台/车端链路。
- 医疗产品**不是医疗器械**；客服产品不替代人工最终确认；智驾产品不构成安全认证。
- 仓库内所有样例均为合成或脱敏数据，不含真实患者信息、真实用户对话、真实车辆轨迹。

## License

MIT，见 [LICENSE](LICENSE)。
