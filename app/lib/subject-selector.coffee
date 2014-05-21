Subject = zooniverse.models.Subject
Api = zooniverse.Api

class SubjectSelector
  
  constructor: ->
    addEventListener 'hashchange', @onHashChange, false
    @onHashChange()

  onHashChange: =>
    cleanHash = location.hash.match(/([\w]+[\w\/]+)/gi)
    pieces = cleanHash?.pop().split('/')
    return unless pieces?[0] is 'classify'
    @loadSubject pieces[1]

  loadSubject: (subjectId) =>
    Api.current.get "projects/#{ Api.current.project }/subjects/#{ subjectId }", (rawSubject) ->
      return unless rawSubject
      subject = new Subject rawSubject
      subject.select()

module.exports = SubjectSelector
