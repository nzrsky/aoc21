#!/bin/sh

curl -sS -b "session=$AOC_SSID" https://adventofcode.com/2021/day/1/input \
	| awk '{if ($1 > prev) { print $1 }; prev = $1;}' | wc -l | xargs -I {} dc -e "{} 1 - p"