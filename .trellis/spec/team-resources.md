# Team Resources - 团队资源索引

## 📖 团队文档仓库
**地址**: https://github.com/xiachen332/team-ai-workflow-docs

**包含内容**:
- `/docs/api-guidelines.md` - API 设计规范
- `/docs/testing-standards.md` - 测试标准
- `/docs/deployment.md` - 部署流程
- `/docs/security.md` - 安全规范
- `/docs/frontend-backend-contract.md` - 前后端契约规范

**Agent 使用场景**:
- 设计 API 时,参考 API 设计规范
- 写测试时,参考测试标准
- 部署时,参考部署流程

---

## 🔧 模板仓库

### 后端模板
**地址**: https://github.com/xiachen332/team-ai-template-backend

**参考内容**:
- `/src/` - 标准项目结构
- `/tests/` - 测试示例
- `/.trellis/spec/golden-rules.md` - 后端黄金原则
- `/docs/architecture.md` - 架构说明

**Agent 使用场景**:
- 创建新模块时,参考标准结构
- 不确定如何组织代码时,查看模板

### 前端模板
**地址**: https://github.com/xiachen332/team-ai-template-frontend

**参考内容**:
- `/src/components/` - 组件示例
- `/src/hooks/` - 自定义 Hooks
- `/src/utils/` - 工具函数
- `/.trellis/spec/golden-rules.md` - 前端黄金原则

---

## 🛠️ 工具包仓库
**地址**: https://github.com/xiachen332/team-ai-tools

**包含内容**:
- `/linters/` - 代码检查工具
- `/scripts/` - 通用脚本
- `/configs/` - 共享配置

**安装方式**:
```bash
# 后端项目
pip install your-team-ai-tools

# 前端项目
npm install @your-team/ai-tools
```

---

## 🌟 参考项目（示例实现）

### 参考后端 API
**地址**: https://github.com/xiachen332/reference-api (待创建)

**优秀实践**:
- `/src/auth/` - 认证实现（JWT + Refresh Token）
- `/src/middleware/` - 中间件（日志、错误处理）
- `/tests/integration/` - 集成测试示例

**Agent 使用场景**:
- 实现认证时,参考 reference-api 的认证模块
- 写中间件时,参考 reference-api 的中间件

### 参考前端应用
**地址**: https://github.com/xiachen332/reference-frontend (待创建)

**优秀实践**:
- `/src/store/` - 状态管理
- `/src/api/` - API 调用封装
- `/src/components/common/` - 通用组件

---

## 🔗 跨项目协作

### 前后端契约
**地址**: https://github.com/xiachen332/api-contracts (待创建)

**包含内容**:
- `/contracts/user-service.yaml` - 用户服务 API 契约（OpenAPI）
- `/contracts/order-service.yaml` - 订单服务 API 契约
- `/types/` - 自动生成的类型定义

**工作流**:
1. 后端 Agent 读取契约,生成接口实现
2. 前端 Agent 读取契约,生成 TypeScript 类型 + API 调用代码
3. 自动生成集成测试验证契约

---

## 🤖 Agent 使用方式

### 场景 1: 添加新的 API 端点

**Agent 工作流**:
1. 读取本地 `.trellis/spec/golden-rules.md` → 了解项目特定规则
2. 读取本地 `.trellis/spec/team-resources.md` → 找到团队文档地址
3. 访问团队文档仓库 → 了解 API 设计规范
4. 访问参考项目 → 查看参考实现
5. 根据规范和参考实现,生成代码

### 场景 2: 前后端联调

**前端 Agent**:
1. 读取 API 契约仓库
2. 生成 TypeScript 类型定义
3. 生成 API 调用代码
4. 生成 Mock 数据（用于独立开发）

**后端 Agent**:
1. 读取同一个契约文件
2. 生成接口实现
3. 生成 Pydantic 模型
4. 生成集成测试

**结果**: 前后端自动对齐,减少联调问题

---

## 💡 实际好处

### 1. 知识共享
- 新项目自动继承团队最佳实践
- Agent 可以跨项目学习
- 避免重复造轮子

### 2. 一致性
- 所有项目遵循相同标准
- 代码风格统一
- 架构模式一致

### 3. 快速上手
- 新成员通过参考项目快速学习
- Agent 通过模板快速生成代码
- 减少培训成本

### 4. 持续改进
- 更新团队文档,所有项目受益
- 发现好的实践,沉淀到参考项目
- 形成正向循环

---

## 📝 使用说明

**当前状态**: 这些仓库地址是占位符,需要替换为你们团队的实际地址

**下一步**:
1. 创建团队 GitHub Organization
2. 创建上述仓库
3. 更新这个文件中的地址
4. Agent 就能自动访问团队知识

**维护**: 当团队添加新的参考项目或文档时,更新这个文件
