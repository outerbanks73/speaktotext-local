#!/bin/bash
# SpeakToText Local Server Stopper

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🛑 Stopping SpeakToText Local Server..."

# Kill any python server.py or uvicorn processes
pkill -9 -f "server\.py" 2>/dev/null
pkill -9 -f "uvicorn" 2>/dev/null

# Check if any were killed
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Server stopped${NC}"
else
    echo -e "${YELLOW}⚠️  No server processes found${NC}"
fi

echo "Done."
