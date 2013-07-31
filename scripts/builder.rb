require 'csv'
require 'json'

# Open CSV describing data
path = File::join(File.dirname(__FILE__), '..', 'data-import', 'rgz', 'input_ELAIS.dat_good.csv')

subjects = []
CSV.foreach(path, :headers => true) do |row|
  
  subject = {}
  
  subject['location'] = {}
  subject['location']['ir'] = "data/#{row[0]}_heatmap+contours.png"
  subject['location']['radio'] = "data/#{row[0]}_radio.png"
  subject['location']['raw'] = "data/#{row[0]}_radio.fits"
  
  subject['metadata'] = {}
  subject['coords'] = [ row[1], row[2] ]
  subject['metadata']['src'] = row[0]
  subject['metadata']['cid'] = row[3]
  subject['metadata']['swire'] = row[4]
  
  subjects.push subject
end

puts subjects.to_json()

outfile = File::join(File.dirname(__FILE__), '..', 'public', 'test-subjects.json')
File.open(outfile, 'w') { |f| f.write( subjects.to_json() ) }