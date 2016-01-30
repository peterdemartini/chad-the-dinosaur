BodiesMap =
  'Ground'      : require './bodies/ground'
  'Chad'        : require './bodies/chad'
  'RobotChicken': require './bodies/robot-chicken'

class BodiesFactory
  constructor: (@renderOptions) ->
    @bodies = _.mapValues BodiesMap, (Body, key) =>
      return new Body @renderOptions

  add: (name, callback) =>
    return callback new Error 'Missing Body' unless @bodies[name]?
    @bodies[name].add callback if @bodies[name]?

module.exports = BodiesFactory
