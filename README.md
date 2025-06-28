!-- Trigger redeploy -->
Kiribati Connect - Social Media Platform
Overview
Kiribati Connect is a full-stack social media platform designed for the Kiribati community. It features a modern React frontend with a Node.js/Express backend, using PostgreSQL for data persistence through Drizzle ORM. The application enables users to create posts, interact with content, and connect with friends in a culturally-themed interface inspired by Kiribati's ocean and coral aesthetics.

System Architecture
Frontend Architecture
Framework: React 18 with TypeScript
Bundler: Vite for fast development and optimized builds
UI Library: Shadcn/ui components built on Radix UI primitives
Styling: Tailwind CSS with custom Kiribati-themed color palette
State Management: TanStack Query for server state, React hooks for local state
Routing: Wouter for lightweight client-side routing
Form Handling: React Hook Form with Zod validation
Backend Architecture
Runtime: Node.js with Express.js framework
Language: TypeScript with ES modules
API Pattern: RESTful API design
Database: PostgreSQL with persistent data storage
ORM: Drizzle ORM for type-safe database operations
Session Management: Express sessions with PostgreSQL storage
Development: Hot reload with tsx for server-side development
Build System
Development: Concurrent frontend (Vite) and backend (tsx) processes
Production: Vite builds frontend to static assets, esbuild bundles backend
Deployment: Configured for Replit's autoscale deployment target
Key Components
Data Layer
Database Schema: Comprehensive social media schema with users, posts, comments, likes, and friendships
Type Safety: Shared TypeScript types between frontend and backend
Validation: Zod schemas for runtime validation and type inference
Migration: Drizzle Kit for database schema management
Authentication System
Current State: Mock authentication returning first user
Session Storage: PostgreSQL-backed session store ready for implementation
User Management: Complete user profile system with avatars, bios, and social metrics
Social Features
Posts: Create, read, and interact with text and image posts
Engagement: Like system with real-time updates
Social Graph: Friendship system with status tracking (pending/accepted/rejected)
Content Discovery: Feed system with pagination support
UI/UX Design
Responsive: Mobile-first design with dedicated mobile navigation
Theme: Custom Kiribati-inspired color palette (ocean blues, coral oranges, tropical teals)
Components: Comprehensive component library with consistent styling
Accessibility: Built on Radix UI primitives for accessibility compliance
Data Flow
User Interaction: User actions trigger React component events
State Management: TanStack Query manages API calls and caching
API Communication: Frontend makes HTTP requests to Express backend
Data Validation: Zod schemas validate incoming data on backend
Database Operations: Drizzle ORM executes type-safe database queries
Response Handling: Data flows back through the same path with automatic UI updates
Example Flow: Creating a Post
User submits post form in CreatePost component
Form data validated with React Hook Form + Zod
Mutation sent to /api/posts endpoint via TanStack Query
Backend validates data with shared Zod schema
Drizzle ORM inserts post into PostgreSQL database
Response triggers cache invalidation and UI refresh
External Dependencies
Core Runtime
@neondatabase/serverless: PostgreSQL connection for Neon database
drizzle-orm: Type-safe database operations
express: Web application framework
react: Frontend UI library
Development & Build
vite: Frontend build tool and dev server
tsx: TypeScript execution for backend development
esbuild: Backend bundling for production
@replit/vite-plugin-runtime-error-modal: Development error handling
UI & Styling
@radix-ui/*: Headless UI components for accessibility
tailwindcss: Utility-first CSS framework
class-variance-authority: Component variant management
lucide-react: Icon library
State & Data Management
@tanstack/react-query: Server state management and caching
react-hook-form: Form state management
zod: Runtime type validation
wouter: Lightweight routing
Deployment Strategy
Development Environment
Database: PostgreSQL 16 module in Replit
Frontend: Vite dev server with HMR on port 5000
Backend: tsx with auto-restart on file changes
Process Management: Parallel execution of frontend and backend
Production Build
Frontend: Static assets built with Vite to dist/public
Backend: Bundled with esbuild to dist/index.js
Deployment: Replit autoscale with optimized startup
Port Configuration: External port 80 maps to internal port 5000
Environment Configuration
Database URL: Required environment variable for PostgreSQL connection
Session Storage: PostgreSQL-backed session store for scalability
Asset Serving: Static file serving in production, Vite middleware in development
Changelog
Changelog:
- June 27, 2025: Initial setup with React frontend and Express backend
- June 27, 2025: Added PostgreSQL database with Drizzle ORM integration
- June 27, 2025: Implemented complete social features with persistent data storage
- June 27, 2025: Added authentic Kiribati community content and cultural theming
User Preferences
Preferred communication style: Simple, everyday language.
