# .trellis/ - AI 驱动开发工作流

这个目录包含了 kiro-gateway 项目的 AI Agent 工作流配置和任务管理。

## 目录结构

```
.trellis/
├── spec/              # 规范系统（自动注入 Agent 上下文）
│   └── golden-rules.md    # 黄金原则（强制执行）
├── tasks/             # 任务管理
│   ├── active/        # 进行中的任务
│   └── completed/     # 已完成的任务
└── workspace/         # 工作日志（按开发者）
```

## 工作流程

### 1. 创建任务

在 `tasks/active/` 下创建任务目录：

```bash
mkdir -p .trellis/tasks/active/T001-任务名称
```

创建 `prd.md`（需求文档）：

```markdown
# T001: 任务标题

## 需求
具体描述要做什么

## 验收标准
- [ ] 功能正常
- [ ] 有测试覆盖
- [ ] 文档已更新
- [ ] make verify 通过
```

### 2. Agent 执行

告诉 Agent：
```
任务：完成 .trellis/tasks/active/T001-xxx/prd.md
```

Agent 会：
1. 读取 `spec/golden-rules.md` 了解规范
2. 读取 `AGENTS.md` 了解项目结构
3. 按规范实现功能
4. 运行测试和验证
5. 提交代码

### 3. 人类审查

- 审查 Agent 提交的代码
- 提出修改意见（如果有）
- 批准并合并

### 4. 归档

任务完成后，移动到 `completed/`：

```bash
mv .trellis/tasks/active/T001-xxx .trellis/tasks/completed/
```

## spec/ 规范系统

### golden-rules.md

定义了项目的强制规则：
- 数据访问安全（禁止 dict['key']）
- 日志规范（禁止 print()）
- 文件大小限制（< 300 行）
- 依赖方向（Models → Config → Services → Routes）
- 类型安全（必须有类型注解）

这些规则会：
1. 自动注入到 Agent 的上下文中
2. 通过 linter 强制执行
3. 在代码审查时检查

### 添加新规范

当你发现新的最佳实践或踩过的坑时，添加到 `spec/` 目录：

```bash
# 例如：API 设计规范
echo "# API Guidelines" > .trellis/spec/api-guidelines.md
```

Agent 会自动读取并遵循这些规范。

## tasks/ 任务管理

### 任务命名规范

```
T001-add-model-detail-endpoint
T002-fix-timeout-bug
T003-optimize-cache-performance
```

格式：`T{编号}-{简短描述}`

### 任务目录结构

```
T001-task-name/
├── prd.md           # 需求文档（必需）
├── plan.md          # 执行计划（Agent 生成）
├── notes.md         # 工作笔记（可选）
└── review.md        # 审查记录（可选）
```

### 任务状态

- `active/` - 进行中
- `completed/` - 已完成

## workspace/ 工作日志

每个开发者可以有自己的工作日志：

```
workspace/
├── redline.journal      # 红线的工作日志
└── teammate.journal     # 队友的工作日志
```

记录：
- 每天做了什么
- 遇到的问题
- 学到的经验
- 待办事项

## 与现有工具集成

### 与 AGENTS.md 配合

- `AGENTS.md` 是项目地图（< 100 行）
- `.trellis/spec/` 是详细规范
- Agent 先读 AGENTS.md 了解全局，再读 spec/ 了解细节

### 与 Makefile 配合

```bash
make verify    # 验证代码符合规范
make test      # 运行测试
make lint      # 代码检查
```

### 与 Git 配合

```bash
# 提交时包含任务编号
git commit -m "feat(routes): add model detail endpoint [T001]"
```

## 最佳实践

### 1. 保持 spec/ 简洁

- 只写真正重要的规则
- 用例子说明，不要长篇大论
- 定期审查和更新

### 2. 任务粒度适中

- 太大：难以完成，难以审查
- 太小：管理成本高
- 合适：2-4 小时能完成

### 3. 及时归档

- 完成的任务及时移到 `completed/`
- 保持 `active/` 目录干净
- 定期清理旧任务

### 4. 记录经验

- 踩过的坑写进 `spec/`
- 好的实践写进 `spec/`
- 让后来者受益

## 故障排查

### Agent 不遵守规范？

1. 检查 `spec/golden-rules.md` 是否清晰
2. 运行 `make verify` 看是否有 linter 错误
3. 在任务 `prd.md` 中明确引用规范

### 任务进度慢？

1. 检查任务是否太大（拆分）
2. 检查需求是否清晰
3. 检查是否有依赖阻塞

### 代码质量下降？

1. 加强审查
2. 更新 linter 规则
3. 把问题写进 `spec/`

---

**记住**：这套系统是为了提高效率，不是增加负担。保持简单，持续改进。
