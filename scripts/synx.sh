#!/bin/bash

synx --no-sort-by-name PAP.xcodeproj

echo 
echo 
echo =====================================================
echo List of empty forlders
echo =====================================================
find ./PAP -depth -type d -empty
echo end