rm -rf build
haw build
s3cmd put --acl-public --recursive put build/ s3://radio.galaxyzoo.org/beta2/
# s3cmd put --acl-public put build/index.html s3://radio.galaxyzoo.org/beta2/
# s3cmd put --acl-public put build/application* s3://radio.galaxyzoo.org/beta2/
# s3cmd put --acl-public put build/workers/conrec.js s3://radio.galaxyzoo.org/beta2/workers/