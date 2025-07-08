#!/bin/bash

echo -e "\n🚀 Executing unit test...\n"

echo "🧹 Cleaning up previous coverage..."
rm -rf coverage

echo -e "\n🧪 Running tests with coverage...\n"
flutter test --coverage
UNIT_EXIT_CODE=$?
cp coverage/lcov.info coverage/lcov_unit.info

echo -e "\n📊 Generating coverage report...\n"
if [ $UNIT_EXIT_CODE -ne 0 ]; then
  echo -e "\n❌ There are errors\n"
  exit 1
else
  echo -e "\n✅ All test work fine\n"
fi

if ! command -v genhtml &> /dev/null; then
  echo -e "\n❌ genhtml not installed. Please install: brew install lcov\n"
  exit 1
fi

genhtml coverage/lcov_unit.info -o coverage/html

if [ -f coverage/html/index.html ]; then
  open coverage/html/index.html
else
  echo -e "\n❌ Don't build the file coverage/html/index.html\n"
fi
