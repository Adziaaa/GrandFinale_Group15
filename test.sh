#!/bin/bash

echo "Testing application..."

# Give the containers time to start
sleep 5

# Test frontend
echo "Testing frontend..."
if curl -f http://localhost:8080/healthz; then
  echo "Frontend working"
else
  echo "Frontend failed"
  exit 1
fi

# Test backend
echo "Testing backend..."
if curl -f http://localhost:9000/fortunes/random; then
  echo "Backend working"
else
  echo "Backend failed"
  exit 1
fi

echo "All tests passed!"