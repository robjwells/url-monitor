# Set a bunch of error-checking options
# -e is exit on errors
# -u is exit on unbound variables
# -o pipefail exits on pipe errors
set -euo pipefail

if (( $# == 0 )); then
	echo usage: url html-dir diff-dir
	exit 1
fi

# Directory and filename variables
OUTDIR="$2"
DIFFDIR="$3"
BASE="$(basename $1)"
OUTFN="$BASE-$(date +'%Y%m%dT%H%M%S')"

# Download the source of the URL given as an argument
curl -s --output "$OUTDIR$OUTFN" "$1"

# If there aren't enough files to compare, exit early (successfully)
# This is useful when running the script for the first time
if (( $(ls -1 html-source | wc -l) < 2 )); then
	exit 0
fi

# Find the most recent two source files
# Here we find all the source files sharing a basename, sort
# newest-first, pick the top two, then sort oldest-first
# so that they're in order for diff
INPUT_FILES=$(find html-source -type f -name "$BASE*" | sort -r | head -n 2 | sort)

# Save a unified diff of the two most recent input files
diff -u $INPUT_FILES > "$DIFFDIR$OUTFN.patch"

# diff exits with 0 when there are no differences
# In that case, we remove the newest source file (as it's
# the same as the second-newest) and delete the empty
# patch that diff saved into the diffs folder
if (( $? == 0 )); then
	rm "$OUTDIR$OUTFN"
	find "$DIFFDIR" -type f -empty -delete
fi
