#!/bin/sh

echo "Remove Design from SUMMARY.md"
sed -i -e '/デザイン/d' ./SUMMARY.md
sed -i -e '/\/Design\//d' ./SUMMARY.md
