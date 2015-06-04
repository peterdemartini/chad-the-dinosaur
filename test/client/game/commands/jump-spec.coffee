Jump = require '../../../../client/game/commands/jump'
describe 'Jump', ->
  beforeEach ->
    @sut = new Jump

  describe '->start', ->
    it 'should be a function', ->
      expect(@sut.start).to.be.a 'function'
