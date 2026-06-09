# NODESTRIKE: Arena Protocol

**NODESTRIKE: Arena Protocol** is a browser-based tactical FPS game using a **TypeScript Vite frontend** and a **Go authoritative multiplayer backend**.

The project is designed as a scalable monorepo for building a real-time web FPS with support for dynamic players, characters, weapons, maps, lobbies, game modes, cosmetics, and future multiplayer systems.

---

## Project Structure

The codebase is structured as a monorepo to maintain strong separation between the browser game client, authoritative server logic, shared contracts, and deployment tooling.

```txt
Game/
├── frontend/
├── backend/
├── shared/
├── docs/
├── scripts/
├── deployments/
├── .env
├── .env.example
├── .gitignore
└── README.md
```

### Directory Responsibilities

```txt
frontend/    = browser game client, UI, HUD, menus, and Three.js/Vite game rendering
backend/     = Go HTTP/WebSocket authoritative server, matchmaking, simulation, and backend services
shared/      = protocol messages, schemas, constants, and frontend-backend contracts
docs/        = architecture, game design, networking, database, and security documentation
scripts/     = setup, development, build, test, deployment, and database helper scripts
deployments/ = Docker, Nginx, Fly.io, Render, Railway, Vercel, and other hosting configurations
```

---

## Architecture Direction

NODESTRIKE uses a clear client-server architecture.

```txt
TypeScript / Vite frontend
        ↓
HTTP / WebSocket protocol
        ↓
Go authoritative backend
        ↓
Database / cache / matchmaking systems
```

The frontend is responsible for rendering, UI interaction, input collection, client prediction, interpolation, and player experience.

The backend is responsible for authoritative game state, player sessions, match validation, damage calculation, hit validation, round state, matchmaking, and anti-cheat foundations.

---

## Core Technical Stack

### Frontend

```txt
TypeScript
Vite
React
Three.js
Bun
```

### Backend

```txt
Go
HTTP
WebSocket
Authoritative game loop
```

### Future Infrastructure

```txt
PostgreSQL
Redis
Docker
Fly.io / Render / Railway
Vercel / Cloudflare Pages
```

---

## Dynamic Content Strategy

The project is structured to support future expansion without rewriting the core system.

Dynamic content includes:

```txt
characters/
weapons/
maps/
lobbies/
game-modes/
abilities/
attachments/
cosmetics/
```

The long-term goal is to use registry-based content loading so new weapons, maps, characters, lobbies, and modes can be added cleanly through structured folders and shared schemas.

Example flow:

```txt
Add new weapon metadata
↓
Add weapon assets
↓
Register weapon
↓
Make it available in loadout and gameplay systems
```

---

## Getting Started

### 1. Initialize Folder Structure

To populate all required folders with `.gitkeep` trackers, run:

```bash
chmod +x scripts/setup_folders.sh
./scripts/setup_folders.sh
```

The setup script creates missing directories safely and should not overwrite existing Vite or Go project files.

---

## Environment Configuration

The project uses one root-level environment file during early development.

```txt
.env
.env.example
```

The `.env` file is local and should not be committed.

The `.env.example` file documents the required environment variables.

Example:

```env
APP_NAME=NODESTRIKE
APP_ENV=development

FRONTEND_URL=http://localhost:5173
BACKEND_URL=http://localhost:8080

SERVER_HOST=0.0.0.0
SERVER_PORT=8080

WS_PATH=/ws

DATABASE_URL=
REDIS_URL=

JWT_SECRET=change-this-later
```

---

## Running the Project

### Backend

From the project root:

```bash
cd backend
go run ./cmd/server
```

Expected backend URL:

```txt
http://localhost:8080
```

### Frontend

From the project root:

```bash
cd frontend
bun dev
```

Expected frontend URL:

```txt
http://localhost:5173
```

---

## Planned First Milestone

The first milestone is not full gameplay yet.

The first goal is to establish a clean working connection between the frontend and backend.

### Phase 1 Scope

```txt
Backend health endpoint
Frontend backend-status panel
CORS configuration
Root environment configuration
Basic development run commands
```

Expected health endpoint:

```txt
GET /health
```

Expected response:

```json
{
  "status": "ok",
  "service": "nodestrike-backend",
  "environment": "development"
}
```

---

## Game Concept

**NODESTRIKE: Arena Protocol** is a tactical web FPS where players battle inside digital combat arenas called Arena Nodes.

Players compete as attacking and defending teams in objective-based matches where the attacking team attempts to upload the **Protocol Core**, while defenders attempt to stop the breach.

### Main Mode

```txt
Protocol Clash
```

### Core Match Idea

```txt
Attackers: Breach Unit
Defenders: Firewall Unit
Objective: Upload or defend the Protocol Core
```

---

## Development Principles

```txt
Keep the server authoritative.
Do not trust the browser for critical game state.
Build the health connection first before gameplay.
Keep frontend rendering separate from backend simulation.
Use shared schemas and protocol contracts.
Add dynamic content through registries.
Avoid premature complexity.
```

---

## Current Status

```txt
Phase 1: Frontend-Backend Connectivity completed
- Authoritative standard-library Go backend online
- /health diagnostics endpoint verified
- Custom CORS middleware implemented (supports localhost/127.0.0.1/LAN)
- Modular Frontend API helper implemented (health checks & latency ping)
- Responsive sci-fi cyber HUD status panel added
```
