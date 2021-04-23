#!/bin/sh

echo "Remove CEK from SUMMARY.md"
sed -i -e '/\/CEK\//d' ./SUMMARY.md
sed -i -e '/Clova\ Extensions\ Kit/d' ./SUMMARY.md
