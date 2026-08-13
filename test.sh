#!/bin/bash

echo "Testing application..."

# delay the job a bit
sleep 5

# Test frontend
echo "Testing frontend..."
# send request to server

curl -f http://localhost:8080/healthz
if [ $? -eq 0 ]; then
  #cool, working
  echo "Frontend working"
else
  #didnt respond
  echo "Frontend failed"
  # exit 1 = stop
  exit 1
fi

# Test backend
echo "Testing backend..."
curl -f http://localhost:9000/fortunes/random
# Check if backend responded
if [ $? -eq 0 ]; then
  # success
  echo "Backend working"
else
  #didnt work
  echo "Backend failed"
  exit 1
fi

echo "CONGRATSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
