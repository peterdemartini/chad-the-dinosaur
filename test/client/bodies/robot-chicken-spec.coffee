RobotChicken = require '../../../client/bodies/robot-chicken'
PhysicsJS = require '../PhysicsJS'
config       = require '../../../client/config'

describe 'RobotChicken', ->
  beforeEach ->
    screen = width: 600, height: 300
    @lodash = {}
    @sut = new RobotChicken 1002, screen, PhysicsJS: PhysicsJS, _ : @lodash

  it 'should have property PhysicsJS', ->
    expect(@sut.PhysicsJS).to.equal PhysicsJS

  describe '->add', ->
    beforeEach ->
      PhysicsJS.body = sinon.stub().returns sleep: sinon.spy()
      @sut.getProperties = sinon.stub().returns name: 'robot-chicken'
      @object = @sut.add()

    it 'should call PhysicsJS.body', ->
      expect(PhysicsJS.body).to.have.been.calledWith 'rectangle', name: 'robot-chicken'

    it 'should set the object', ->
      expect(@object).to.equal @sut.object

  describe '->getImage', ->
    beforeEach ->
      @image = @sut.getImage()

    it 'should return the image', ->
      expect(@image).to.deep.equal
        src: '/assets/robot-chicken.svg'
        width: 20
        height: 20

  describe '->getProperties', ->
    beforeEach ->
      @lodash.random = sinon.stub().returns 10
      @sut.getImage = sinon.stub().returns image: 'robot-chicken'
      @properties = @sut.getProperties()

    it 'should return the properties', ->
      expect(@properties).to.deep.equal
        uid: 1002
        view:
          image: 'robot-chicken'
        x: 550
        y: 160
        width: 20
        height: 20
        vx: config.ROBOT_CHICKEN.VX
        vy: config.ROBOT_CHICKEN.VY
        restitution: config.ROBOT_CHICKEN.RESTITUTION
        cof: config.ROBOT_CHICKEN.COF
        treatment: config.ROBOT_CHICKEN.TREATMENT
        typeObj: config.ROBOT_CHICKEN.TYPE
