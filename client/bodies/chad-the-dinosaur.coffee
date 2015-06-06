DefaultBody = require './default-body'

class ChadTheDinosaur extends DefaultBody
  constructor: (dependencies={}) ->
    super(dependencies)
    @width = 50
    @height = 50

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
      y: 100
      width: @width
      height: @height
      vx: 0.2
      vy: 0.01
    return properties

  add: =>
    return @PhysicsJS.body 'rectangle', @getProperties()


module.exports = ChadTheDinosaur
