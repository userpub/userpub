angular.module('userpub').filter 'chatMessage', ->
  (input)->
    out = input.trim()
    if out.split("\n").length > 1
      out = "<pre>#{out}</pre>"
    out