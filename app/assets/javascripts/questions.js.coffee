# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.App ?= {}

# show question#edit form
App.edit_question = (event) ->
  event.preventDefault()
  question_id = $(@).data('questionId')
  $(@).hide()
  $("#question_item").hide()
  $("form#for_question_edit").show()

# show answer#edit form
App.edit_answer = (event) ->
  event.preventDefault()
  answer_id = $(@).data('answerId')
  $(@).hide()
  block = $('#answer-'+answer_id)
  block.find('.answer-body').hide()
  $(".answer-body" + answer_id).hide()
  $("form#for_answer_edit_" + answer_id).show()

$(document).on 'click', '#question_edit_link', App.edit_question

# live binding
# still works after answer#update and reloading answers list
$(document).on 'click', '.answers .edit-answer-link', App.edit_answer