$(document).ready ->
  $(".available").bind "ajax:success", ->
    $(this).fadeOut();
    $(".unavailable").fadeIn();

  $(".unavailable").bind "ajax:success", ->
    $(this).fadeOut();
    $(".available").fadeIn();
