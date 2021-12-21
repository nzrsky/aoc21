#!/bin/sh

curl -sS -b "session=$AOC_SSID" https://adventofcode.com/2021/day/1/input \
  | awk '{if ($1 > prev){ max++ } prev = $1} END { print max-1 }'