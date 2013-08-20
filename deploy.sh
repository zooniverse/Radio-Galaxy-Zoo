rm -rf build
haw build
s3cmd put --acl-public --recursive put build/ s3://radio.galaxyzoo.org/beta/