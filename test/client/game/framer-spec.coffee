Framer = require '../../../client/game/framer'

describe 'Framer', ->
  beforeEach ->
    @sut = new Framer 1, 1

  describe 'constructor', ->
    it 'should use frameLength', ->
      expect(@sut.frameLength).to.equal 1

    it 'should use numberOfFrames', ->
      expect(@sut.numberOfFrames).to.equal 1

  describe '->start', ->
    beforeEach (done) ->
      @sut.start (@n) => done()

    it 'should have the correct n property', ->
      expect(@n).to.equal 0
