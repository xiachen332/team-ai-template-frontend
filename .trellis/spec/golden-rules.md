# Golden Rules - Frontend Template (React + Vite + TypeScript)

> 本文档定义了 React + Vite + TypeScript 前端项目的编码规范和最佳实践。

---

## 🎯 核心原则

### 1. 组件设计原则

#### 函数组件优先
```typescript
// ✅ 正确
const UserProfile: React.FC<UserProfileProps> = ({ user }) => {
  return <div>{user.name}</div>;
};

// ❌ 错误（不再推荐 class 组件）
class UserProfile extends React.Component {
  render() {
    return <div>{this.props.user.name}</div>;
  }
}
```

#### 单一职责
- ✅ 每个组件只做一件事
- ✅ 组件拆分要合理（< 200 行为佳）
- ✅ 复杂逻辑抽取为自定义 Hook

#### 组件分类
- **Pages**: 路由级别的页面组件
- **Features**: 业务功能组件
- **Components**: 可复用的 UI 组件
- **Layouts**: 布局组件

---

## 📦 TypeScript 集成

### Props 类型定义
```typescript
// ✅ 正确
interface UserProfileProps {
  user: User;
  onUpdate: (user: User) => void;
  isLoading?: boolean;
}

const UserProfile: React.FC<UserProfileProps> = ({ 
  user, 
  onUpdate, 
  isLoading = false 
}) => {
  // ...
};

// ❌ 错误（使用 any）
const UserProfile = ({ user, onUpdate }: any) => {
  // ...
};
```

### 事件类型
```typescript
// ✅ 正确
const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
  e.preventDefault();
};

const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  setValue(e.target.value);
};

// ❌ 错误
const handleSubmit = (e: any) => {
  e.preventDefault();
};
```

### API 响应类型
```typescript
// ✅ 定义明确的 API 响应类型
interface ApiResponse<T> {
  data: T;
  message: string;
  status: number;
}

interface User {
  id: string;
  name: string;
  email: string;
}

const fetchUser = async (id: string): Promise<ApiResponse<User>> => {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
};
```

---

## 🎣 Hooks 使用规范

### Hooks 规则
1. ✅ 只在组件顶层调用 Hooks
2. ✅ 只在 React 函数中调用 Hooks
3. ❌ 不要在循环、条件或嵌套函数中调用 Hooks

### 常用 Hooks

#### useState
```typescript
// ✅ 正确
const [user, setUser] = useState<User | null>(null);
const [isLoading, setIsLoading] = useState<boolean>(false);

// ✅ 使用函数式更新（依赖之前的状态）
setCount(prev => prev + 1);
```

#### useEffect
```typescript
// ✅ 正确 - 清理副作用
useEffect(() => {
  const controller = new AbortController();
  
  fetchData(controller.signal);
  
  return () => {
    controller.abort();
  };
}, [dependency]);

// ❌ 错误 - 缺少依赖项
useEffect(() => {
  fetchData(userId); // userId 应该在依赖数组中
}, []);
```

#### useMemo / useCallback
```typescript
// ✅ 使用 useMemo 缓存计算结果
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(data);
}, [data]);

// ✅ 使用 useCallback 缓存回调函数
const handleClick = useCallback((id: string) => {
  onSelect(id);
}, [onSelect]);

// ❌ 滥用 - 简单计算不需要 useMemo
const total = useMemo(() => a + b, [a, b]); // 过度优化
```

### 自定义 Hook
```typescript
// ✅ 正确 - 封装复用逻辑
function useUser(userId: string) {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    const fetchUser = async () => {
      setIsLoading(true);
      try {
        const data = await getUser(userId);
        setUser(data);
      } catch (err) {
        setError(err as Error);
      } finally {
        setIsLoading(false);
      }
    };
    
    fetchUser();
  }, [userId]);

  return { user, isLoading, error };
}

// 使用
const { user, isLoading, error } = useUser(userId);
```

---

## 🗂️ 状态管理

### 本地状态 vs 全局状态

#### 使用本地状态（useState）
- ✅ 表单输入
- ✅ UI 状态（模态框、展开/折叠）
- ✅ 组件内部逻辑

#### 使用全局状态（Zustand / Redux Toolkit）
- ✅ 用户信息
- ✅ 应用配置
- ✅ 跨组件共享数据

### 状态管理方案选择
```typescript
// ✅ 简单应用：useState + useContext
const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

// ✅ 复杂应用：Zustand（推荐）
const useStore = create<StoreState>((set) => ({
  user: null,
  setUser: (user) => set({ user }),
}));

// ✅ 大型应用：Redux Toolkit + RTK Query
const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUser: (state, action) => {
      state.user = action.payload;
    },
  },
});
```

---

## 🧪 测试规范

### 组件测试
```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import UserProfile from './UserProfile';

describe('UserProfile', () => {
  it('should display user name', () => {
    render(<UserProfile user={{ name: 'John', email: 'john@example.com' }} />);
    
    expect(screen.getByText('John')).toBeInTheDocument();
  });

  it('should call onUpdate when button is clicked', async () => {
    const mockOnUpdate = jest.fn();
    render(<UserProfile user={mockUser} onUpdate={mockOnUpdate} />);
    
    await userEvent.click(screen.getByRole('button', { name: /update/i }));
    
    expect(mockOnUpdate).toHaveBeenCalledWith(mockUser);
  });
});
```

### Hook 测试
```typescript
import { renderHook, act } from '@testing-library/react-hooks';
import { useCounter } from './useCounter';

describe('useCounter', () => {
  it('should increment counter', () => {
    const { result } = renderHook(() => useCounter());
    
    act(() => {
      result.current.increment();
    });
    
    expect(result.current.count).toBe(1);
  });
});
```

### 测试覆盖率
- ✅ 关键组件测试覆盖率 > 80%
- ✅ 自定义 Hook 必须有测试
- ✅ 工具函数必须有测试

---

## ♿ 可访问性（a11y）

### 语义化 HTML
```typescript
// ✅ 正确
<button onClick={onClick}>Submit</button>
<nav aria-label="Main navigation">
  <ul>
    <li><a href="/home">Home</a></li>
  </ul>
</nav>

// ❌ 错误
<div onClick={onClick}>Submit</div>
<div className="nav">...</div>
```

### ARIA 属性
```typescript
// ✅ 正确
<button 
  aria-label="Close modal"
  aria-expanded={isOpen}
  onClick={onClose}
>
  <XIcon />
</button>

// ✅ 表单可访问性
<input 
  id="email"
  type="email"
  aria-label="Email address"
  aria-required="true"
  aria-invalid={!!errors.email}
/>
<label htmlFor="email">Email</label>
{errors.email && <span role="alert">{errors.email}</span>}
```

### 键盘导航
- ✅ 所有交互元素可通过键盘访问
- ✅ Tab 顺序符合逻辑
- ✅ 焦点状态清晰可见

---

## 🎨 样式规范

### CSS Modules（推荐）
```typescript
// UserProfile.module.css
.container {
  display: flex;
  padding: 16px;
}

.name {
  font-size: 18px;
  font-weight: bold;
}

// UserProfile.tsx
import styles from './UserProfile.module.css';

const UserProfile = () => {
  return (
    <div className={styles.container}>
      <span className={styles.name}>John</span>
    </div>
  );
};
```

### Tailwind CSS
```typescript
// ✅ 正确
const UserProfile = () => {
  return (
    <div className="flex p-4">
      <span className="text-lg font-bold">John</span>
    </div>
  );
};

// ❌ 错误 - 过长的 className
<div className="flex items-center justify-between p-4 m-2 border rounded shadow hover:bg-gray-100 focus:ring-2 focus:ring-blue-500">
```

### Styled Components
```typescript
import styled from 'styled-components';

const Container = styled.div`
  display: flex;
  padding: 16px;
`;

const Name = styled.span`
  font-size: 18px;
  font-weight: bold;
`;
```

---

## ⚡ 性能优化

### 代码分割
```typescript
// ✅ 使用 React.lazy 懒加载
const Dashboard = lazy(() => import('./pages/Dashboard'));

// ✅ 使用 Suspense
<Suspense fallback={<Loading />}>
  <Dashboard />
</Suspense>
```

### 列表渲染
```typescript
// ✅ 正确 - 使用稳定的 key
{items.map((item) => (
  <Item key={item.id} item={item} />
))}

// ❌ 错误 - 使用 index 作为 key
{items.map((item, index) => (
  <Item key={index} item={item} />
))}
```

### 虚拟化长列表
```typescript
// ✅ 使用 react-window 或 react-virtualized
import { FixedSizeList } from 'react-window';

<FixedSizeList
  height={600}
  itemCount={1000}
  itemSize={35}
  width="100%"
>
  {({ index, style }) => (
    <div style={style}>Item {index}</div>
  )}
</FixedSizeList>
```

---

## 🚨 错误处理

### Error Boundary
```typescript
class ErrorBoundary extends React.Component<
  { children: React.ReactNode },
  { hasError: boolean }
> {
  state = { hasError: false };

  static getDerivedStateFromError(error: Error) {
    return { hasError: true };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }
    return this.props.children;
  }
}

// 使用
<ErrorBoundary>
  <App />
</ErrorBoundary>
```

### 异步错误处理
```typescript
// ✅ 正确
const fetchData = async () => {
  try {
    const data = await api.getData();
    setData(data);
  } catch (error) {
    if (error instanceof Error) {
      setError(error.message);
    }
  } finally {
    setIsLoading(false);
  }
};
```

---

## 📁 代码组织

### 文件夹结构
```
src/
├── components/        # 可复用组件
│   ├── ui/           # UI 组件
│   └── layout/       # 布局组件
├── features/          # 业务功能组件
├── pages/             # 页面组件
├── hooks/             # 自定义 Hooks
├── services/          # API 服务
├── store/             # 状态管理
├── utils/             # 工具函数
├── types/             # TypeScript 类型
└── styles/            # 全局样式
```

### 文件命名
- 组件：`UserProfile.tsx`
- 样式：`UserProfile.module.css`
- 测试：`UserProfile.test.tsx`
- Hook：`useUserProfile.ts`
- 类型：`user.types.ts`

---

## 🔄 Git 提交规范

### Commit Message 格式
```
type(scope): subject

type:
- feat: 新功能
- fix: 修复 bug
- style: 样式调整
- refactor: 重构
- perf: 性能优化
- test: 测试相关
- docs: 文档更新
- chore: 构建/工具相关
```

### 示例
```
feat(user): add profile edit feature
fix(auth): resolve token refresh issue
perf(list): implement virtual scrolling
```

---

## ⚠️ 常见陷阱

### 避免这些问题
1. **在 useEffect 中直接使用 async 函数** - 使用立即执行函数
2. **忘记清理副作用** - 返回清理函数
3. **过度使用 useMemo/useCallback** - 只在必要时使用
4. **在 JSX 中定义函数** - 抽取到组件外部或使用 useCallback
5. **忽视可访问性** - 所有用户都应该能使用你的应用

---

## 📚 参考资源

- [React Documentation](https://react.dev)
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro)
- [WAI-ARIA Guidelines](https://www.w3.org/WAI/ARIA/apg/)
- [React Performance Optimization](https://react.dev/learn/render-and-commit)
