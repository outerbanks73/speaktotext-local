#!/bin/bash
# SpeakToText Local Server Launcher

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PORT=5123

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🎙️  SpeakToText Local Server"
echo "================================"

# Check if port is already in use and kill existing process
if lsof -ti:$PORT > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Port $PORT is in use. Stopping existing server...${NC}"
    lsof -ti:$PORT | xargs kill -9 2>/dev/null || true
    sleep 1
    echo -e "${GREEN}✓ Previous server stopped${NC}"
fi

# Also kill any lingering python server.py processes
pkill -f "python.*server\.py" 2>/dev/null || true

# Activate virtual environment if it exists
if [ -f "$SCRIPT_DIR/server/venv/bin/activate" ]; then
    source "$SCRIPT_DIR/server/venv/bin/activate"
else
    echo -e "${YELLOW}⚠️  No virtual environment found. Using system Python.${NC}"
fi

echo -e "${GREEN}Starting server on http://localhost:$PORT${NC}"
echo ""

python "$SCRIPT_DIR/server/server.py"
