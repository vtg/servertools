jQuery ->
  $(document).ajaxComplete (event, request) ->
    if $('#mail-link').length > 0
      window.location.href = $('#mail-link').attr('href')

