#!/bin/bash

# Function to kill process running on port 4000
kill_port_4000() {
    local pid=$(lsof -ti:4000 2>/dev/null)
    if [ -n "$pid" ]; then
        echo "Killing process $pid running on port 4000"
        kill -9 $pid 2>/dev/null
        sleep 2
    fi
}

# Function to check if Jekyll is up (suppress curl output)
check_jekyll() {
    curl -sSf http://localhost:4000/ > /dev/null 2>&1
    return $?
}

# Kill any process running on port 4000
kill_port_4000

# Kill any running Jekyll processes as backup
pkill -f jekyll 2>/dev/null

# Wait a moment to ensure ports are freed
sleep 2

# Start Jekyll in the background
echo "Starting Jekyll..."
JEKYLL_ENV=development bundle exec jekyll serve --config _config.yml,_config.development.yml > jekyll.log 2>&1 &

# Store the Jekyll process ID for cleanup
JEKYLL_PID=$!

echo "Waiting for Jekyll to start... (see jekyll.log for details)"

TIMEOUT=120
COUNTER=0

# Wait for Jekyll to be available (timeout after $TIMEOUT seconds)
until check_jekyll || [ $COUNTER -eq $TIMEOUT ]; do
    sleep 1
    ((COUNTER++))
    echo -n "."
done

echo ""

if [ $COUNTER -eq $TIMEOUT ]; then
    echo "❌ Timeout waiting for Jekyll to start after $TIMEOUT seconds"
    kill_port_4000
    pkill -f jekyll 2>/dev/null
    exit 1
else
    echo "✅ Jekyll is up and running at http://localhost:4000/ after $COUNTER seconds"
    echo "📝 Logs are being written to jekyll.log"
    echo "🛑 Press Ctrl+C to stop the server"
    exit 0
fi