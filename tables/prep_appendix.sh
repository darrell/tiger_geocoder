#!/bin/sh

grep '^[0-9]\+	' ats2008apc.txt | sed -e 's:	-:	\\N:g' > directional.txt
grep '^[0-9]\+	' ats2008apd.txt | sed -e 's:	-:	\\N:g' > quals.txt
grep '^[0-9]\+	' ats2008ape.txt | sed -e 's:	-:	\\N:g' > types.txt
