Subject = zooniverse.models.Subject
Api = zooniverse.Api

class SubjectSelector

  loadSubject: (subjectId) =>
    Api.current.get "projects/#{ Api.current.project }/subjects/#{ subjectId }", (rawSubject) ->
      return unless rawSubject
      subject = new Subject rawSubject
      subject.select()

  loadSubjects: (subject_ids) =>
    Api.current.post "projects/#{ Api.current.project }/subjects/batch", { subject_ids }, (rawSubjects) ->
      return unless rawSubjects.length > 0

      Subject.destroyAll()

      new Subject rawSubject for rawSubject in rawSubjects

      Subject.first().select()

module.exports = SubjectSelector
