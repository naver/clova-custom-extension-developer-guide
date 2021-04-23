#!/bin/sh

echo "Remove DevConsole from SUMMARY.md"
sed -i -e '/DevConsole/d' ./SUMMARY.md
sed -i -e '/Clova\ Developer\ Center/d' ./SUMMARY.md
