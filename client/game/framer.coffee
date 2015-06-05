_ = require 'lodash'
class Framer
  constructor: (@numberOfFrames=10, @frameLength=10) ->

  start: (callback=->) =>
    _.times @numberOfFrames, (n) =>
      n = 1 if n == 0
      _.delay =>
        callback(n)
      @frameLength * n

module.exports = Framer
