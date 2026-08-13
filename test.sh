#!/bin/bash

echo "Testing application..."

# Delay the job a bit to allow services to start
sleep 5

# Test frontend
echo "Testing frontend..."

curl -f http://localhost:8080/healthz
if [ $? -eq 0 ]; then
  echo "Frontend working"
else
  echo "Frontend failed"
  exit 1
fi

# Test backend
echo "Testing backend..."

curl -f http://localhost:9000/fortunes/random
if [ $? -eq 0 ]; then
  echo "Backend working"
else
  echo "Backend failed"
  exit 1
fi

echo "CONGRATSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"