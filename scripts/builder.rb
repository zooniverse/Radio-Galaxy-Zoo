require 'csv'
require 'json'
require 'bson'


@base_id = '520be919e4bb21ddd3'
@index = 0
tutorial_id = BSON::ObjectId("520be919e4bb21ddd3000314")

def next_id
  BSON::ObjectId("#{ @base_id }#{ @index.to_s(16).rjust(6, '0') }").tap{ @index += 1 }
end

redis = Ouroboros.redis["radio_#{ Rails.env }"] || Ouroboros.redis[Rails.env]
redis.keys('radio*').each do |key|
  redis.del key
end

if Rails.env == "development"
  subject_url_prefix = "0.0.0.0:9296/subjects"
  fits_extension = "fits"
else
  subject_url_prefix = "radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects"
  fits_extension = "fits.gz"
end

project = Project.where(name: 'radio').first || Project.create({
  _id: BSON::ObjectId('520be12ce4bb21ddcd000001'),
  name: 'radio',
  display_name: 'Radio Galaxy Zoo',
  workflow_name: 'primary',
  zooniverse_id: 28
})

workflow = project.workflows.first || Workflow.create({
  _id: BSON::ObjectId('520be12ce4bb21ddcd000002'),
  project_id: project.id,
  primary: true,
  name: 'radio_galaxy_zoo',
  description: 'radio galaxy zoo',
  entities: []
})

RadioSubject.destroy_all

# Open CSV describing data
path = File::join(File.dirname(__FILE__), '..', 'data-import', 'rgz', 'input_ELAIS.dat_good.csv')

# Open 2MASS metadata file
metadata_path = File::join(File.dirname(__FILE__), '2MASS-metadata.json')
twomass_metadata = JSON.parse File.read(metadata_path)

subjects = {}
CSV.foreach(path, :headers => true) do |row|
  src = row[0]
  id = next_id
  
  subject_hash = {
    _id: id,
    project_id: project.id,
    workflow_ids: [workflow.id],
    location: {
      standard: "http://#{subject_url_prefix}/standard/#{row[0]}.jpg",
      radio: "http://#{subject_url_prefix}/radio/#{row[0]}.jpg",
      raw: "//#{subject_url_prefix}/raw/#{row[0]}.#{fits_extension}"
    },
    coords: [ row[1].to_f, row[2].to_f ],
    metadata: {
      src: src,
      cid: row[3],
      swire: row[4],
    }
  }
  
  subject_hash[:tutorial] = true if id == tutorial_id
  
  # Append additional 2MASS catalog metadata if available
  if twomass_metadata[src]
    subject_hash[:metadata][:catalog] = twomass_metadata[src]
  end
  
  RadioSubject.create subject_hash
end

RadioSubject.activate_randomly
# SubjectImporter.perform_async 'RadioSubject'
