#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# The directory containing this script (scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Root directory of the repository
ROOT_DIR="$( dirname "$SCRIPT_DIR" )"

echo "Initializing NODESTRIKE directory structure..."
echo "Root directory: $ROOT_DIR"

# Define the directories to create
DIRS=(
  # Root-level Shared
  "shared/protocol/messages"
  "shared/protocol/events"
  "shared/protocol/errors"
  "shared/protocol/versions"
  "shared/schemas/characters"
  "shared/schemas/weapons"
  "shared/schemas/maps"
  "shared/schemas/lobbies"
  "shared/schemas/game-modes"
  "shared/schemas/cosmetics"
  "shared/constants/gameplay"
  "shared/constants/networking"
  "shared/constants/matchmaking"

  # Root-level Docs
  "docs/architecture"
  "docs/game-design"
  "docs/networking"
  "docs/backend"
  "docs/frontend"
  "docs/database"
  "docs/deployment"
  "docs/security"

  # Root-level Scripts
  "scripts/dev"
  "scripts/build"
  "scripts/test"
  "scripts/deploy"
  "scripts/database"

  # Root-level Deployments
  "deployments/docker"
  "deployments/nginx"
  "deployments/fly"
  "deployments/render"
  "deployments/railway"
  "deployments/vercel"

  # Frontend Assets & Data
  "frontend/public/assets/characters"
  "frontend/public/assets/weapons"
  "frontend/public/assets/maps"
  "frontend/public/assets/lobbies"
  "frontend/public/assets/audio"
  "frontend/public/assets/textures"
  "frontend/public/assets/models"
  "frontend/public/assets/icons"
  "frontend/public/assets/ui"
  "frontend/public/data/characters"
  "frontend/public/data/weapons"
  "frontend/public/data/maps"
  "frontend/public/data/lobbies"
  "frontend/public/data/game-modes"
  "frontend/public/data/cosmetics"

  # Frontend Source Structure
  "frontend/src/app/providers"
  "frontend/src/app/router"
  "frontend/src/app/config"
  "frontend/src/pages/home"
  "frontend/src/pages/auth"
  "frontend/src/pages/lobby"
  "frontend/src/pages/matchmaking"
  "frontend/src/pages/loadout"
  "frontend/src/pages/inventory"
  "frontend/src/pages/profile"
  "frontend/src/pages/settings"
  "frontend/src/pages/match"
  "frontend/src/pages/results"

  # Frontend Game Engine
  "frontend/src/game/engine/renderer"
  "frontend/src/game/engine/scene"
  "frontend/src/game/engine/camera"
  "frontend/src/game/engine/physics"
  "frontend/src/game/engine/input"
  "frontend/src/game/engine/collision"
  "frontend/src/game/engine/animation"
  "frontend/src/game/engine/audio"
  "frontend/src/game/engine/lighting"
  "frontend/src/game/engine/loaders"

  # Frontend Game Core
  "frontend/src/game/core/loop"
  "frontend/src/game/core/tick"
  "frontend/src/game/core/time"
  "frontend/src/game/core/events"
  "frontend/src/game/core/state"

  # Frontend Game Entities
  "frontend/src/game/entities/player"
  "frontend/src/game/entities/character"
  "frontend/src/game/entities/weapon"
  "frontend/src/game/entities/projectile"
  "frontend/src/game/entities/pickup"
  "frontend/src/game/entities/objective"
  "frontend/src/game/entities/bot"
  "frontend/src/game/entities/environment"

  # Frontend Game Systems
  "frontend/src/game/systems/movement"
  "frontend/src/game/systems/shooting"
  "frontend/src/game/systems/damage"
  "frontend/src/game/systems/health"
  "frontend/src/game/systems/respawn"
  "frontend/src/game/systems/round"
  "frontend/src/game/systems/objective"
  "frontend/src/game/systems/inventory"
  "frontend/src/game/systems/abilities"
  "frontend/src/game/systems/recoil"
  "frontend/src/game/systems/hitmarker"
  "frontend/src/game/systems/spectator"

  # Frontend Game Content Registry
  "frontend/src/game/content/characters"
  "frontend/src/game/content/weapons"
  "frontend/src/game/content/maps"
  "frontend/src/game/content/lobbies"
  "frontend/src/game/content/game-modes"
  "frontend/src/game/content/abilities"
  "frontend/src/game/content/skins"
  "frontend/src/game/content/attachments"

  # Frontend Multiplayer
  "frontend/src/game/multiplayer/client"
  "frontend/src/game/multiplayer/prediction"
  "frontend/src/game/multiplayer/interpolation"
  "frontend/src/game/multiplayer/reconciliation"
  "frontend/src/game/multiplayer/snapshots"
  "frontend/src/game/multiplayer/messages"
  "frontend/src/game/multiplayer/sync"

  # Frontend Game Modes
  "frontend/src/game/modes/deathmatch"
  "frontend/src/game/modes/team-deathmatch"
  "frontend/src/game/modes/protocol-clash"
  "frontend/src/game/modes/training"
  "frontend/src/game/modes/custom"

  # Frontend Maps Registry
  "frontend/src/game/maps/registry"
  "frontend/src/game/maps/loaders"
  "frontend/src/game/maps/spawns"
  "frontend/src/game/maps/objectives"
  "frontend/src/game/maps/navigation"
  "frontend/src/game/maps/collisions"

  # Frontend Weapons Registry
  "frontend/src/game/weapons/registry"
  "frontend/src/game/weapons/rifles"
  "frontend/src/game/weapons/pistols"
  "frontend/src/game/weapons/smgs"
  "frontend/src/game/weapons/shotguns"
  "frontend/src/game/weapons/snipers"
  "frontend/src/game/weapons/melee"
  "frontend/src/game/weapons/attachments"

  # Frontend Characters Registry
  "frontend/src/game/characters/registry"
  "frontend/src/game/characters/classes"
  "frontend/src/game/characters/skins"
  "frontend/src/game/characters/animations"
  "frontend/src/game/characters/abilities"

  # Frontend Debug Overlays
  "frontend/src/game/debug/overlays"
  "frontend/src/game/debug/performance"
  "frontend/src/game/debug/network"
  "frontend/src/game/debug/tools"

  # Frontend Features (Web interface layer)
  "frontend/src/features/auth"
  "frontend/src/features/lobby"
  "frontend/src/features/matchmaking"
  "frontend/src/features/party"
  "frontend/src/features/friends"
  "frontend/src/features/chat"
  "frontend/src/features/loadout"
  "frontend/src/features/inventory"
  "frontend/src/features/store"
  "frontend/src/features/battle-pass"
  "frontend/src/features/leaderboard"
  "frontend/src/features/profile"
  "frontend/src/features/settings"
  "frontend/src/features/match-history"

  # Frontend reusable UI components
  "frontend/src/ui/components"
  "frontend/src/ui/layouts"
  "frontend/src/ui/hud"
  "frontend/src/ui/menus"
  "frontend/src/ui/modals"
  "frontend/src/ui/forms"
  "frontend/src/ui/buttons"
  "frontend/src/ui/cards"
  "frontend/src/ui/overlays"
  "frontend/src/ui/animations"
  "frontend/src/ui/themes"

  # Frontend Services
  "frontend/src/services/api"
  "frontend/src/services/websocket"
  "frontend/src/services/storage"
  "frontend/src/services/telemetry"
  "frontend/src/services/analytics"

  # Frontend State Stores
  "frontend/src/stores/auth"
  "frontend/src/stores/lobby"
  "frontend/src/stores/match"
  "frontend/src/stores/player"
  "frontend/src/stores/settings"
  "frontend/src/stores/ui"

  # Frontend Custom Hooks
  "frontend/src/hooks/game"
  "frontend/src/hooks/network"
  "frontend/src/hooks/input"
  "frontend/src/hooks/ui"

  # Frontend Shared Types
  "frontend/src/types/api"
  "frontend/src/types/game"
  "frontend/src/types/network"
  "frontend/src/types/shared"

  # Frontend Core folders (constants, utils, styles)
  "frontend/src/constants"
  "frontend/src/utils"
  "frontend/src/styles"

  # Frontend Tests
  "frontend/tests/unit"
  "frontend/tests/integration"
  "frontend/tests/e2e"

  # Backend Executables
  "backend/cmd/server"
  "backend/cmd/worker"
  "backend/cmd/match-server"
  "backend/cmd/tools"

  # Backend Bootstrap & Config
  "backend/internal/app/config"
  "backend/internal/app/bootstrap"
  "backend/internal/app/lifecycle"
  "backend/internal/app/dependencies"

  # Backend Transport (HTTP & WebSockets)
  "backend/internal/transport/http/handlers"
  "backend/internal/transport/http/middleware"
  "backend/internal/transport/http/routes"
  "backend/internal/transport/http/responses"
  "backend/internal/transport/websocket/gateway"
  "backend/internal/transport/websocket/connections"
  "backend/internal/transport/websocket/messages"
  "backend/internal/transport/websocket/sessions"
  "backend/internal/transport/websocket/subscriptions"

  # Backend Domain Entities
  "backend/internal/domain/users"
  "backend/internal/domain/players"
  "backend/internal/domain/characters"
  "backend/internal/domain/weapons"
  "backend/internal/domain/maps"
  "backend/internal/domain/lobbies"
  "backend/internal/domain/parties"
  "backend/internal/domain/matchmaking"
  "backend/internal/domain/matches"
  "backend/internal/domain/rounds"
  "backend/internal/domain/teams"
  "backend/internal/domain/inventory"
  "backend/internal/domain/loadouts"
  "backend/internal/domain/cosmetics"
  "backend/internal/domain/leaderboards"
  "backend/internal/domain/progression"
  "backend/internal/domain/economy"

  # Backend Authoritative Game Loop
  "backend/internal/game/server/tick"
  "backend/internal/game/server/loop"
  "backend/internal/game/server/state"
  "backend/internal/game/server/snapshots"
  "backend/internal/game/server/authority"

  # Backend Game Simulation
  "backend/internal/game/simulation/movement"
  "backend/internal/game/simulation/combat"
  "backend/internal/game/simulation/hitreg"
  "backend/internal/game/simulation/physics"
  "backend/internal/game/simulation/damage"
  "backend/internal/game/simulation/respawn"
  "backend/internal/game/simulation/objectives"
  "backend/internal/game/simulation/validation"

  # Backend Content Registries
  "backend/internal/game/content/registries"
  "backend/internal/game/content/characters"
  "backend/internal/game/content/weapons"
  "backend/internal/game/content/maps"
  "backend/internal/game/content/lobbies"
  "backend/internal/game/content/game-modes"
  "backend/internal/game/content/abilities"
  "backend/internal/game/content/attachments"
  "backend/internal/game/content/cosmetics"

  # Backend Game Modes
  "backend/internal/game/modes/deathmatch"
  "backend/internal/game/modes/team-deathmatch"
  "backend/internal/game/modes/protocol-clash"
  "backend/internal/game/modes/training"
  "backend/internal/game/modes/custom"

  # Backend Anti-Cheat
  "backend/internal/game/anti-cheat/movement"
  "backend/internal/game/anti-cheat/fire-rate"
  "backend/internal/game/anti-cheat/hit-validation"
  "backend/internal/game/anti-cheat/session"
  "backend/internal/game/anti-cheat/reports"

  # Backend Business Services
  "backend/internal/services/auth"
  "backend/internal/services/users"
  "backend/internal/services/lobby"
  "backend/internal/services/party"
  "backend/internal/services/matchmaking"
  "backend/internal/services/matchmaker"
  "backend/internal/services/match-session"
  "backend/internal/services/inventory"
  "backend/internal/services/loadout"
  "backend/internal/services/leaderboard"
  "backend/internal/services/telemetry"
  "backend/internal/services/notifications"

  # Backend Repositories
  "backend/internal/repositories/users"
  "backend/internal/repositories/matches"
  "backend/internal/repositories/stats"
  "backend/internal/repositories/inventory"
  "backend/internal/repositories/loadouts"
  "backend/internal/repositories/leaderboards"

  # Backend Infrastructure
  "backend/internal/infrastructure/database/postgres"
  "backend/internal/infrastructure/database/migrations"
  "backend/internal/infrastructure/database/seeds"
  "backend/internal/infrastructure/cache/redis"
  "backend/internal/infrastructure/queue"
  "backend/internal/infrastructure/storage"
  "backend/internal/infrastructure/logging"
  "backend/internal/infrastructure/metrics"
  "backend/internal/infrastructure/security"

  # Backend Protocols & Shared package
  "backend/internal/protocol/client-to-server"
  "backend/internal/protocol/server-to-client"
  "backend/internal/protocol/events"
  "backend/internal/protocol/errors"
  "backend/internal/protocol/versions"

  "backend/internal/pkg/validator"
  "backend/internal/pkg/clock"
  "backend/internal/pkg/ids"
  "backend/internal/pkg/math"
  "backend/internal/pkg/errors"

  "backend/pkg/logger"
  "backend/pkg/env"
  "backend/pkg/jwt"
  "backend/pkg/hash"
  "backend/pkg/websocket"

  # Backend Tests
  "backend/tests/unit"
  "backend/tests/integration"
  "backend/tests/load"
  "backend/tests/simulation"
)

# Loop and create directories safely
for dir in "${DIRS[@]}"; do
  DIR_PATH="$ROOT_DIR/$dir"
  
  # Check if directory exists, if not create it
  if [ ! -d "$DIR_PATH" ]; then
    mkdir -p "$DIR_PATH"
  fi

  # Check if directory has no files (only check regular files, ignore folders)
  # If it has 0 regular files, write/overwrite a .gitkeep
  FILE_COUNT=$(find "$DIR_PATH" -maxdepth 1 -type f | wc -l)
  if [ "$FILE_COUNT" -eq 0 ]; then
    touch "$DIR_PATH/.gitkeep"
  fi
done

echo "NODESTRIKE directory structure created successfully!"
