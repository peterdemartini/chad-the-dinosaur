Jump = require '../../../../client/game/commands/jump'

describe 'Jump', ->
  beforeEach ->
    @sut = new Jump

  describe '->start', ->
    describe 'when called with state', ->
      beforeEach (done) ->
        @sut.start {x: 150, y: 150}, (@state) => done()

      it 'should have a state of x=151 and y=140', ->
        expect(@state).to.deep.equal x:151, y:140

    describe 'when called with a positive state', ->
      beforeEach (done) ->
        @sut.start {x: 200, y: 200}, (@state) => done()

      it 'should have a state of x=201 and y=190', ->
        expect(@state).to.deep.equal x:201, y:190
