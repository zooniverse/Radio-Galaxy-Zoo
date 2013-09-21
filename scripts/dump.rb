
# Utility to dump and compress Space Warps classifications


host = ENV['OUROBOROS_STAGING_HOST']
user = ENV['OUROBOROS_STAGING_USER']
pass = ENV['OUROBOROS_STAGING_PASS']
db = ENV['OUROBOROS_STAGING_DB']

timestamp = `date -u +%Y-%m-%d_%H-%M-%S`.chomp
out = "radio-galaxy-zoo-#{timestamp}"

`mongodump --host #{host} --username #{user} --password #{pass} --db #{db} --collection radio_subjects --out #{out}`
`mongodump --host #{host} --username #{user} --password #{pass} --db #{db} --collection radio_classifications --out #{out}`


`tar -zcvf #{out}.tar.gz #{out}`
`rm -rf #{out}`


# `s3cmd put --acl-public #{out}.tar.gz s3://spacewarps.org/data-export/`
# puts "http://spacewarps.org.s3.amazonaws.com/data-export/#{out}.tar.gz"