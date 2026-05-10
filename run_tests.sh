#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "🚀 Starting API Test Automation..."
echo "=================================="

# Clear results folder
rm -rf results/*

# Run tests and check status directly
if robot \
  --outputdir results \
  --log results/log.html \
  --report results/report.html \
  --output results/output.xml \
  tests/; then
  echo -e "${GREEN}✅ All tests passed successfully!${NC}"
else
  echo -e "${RED}❌ Some tests failed!${NC}"
fi

echo "=================================="
echo "📊 Report: results/report.html"