GameRunner = require '../../../client/game/game-runner'

describe 'GameRunner', ->
  beforeEach ->
    @sut = new GameRunner

  describe '->getCurrentState',  ->
    describe 'when first called', ->
      beforeEach ->
        @sut.screenSize = width: 1000, height: 1000
        @sut.setIninitialState()
        @state = @sut.getCurrentState()

      it 'should yield current state with a dinosaur center of screen', ->
        expect(@state.dinosaur.x).to.equal 1000 / 2
        expect(@state.dinosaur.y).to.equal 1000 / 2

    describe 'when called with a different screenSize', ->
      beforeEach ->
        @sut.screenSize = width: 1250, height: 1250
        @sut.setIninitialState()
        @state = @sut.getCurrentState()

      it 'should yield current state with a dinosaur center of screen', ->
        expect(@state.dinosaur.x).to.equal 1250 / 2
        expect(@state.dinosaur.y).to.equal 1250 / 2
