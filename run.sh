#!/bin/bash
#bundle install

# Kill any running Jekyll processes
pkill -f jekyll

# Wait a moment to ensure ports are freed
sleep 3

# Start Jekyll in the background
JEKYLL_ENV=development bundle exec jekyll serve --config _config.yml,_config.development.yml > jekyll.log 2>&1 &

# Function to check if Jekyll is up
check_jekyll() {
    curl -sSf http://localhost:4000/ > /dev/null
    return $?
}

echo "Waiting for Jekyll to start..."

TIMEOUT=120
# Wait for Jekyll to be available (timeout after $TIMEOUT seconds)
COUNTER=0
until check_jekyll || [ $COUNTER -eq $TIMEOUT ]; do
    sleep 1
    ((COUNTER++))
    echo -n "."
done

if [ $COUNTER -eq $TIMEOUT ]; then
    echo "Timeout waiting for Jekyll to start after $TIMEOUT seconds"
    pkill -f jekyll
    exit 1
else
    echo "Jekyll is up and running at http://localhost:4000/ after $COUNTER seconds"
    exit 0
fi