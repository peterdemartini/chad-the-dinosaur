_  = require 'lodash'

KEYS =
  hidden: "visibilitychange",
  webkitHidden: "webkitvisibilitychange",
  mozHidden: "mozvisibilitychange",
  msHidden: "msvisibilitychange"

class VIS
  constructor: ->

  start: (@onChangeCallback=->) =>
    @key = _.findWhere _.keys(KEYS), (key) => return document[key]?
    eventKey = KEYS[@key]
    document.addEventListener eventKey, @onChange, false

  onChange: =>
    state = !document[@key]
    console.log 'on state change', state
    @onChangeCallback state

module.exports = VIS
