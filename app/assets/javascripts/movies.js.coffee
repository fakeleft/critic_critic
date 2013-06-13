# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".up").click ->
    $(this).toggleClass("selected")
    $(this).parent().children(".down").toggleClass("disabled")
    $(this).parent().children(".down").children("i").toggleClass("disabled")

  $(".down").click ->
    $(this).toggleClass("selected")
    $(this).parent().children(".up").toggleClass("disabled")
    $(this).parent().children(".up").children("i").toggleClass("disabled")
