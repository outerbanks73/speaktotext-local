#!/bin/bash
# SpeakToText Local Server Stopper

PORT=5123

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🛑 Stopping SpeakToText Local Server..."

# Kill by port
if lsof -ti:$PORT > /dev/null 2>&1; then
    lsof -ti:$PORT | xargs kill -9 2>/dev/null || true
    echo -e "${GREEN}✓ Server stopped (port $PORT)${NC}"
else
    echo -e "${YELLOW}⚠️  No server running on port $PORT${NC}"
fi

# Also kill any lingering python server.py processes
pkill -f "python.*server\.py" 2>/dev/null || true

echo "Done."
