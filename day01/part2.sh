#!/bin/sh

curl -sS -b "session=$AOC_SSID" https://adventofcode.com/2021/day/1/input \
  | awk '{if ($1 > prev1){ max++ } prev1 = prev2; prev2 = prev3; prev3 = $1} END { print max-3 }'