class Guide extends Backbone.View
  el: '.example-container'

  events: {
    'click .example-selection' : 'toggleActive'
    'click .example' : 'toggleSelection'
  }

  initialize: ->
    @activeButton = @$('.example[data-type="compact"]')
    @activeContent = @$('#compact-examples')

  toggleActive: ->
    @$('.examples').toggleClass('active')
    @$('.example-selection').toggleClass('active')

  toggleSelection: (e) -> 
    target = $(e.target)
    return if target.hasClass('active')
    section = target.data('type')
    @activeContent.removeClass('active')
    @activeButton.removeClass('active')

    @activeContent = @$("##{section}-examples").addClass('active')
    @activeButton = target.addClass('active')

module.exports = Guide