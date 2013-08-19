require 'csv'
require 'json'
require 'bson'


@base_id = '520be919e4bb21ddd3'
@index = 0

def next_id
  BSON::ObjectId("#{ @base_id }#{ @index.to_s(16).rjust(6, '0') }").tap{ @index += 1 }
end

if Rails.env == "development"
  redis = Ouroboros.redis["radio_#{ Rails.env }"] || Ouroboros.redis[Rails.env]
  redis.keys('radio*').each do |key|
    redis.del key
  end
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

subjects = {}
CSV.foreach(path, :headers => true) do |row|
  
  subject_hash = {
    _id: next_id,
    project_id: project.id,
    workflow_ids: [workflow.id],
    location: {
      standard: "http://radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects/standard/#{row[0]}.jpg",
      radio: "http://radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects/radio/#{row[0]}.jpg",
      raw: "http://radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects/raw/#{row[0]}.fits.gz"
    },
    coords: [ row[1].to_f, row[2].to_f ],
    metadata: {
      src: row[0],
      cid: row[3],
      swire: row[4]
    }
  }
  
  RadioSubject.create subject_hash
end

# RadioSubject.activate_randomly
SubjectImporter.perform_async 'RadioSubject'
