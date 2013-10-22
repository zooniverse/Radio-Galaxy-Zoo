
PHASE=beta2

rm -rf build
haw build
gzip -9 build/application*

for f in build/*.gz;
do
  mv $f ${f%.gz} 
done

s3cmd put --acl-public build/index.html s3://radio.galaxyzoo.org/$PHASE/
s3cmd put --acl-public --mime-type "application/javascript" --add-header "Content-Encoding: gzip" build/application*.js s3://radio.galaxyzoo.org/$PHASE/
s3cmd put --acl-public --mime-type "text/css" --add-header "Content-Encoding: gzip" build/application*.css s3://radio.galaxyzoo.org/$PHASE/
s3cmd put --acl-public put build/favicon.ico s3://radio.galaxyzoo.org/$PHASE/
s3cmd put --acl-public --recursive put build/images/ s3://radio.galaxyzoo.org/$PHASE/images/
s3cmd put --acl-public --recursive put build/workers/ s3://radio.galaxyzoo.org/$PHASE/workers/