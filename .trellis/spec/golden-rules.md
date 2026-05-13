# Golden Rules - Frontend Template (React + Vite + TypeScript)

> ⚠️ **TODO**: 这个文件是从 Python 项目复制的，需要根据 React/TypeScript 项目定制。
> 
> 需要更新的内容：
> - 组件设计规则（函数组件、Hooks 规则）
> - Props 验证（TypeScript 接口）
> - 状态管理规范（Redux/Zustand）
> - 样式规范（CSS Modules/Styled Components）
> - 测试规范（Vitest + React Testing Library）
> - React 特定的最佳实践
> - 可访问性规则（a11y）

---

# Golden Rules - Frontend Template

## 强制规则（linter 检查）

### 1. 数据访问安全
- ❌ 禁止直接 `dict['key']` 访问
- ✅ 使用 `.get()` 或 Pydantic 模型
- **原因**：避免 KeyError，提高代码健壮性

### 2. 日志规范
- ❌ 禁止使用 `print()`
- ✅ 使用结构化 logger (`logger.info()`, `logger.error()` 等)
- **原因**：生产环境需要结构化日志，便于追踪和分析

### 3. 文件大小限制
- ❌ 禁止超过 300 行的文件
- ✅ 拆分成多个模块
- **原因**：保持代码可维护性

### 4. 依赖方向
- ✅ 严格遵循：`Models → Config → Services → Routes`
- ❌ 禁止反向依赖（如 routes 导入 tests）
- **原因**：保持架构清晰，避免循环依赖

### 5. 类型安全
- ✅ 所有函数必须有类型注解
- ✅ 使用 Pydantic 模型定义数据结构
- **原因**：类型检查能在开发阶段发现问题

## 架构规则

### 分层结构
```
kiro/
├── models/          # 数据模型（Pydantic）
├── config/          # 配置管理
├── services/        # 业务逻辑
│   ├── providers/   # AI 提供商适配器
│   └── core/        # 核心服务
└── routes/          # API 路由
```

### 每个业务域的标准结构
```
domain/
├── types.py         # 类型定义
├── config.py        # 配置
├── repo.py          # 数据访问（如果需要）
├── service.py       # 业务逻辑
└── runtime.py       # 运行时（如果需要）
```

## 测试规则

### 1. 测试覆盖
- ✅ 所有新功能必须有单元测试
- ✅ 关键路径必须有集成测试
- 🎯 目标覆盖率：> 80%

### 2. 测试命名
```python
def test_<功能>_<场景>_<期望结果>():
    # 例如：
    # test_openai_provider_timeout_returns_error()
    pass
```

## 代码风格

### 1. 命名规范
- 类名：`PascalCase`
- 函数/变量：`snake_case`
- 常量：`UPPER_SNAKE_CASE`
- 私有成员：`_leading_underscore`

### 2. 文档字符串
```python
def function_name(param: str) -> dict:
    """简短描述（一行）
    
    详细描述（如果需要）
    
    Args:
        param: 参数说明
        
    Returns:
        返回值说明
        
    Raises:
        ExceptionType: 异常说明
    """
    pass
```

## 配置管理

### 1. 配置优先级
```
环境变量 > 配置文件 > 默认值
```

### 2. 敏感信息
- ❌ 禁止硬编码 API Key、密码等
- ✅ 使用环境变量或配置文件
- ✅ 配置文件不提交到 git（.gitignore）

## 错误处理

### 1. 异常处理
```python
# ❌ 不要捕获所有异常
try:
    ...
except Exception:
    pass

# ✅ 捕获具体异常
try:
    ...
except ValueError as e:
    logger.error(f"Invalid value: {e}")
    raise
```

### 2. 错误响应
- 使用标准错误格式
- 包含错误码、消息、详情
- 不暴露内部实现细节

## 性能规则

### 1. 异步优先
- ✅ I/O 操作使用 async/await
- ✅ 使用 httpx 而非 requests

### 2. 资源管理
- ✅ 使用 context manager 管理资源
- ✅ 及时关闭连接、文件句柄

## 验证

运行以下命令确保代码符合规范：

```bash
make verify    # 运行所有检查
make lint      # 代码风格检查
make test      # 运行测试
make type-check # 类型检查
```

## 违规处理

- 第一次：Agent 自动修复
- 第二次：人工审查
- 持续违规：更新 linter 规则强制执行

---

**记住**：这些规则不是为了限制，而是为了保持代码质量和团队协作效率。
