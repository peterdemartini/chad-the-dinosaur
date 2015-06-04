GameRunner = require '../../../client/game/game-runner'

describe 'GameRunner', ->
  beforeEach ->
    @jump =
      start: sinon.stub()

    @sut = new GameRunner jump: @jump

  describe '->getCurrentState',  ->
    describe 'when first called', ->
      beforeEach ->
        @sut.screenSize = width: 1000, height: 1000
        @sut.setDefaultState()
        @state = @sut.getCurrentState()

      it 'should yield current state with a dinosaur center of screen', ->
        expect(@state.dinosaur.x).to.equal 1000 / 2
        expect(@state.dinosaur.y).to.equal 1000 / 2

    describe 'when called with a different screenSize', ->
      beforeEach ->
        @sut.screenSize = width: 1250, height: 1250
        @sut.setDefaultState()
        @state = @sut.getCurrentState()

      it 'should yield current state with a dinosaur center of screen', ->
        expect(@state.dinosaur.x).to.equal 1250 / 2
        expect(@state.dinosaur.y).to.equal 1250 / 2

  describe '->up', ->
    beforeEach ->
      @jump =
        start: sinon.stub()
      @sut = new GameRunner jump: @jump
      @sut.screenSize = width: 1000, height: 1000
      @sut.setDefaultState()

    describe 'when called', ->
      beforeEach ->
        @sut.up()

      it 'should call commands.jump.run', ->
        expect(@jump.start).to.have.been.calledWith x: 500, y: 500

  describe '->left', ->
    beforeEach ->
      @left =
        start: sinon.stub()
      @sut = new GameRunner left: @left
      @sut.screenSize = width: 1000, height: 1000
      @sut.setDefaultState()

    describe 'when called', ->
      beforeEach ->
        @sut.left()

      it 'should call commands.jump.run', ->
        expect(@left.start).to.have.been.calledWith x: 500, y: 500

  describe '->right', ->
    beforeEach ->
      @right =
        start: sinon.stub()
      @sut = new GameRunner right: @right
      @sut.screenSize = width: 1000, height: 1000
      @sut.setDefaultState()

    describe 'when called', ->
      beforeEach ->
        @sut.right()

      it 'should call commands.jump.run', ->
        expect(@right.start).to.have.been.calledWith x: 500, y: 500
