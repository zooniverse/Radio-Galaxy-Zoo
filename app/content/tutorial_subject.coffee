
Subject   = zooniverse.models.Subject

module.exports =
  new Subject
    id: "520be919e4bb21ddd3000314"
    project_id: "520be12ce4bb21ddcd000001"
    workflow_ids: ["520be12ce4bb21ddcd000002"]
    # location:
    #   standard: "http://0.0.0.0:9296/subjects/standard/S923.jpg"
    #   radio: "http://0.0.0.0:9296/subjects/radio/S923.jpg"
    #   raw: "//0.0.0.0:9296/subjects/raw/S923.fits"
    location:
      standard: "http://radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects/standard/S923.jpg"
      radio: "http://radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects/radio/S923.jpg"
      raw: "//radio.galaxyzoo.org.s3.amazonaws.com/beta/subjects/raw/S923.fits.gz"
    coords: [7.67545, -43.3931694444]
    metadata:
      src: "S923"
      cid: "C0923"
      swire: "J003042.10-432335.4"
    zooniverse_id: "ARG00000lx"
    tutorial: true