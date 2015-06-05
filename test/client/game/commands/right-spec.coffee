Right = require '../../../../client/game/commands/right'

describe 'Right', ->
  beforeEach ->
    @framer = start: sinon.stub().yields(0)
    @sut = new Right framer: @framer

  describe '->start', ->
    describe 'when called with state', ->
      beforeEach (done) ->
        @sut.start {x: 2, y: 2}, (@state) => done()

      it 'should have a state of x=4 and y=2', ->
        expect(@state).to.deep.equal x:4, y:2

    describe 'when called with a positive state', ->
      beforeEach (done) ->
        @sut.start {x: 200, y: 0}, (@state) => done()

      it 'should have a state of x=202 and y=2', ->
        expect(@state).to.deep.equal x:202, y:0
