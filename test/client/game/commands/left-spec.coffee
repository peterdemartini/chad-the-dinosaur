Left = require '../../../../client/game/commands/left'
describe 'Left', ->
  beforeEach ->
    @sut = new Left

  describe '->start', ->
    it 'should be a function', ->
      expect(@sut.start).to.be.a 'function'
