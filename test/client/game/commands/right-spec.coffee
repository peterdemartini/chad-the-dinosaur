Right = require '../../../../client/game/commands/right'
describe 'Right', ->
  beforeEach ->
    @sut = new Right

  describe '->start', ->
    it 'should be a function', ->
      expect(@sut.start).to.be.a 'function'
