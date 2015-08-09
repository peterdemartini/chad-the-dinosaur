Rocket = require '../../../client/bodies/rocket'
PhysicsJS = require '../PhysicsJS'
config    = require '../../../client/config'

describe 'Rocket', ->
  beforeEach ->
    screen = width: 600, height: 300
    @sut = new Rocket 1202, screen, PhysicsJS: PhysicsJS

  it 'should have property PhysicsJS', ->
    expect(@sut.PhysicsJS).to.equal PhysicsJS

  describe '->add', ->
    beforeEach ->
      PhysicsJS.body = sinon.stub().returns sleep: sinon.spy()
      @sut.getProperties = sinon.stub().returns name: 'rocket'
      @object = @sut.add()

    it 'should call PhysicsJS.body', ->
      expect(PhysicsJS.body).to.have.been.calledWith 'rectangle', name: 'rocket'

    it 'should set the object', ->
      expect(@object).to.equal @sut.object

  describe '->getImage', ->
    beforeEach ->
      @image = @sut.getImage()

    it 'should return the image', ->
      expect(@image).to.deep.equal
        src: config.ROCKET.IMAGE_PATH
        width: 15
        height: 10

  describe '->getProperties', ->
    beforeEach ->
      @sut.getImage = sinon.stub().returns image: 'rocket'
      @properties = @sut.getProperties({x:50, y:50})

    it 'should return the properties', ->
      expect(@properties).to.deep.equal
        uid: 1202
        view: image: 'rocket'
        x: 50
        y: 40
        width: 15
        height: 10
        vx: config.ROCKET.VX
        vy: config.ROCKET.VY
        restitution: config.ROCKET.RESTITUTION
        cof: config.ROCKET.COF
        treatment: config.ROCKET.TREATMENT
        typeObj: config.ROCKET.TYPE
        mass: config.ROCKET.MASS
