.PHONY: install dev test lint format type-check build preview verify clean

# 安装依赖
install:
	npm install

# 开发模式
dev:
	npm run dev

# 运行测试
test:
	npm test

# 代码检查
lint:
	npm run lint

# 代码格式化
format:
	npm run format

# 类型检查
type-check:
	npm run type-check

# 构建生产版本
build:
	npm run build

# 预览生产构建
preview:
	npm run preview

# 验证（运行所有检查）
verify: lint type-check test
	@echo "✅ All checks passed!"

# 清理
clean:
	rm -rf node_modules dist build .vite
	npm cache clean --force

# 帮助
help:
	@echo "Available commands:"
	@echo "  make install     - Install dependencies"
	@echo "  make dev         - Start development server"
	@echo "  make test        - Run tests"
	@echo "  make lint        - Check code style"
	@echo "  make format      - Format code"
	@echo "  make type-check  - Run TypeScript type checking"
	@echo "  make build       - Build for production"
	@echo "  make preview     - Preview production build"
	@echo "  make verify      - Run all checks"
	@echo "  make clean       - Clean build artifacts"
