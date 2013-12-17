class Steps extends Backbone.View
  el: "#classify"

  initialize: ->
    @listenTo(@model, 'change:step', @revealStep)
    @listenTo(@model, 'change:selected_contours', @disableCancel)
    @listenTo(@model, 'change:matched_contours', @disableMarkAnother)
    @listenTo(@model, 'change:ir_markings', @disableNoIR)
    @revealStep(@model)
    @disableCancel(@model)

  revealStep: (m, step) ->
    step or= m.get('step')
    @$(".instruction > div[data-step=#{step}]").show()
    @$(".instruction > div[data-step!=#{step}]").hide()

    @$(".buttons > div[data-step=#{step}]").show()
    @$(".buttons > div[data-step!=#{step}]").hide()

    @$("div.contours").removeClass("step-#{m.previous("step")}")
    @$("div.contours").addClass("step-#{step}")
    
    if step is 3
      @$('a.discuss').attr('href', @model.get('subject').talkHref())

  reset: ->
    @$("div.contours").removeClass("step-#{@model.get("step")}")

  disableCancel: (m) ->
    if _.isEmpty(m.get('selected_contours'))
      @$('.cancel').prop('disabled', true)
      @$('.no-contours').prop('disabled', false)
    else
      @$('.cancel').prop('disabled', false)
      @$('.no-contours').prop('disabled', true)

  disableMarkAnother: (m) ->
    if m.get('matched_contours').length == m.get('contours')?.length
      @$('.next-radio').prop('disabled', true)
    else
      @$('.next-radio').prop('disabled', false)

  disableNoIR: (m) ->
    if _.isEmpty(m.get("ir_markings"))
      @$('.no-infrared').prop("disabled", false)
    else
      @$('.no-infrared').prop("disabled", true)


module.exports = Steps
