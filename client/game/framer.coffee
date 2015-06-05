_ = require 'lodash'
class Framer
  constructor: (@numberOfFrames=10, @frameLength=10) ->

  start: (callback=->) =>
    _.times @numberOfFrames, (n) =>
      done = (n) => callback(n)
      _.delay done, @frameLength * n, n

module.exports = Framer
