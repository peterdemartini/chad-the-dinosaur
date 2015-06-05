Right = require '../../../../client/game/commands/right'

describe 'Right', ->
  beforeEach ->
    @sut = new Right

  describe '->start', ->
    describe 'when called with state', ->
      beforeEach (done) ->
        @sut.start {x: 2, y: 2}, (@state) => done()

      it 'should have a state of x=7 and y=2', ->
        expect(@state).to.deep.equal x:7, y:2

    describe 'when called with a positive state', ->
      beforeEach (done) ->
        @sut.start {x: 200, y: 0}, (@state) => done()

      it 'should have a state of x=205 and y=2', ->
        expect(@state).to.deep.equal x:205, y:0
