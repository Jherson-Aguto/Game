# NODESTRIKE: Arena Protocol

A browser-based tactical FPS game using a TypeScript Vite frontend and a Go authoritative multiplayer backend.

## Project Structure and Directory Layout

The codebase is structured as a monorepo to maintain strong separation between the front-end rendering engine and the authoritative server simulation:

- **frontend/** = browser game client and UI
- **backend/** = Go HTTP/WebSocket authoritative server
- **shared/** = protocol, schemas, and constants shared by frontend and backend
- **docs/** = architecture and design documentation
- **scripts/** = setup, build, dev, and deployment scripts
- **deployments/** = Docker and hosting configuration

## Getting Started

### Initializing Directory Structure

To populate all required folders with `.gitkeep` trackers, run:

```bash
chmod +x scripts/setup_folders.sh
./scripts/setup_folders.sh
```
# Game
