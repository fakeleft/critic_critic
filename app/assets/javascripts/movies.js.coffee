$(document).ready ->

  # $(".up, .down").click ->
  #   sibling = $(@).siblings()
  #   unless sibling.hasClass("disabled")
  #     $(@).toggleClass("selected")
  #     sibling.toggleClass("disabled")
  #     if $(@).hasClass("disabled")
  #       $(@).toggleClass("disabled")

  $('div.btn-group .btn').click ->
    $(this).find('input:radio').attr('checked', true);
