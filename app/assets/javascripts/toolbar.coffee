$(document).ready ->
  $(".available").bind "ajax:success", ->
    $(this).fadeOut();
    $(".unavailable").fadeIn();

  $(".unavailable").bind "ajax:success", ->
    $(this).fadeOut();
    $(".available").fadeIn();
  
  $(".pagination a[data-remote=true]").live "ajax:success", (e) ->
    window.history.pushState "", "", $(e.target).attr("href")

  $(window).bind "popstate", ->
    $.ajax
      url: window.location
      dataType: "script"


