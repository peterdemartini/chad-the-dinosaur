BodiesMap =
  'Ground': require './bodies/ground'
  'Chad'  : require './bodies/chad'

class BodiesFactory
  constructor: (@engine, @renderOptions) ->
    @bodies = _.mapValues BodiesMap, (Body, key) =>
      return new Body @engine, @renderOptions

  add: (name) =>
    @bodies[name].add() if @bodies[name]?

module.exports = BodiesFactory
