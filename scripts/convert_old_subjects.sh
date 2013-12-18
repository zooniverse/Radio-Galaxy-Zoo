#!/bin/bash

mkdir converted

for f in *.fits
do
  echo "Convert $f"
  python make_contours.py $f | gzip > converted/"${f%%.*}".json
done

s3cmd put --recursive --acl-public --add-header "Content-Encoding: gzip" --mime-type "application/json" converted/ s3://radio.galaxyzoo.org/beta/subjects/contours/