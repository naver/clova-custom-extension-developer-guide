#!/bin/sh

echo "Remove CIC from SUMMARY.md"
sed -i -e '/\/CIC\//d' ./SUMMARY.md
sed -i -e '/Clova\ Interface\ Connect/d' ./SUMMARY.md
