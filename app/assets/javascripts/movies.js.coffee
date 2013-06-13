# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".up").click ->
    $(".down").fadeToggle("slow", "linear");

$(document).ready ->
  $(".down").click ->
    $(".up").fadeToggle("slow", "linear");
