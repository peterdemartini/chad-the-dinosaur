_           = require 'lodash'
DefaultBody = require './default-body'

LEFT_RIGHT_MOVES=5
LEFT_RIGHT_X_ADD=5
LEFT_RIGHT_DELAY=10

class ChadTheDinosaur extends DefaultBody
  constructor: (screen, dependencies={}) ->
    super screen, dependencies
    @width = 50
    @height = 50
    @jumping = false
    @TYPE = 'chad-the-dinosaur'

  getImage: =>
    image = new Image
    image.src = '/assets/dinosaur.svg'
    image.width = @width
    image.height = @height
    return image

  getProperties: =>
    properties =
      uid: 1
      view: @getImage()
      x: 50
      y: @screen.height - 100
      width: @width
      height: @height
      vx: 0.2
      vy: 0.01
      restitution: 1
      cof: 0
      typeObj: 'chad-the-dinosaur'
    return properties

  add: =>
    @object = @PhysicsJS.body 'rectangle', @getProperties()
    @object.sleep true
    @object

  jump: =>
    return if @jumping
    @object.state.vel.set(0.2, -0.2)
    @object.sleep false
    @jumping = true

  left: (callback=->) =>
    return callback new Error('already jumping') if @jumping
    done = _.after LEFT_RIGHT_MOVES, callback
    moveLeft = =>
      @object.state.pos.x -= LEFT_RIGHT_X_ADD
      done()
    _.times LEFT_RIGHT_MOVES, (n) =>
      _.delay moveLeft, LEFT_RIGHT_DELAY * n

  right: (callback=->) =>
    return callback new Error('already jumping') if @jumping
    done = _.after LEFT_RIGHT_MOVES, callback
    moveRight = =>
      @object.state.pos.x += LEFT_RIGHT_X_ADD
      done()
    _.times LEFT_RIGHT_MOVES, (n) =>
      _.delay moveRight, LEFT_RIGHT_DELAY * n

  onStep: =>

  onCollision: (impact)=>
    {bodyA, bodyB} = impact
    if @jumping &&  bodyA.typeObj == @TYPE && bodyB.uid == 2
      @jumping = false
      @object.sleep true


module.exports = ChadTheDinosaur
