#!/usr/bin/env bash

# Check if a filename was provided
if [ -z "$1" ]; then
	echo "Usage: $0 <font-file.ttf>"
	exit 1
fi

INPUT_FONT="$1"
OUTPUT_FONT="${INPUT_FONT%.*}-Cleaned.ttf"

pyftsubset "$INPUT_FONT" \
	--unicodes="U+0000-203A,U+203E-2048,U+204A-25FF,U+2800-FFFF" \
	--layout-features="*" \
	--output-file="$OUTPUT_FONT"

echo "Done! SubsetFont saved as: $OUTPUT_FONT"
