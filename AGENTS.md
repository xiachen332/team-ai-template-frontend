# AGENTS.md - Frontend Project Map

## Quick Start

1. Read `.trellis/spec/golden-rules.md` - Project rules
2. Read `.trellis/spec/team-resources.md` - Team resources
3. Run `make verify` before starting

## Project Structure

```
frontend/
├── src/
│   ├── components/      # React components
│   │   ├── common/      # Shared components
│   │   └── features/    # Feature-specific components
│   ├── pages/           # Page components
│   ├── hooks/           # Custom React hooks
│   ├── services/        # API calls and external services
│   ├── store/           # State management (Redux/Zustand)
│   ├── utils/           # Utility functions
│   ├── types/           # TypeScript types
│   └── styles/          # Global styles
├── public/              # Static assets
├── tests/               # Test files
├── .trellis/            # AI workflow configuration
│   ├── spec/            # Project specifications
│   ├── tasks/           # Task management
│   └── workspace/       # Work logs
└── package.json         # Dependencies
```

## Architecture Rules

### Component Hierarchy
```
Pages → Feature Components → Common Components
```

### Layer Responsibilities
- **Pages**: Route-level components, layout composition
- **Components**: Reusable UI components
- **Hooks**: Reusable stateful logic
- **Services**: API calls, external integrations
- **Store**: Global state management
- **Utils**: Pure utility functions

## Common Commands

```bash
make install    # Install dependencies
make dev        # Start development server
make test       # Run tests
make lint       # Check code style
make build      # Build for production
make verify     # Run all checks
```

## Development Workflow

1. Create task in `.trellis/tasks/active/`
2. Implement following the architecture rules
3. Write tests
4. Run `make verify`
5. Submit PR

## Key Principles

- Use TypeScript for type safety
- Use functional components with hooks
- Keep components small and focused
- Use proper prop validation
- Write tests for components and hooks
- Follow accessibility best practices (a11y)
- Use CSS modules or styled-components for styling

## State Management

- Local state: `useState`, `useReducer`
- Global state: Redux Toolkit / Zustand
- Server state: React Query / SWR
- Form state: React Hook Form

## Notes

- This is a React + Vite + TypeScript project
- See `.trellis/spec/golden-rules.md` for detailed rules
- See `.trellis/spec/team-resources.md` for team resources
