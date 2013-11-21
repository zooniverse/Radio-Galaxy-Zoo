class Steps extends Backbone.View
  el: "#classify"

  initialize: ->
    @listenTo(@model, 'change:step', @revelStep)
    @revealStep(@model)

  revealStep: (m, step) ->
    step or= m.get('step')
    console.log(step)
    @$(".instruction > div[data-step=#{step}]").show()
    @$(".instruction > div[data-step!=#{step}]").hide()

    @$(".buttons > div[data-step=#{step}]").show()
    @$(".buttons > div[data-step!=#{step}]").hide()

    @$("div.contours").removeClass("step-#{m.previous("step")}")
    @$("div.contours").addClass("step-#{step}")

module.exports = Steps
