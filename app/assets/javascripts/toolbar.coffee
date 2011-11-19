$(document).ready ->
  $(".availability").bind "ajax:success", ->
    this.value = if $(this).value == "Available"
      "Unavailable"
    else
      "Available"
