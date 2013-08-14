require 'json'
require 'bson'
require 'aws-sdk'


# Setup S3 connection
AWS.config access_key_id: ENV['S3_ACCESS_ID'], secret_access_key: ENV['S3_SECRET_KEY']
@s3 = AWS::S3.new
@bucket = @s3.buckets['radio.galaxyzoo.org']

@base_id = '520be919e4bb21ddd3'
@index = 0

def next_id
  BSON::ObjectId("#{ @base_id }#{ @index.to_s(16).rjust(6, '0') }").tap{ @index += 1 }
end

def upload(path, id)
  @manifest[id.to_s] = File.basename path
  obj = @bucket.objects["subjects/standard/#{ id }.png"]
  obj.write(file: path, acl: :public_read)
end

path = File::join(File.dirname(__FILE__), '..', 'public', 'data')

files = Dir["#{ path }/*_ir.png"]
files.each_with_index do |path, index|
  basename = File.basename path
  basename.gsub!('_ir', '')
  obj = @bucket.objects["beta/subjects/standard/#{basename}"]
  obj.write(file: path, acl: :public_read)
end

files = Dir["#{path}/*_radio.png"]
files.each_with_index do |path, index|
  basename = File.basename path
  basename.gsub!('_radio', '')
  obj = @bucket.objects["beta/subjects/radio/#{basename}"]
  obj.write(file: path, acl: :public_read)
end

files = Dir["#{path}/*_radio.fits"]
files.each_with_index do |path, index|
  basename = File.basename path
  basename.gsub!('_radio', '')
  obj = @bucket.objects["beta/subjects/raw/#{basename}"]
  obj.write(file: path, acl: :public_read)
end