#!/bin/sh

echo "Remove ClovaHome from SUMMARY.md"
sed -i -e '/Home/d' ja-JP/SUMMARY.md
echo "Remove ClovaHome related contents."
grep -rl . -e '^<!--\stags\:.*ClovaHome.*-->' -e '^tags\:.*ClovaHome.*'
