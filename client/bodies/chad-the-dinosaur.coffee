DefaultBody = require './default-body'

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

  onStep: =>

  onCollision: (impact)=>
    {bodyA, bodyB} = impact
    if @jumping &&  bodyA.typeObj == @TYPE && bodyB.uid == 2
      @jumping = false
      @object.sleep true


module.exports = ChadTheDinosaur
