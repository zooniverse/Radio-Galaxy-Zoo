class Guide extends Backbone.View
  el: '.example-container'

  events: {
    'click .example-selection' : 'toggleActive'
    'click .example' : 'toggleSelection'
    'input input' : 'updateOpacity'
    'click .pull-left' : 'toggleRadio'
    'click .pull-right' : 'toggleIR'
  }

  initialize: ->
    @$('input').val(0)
    @activeButton = @$('.example[data-type="compact"]')
    @activeContent = @$('#compact-examples')

  toggleActive: ->
    @$('.examples').toggleClass('active')
    @$('.example-selection').toggleClass('active')

  toggleSelection: (e) -> 
    @$('input').val(0)
    @$('.ir-ex').css('opacity', 0)
    target = $(e.target)
    return if target.hasClass('active')
    section = target.data('type')
    @activeContent.removeClass('active')
    @activeButton.removeClass('active')

    @activeContent = @$("##{section}-examples").addClass('active')
    @activeButton = target.addClass('active')

  updateOpacity: (ev) ->
    @$(ev.target).siblings().find('.ir-ex').css('opacity', parseFloat(ev.target.value))

  toggleRadio: (ev) ->
    console.log('here')
    @$(ev.target).siblings().find('.ir-ex').css('opacity', 0)
    @$(ev.target).siblings('input').val(0)

  toggleIR: (ev) ->
    console.log('here')
    @$(ev.target).siblings().find('.ir-ex').css('opacity', 1)
    @$(ev.target).siblings('input').val(1)

module.exports = Guide