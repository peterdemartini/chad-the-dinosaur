Left = require '../../../../client/game/commands/left'

describe 'Left', ->
  beforeEach ->
    @sut = new Left

  describe '->start', ->
    describe 'when called with state', ->
      beforeEach (done) ->
        @sut.start {x: 2, y: 2}, (@state) => done()

      it 'should have a state of x=0 and y=2', ->
        expect(@state).to.deep.equal x:0, y:2

    describe 'when called with a positive state', ->
      beforeEach (done) ->
        @sut.start {x: 200, y: 0}, (@state) => done()

      it 'should have a state of x=195 and y=2', ->
        expect(@state).to.deep.equal x:195, y:0
