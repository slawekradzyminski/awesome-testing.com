#!/bin/bash

# Function to kill process running on port 4000
kill_port_4000() {
    local pid=$(lsof -ti:4000 2>/dev/null)
    if [ -n "$pid" ]; then
        echo "🔫 Killing process $pid running on port 4000"
        kill -9 $pid 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "✅ Successfully killed process $pid"
        else
            echo "❌ Failed to kill process $pid"
            exit 1
        fi
    else
        echo "ℹ️  No process found running on port 4000"
    fi
}

# Kill any process running on port 4000
kill_port_4000

# Also kill any Jekyll processes as backup
jekyll_pids=$(pgrep -f jekyll 2>/dev/null)
if [ -n "$jekyll_pids" ]; then
    echo "🧹 Cleaning up any remaining Jekyll processes..."
    echo "$jekyll_pids" | xargs kill -9 2>/dev/null
    echo "✅ Jekyll processes cleaned up"
fi

echo "🎯 Port 4000 is now free" 