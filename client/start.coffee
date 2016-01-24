GameRunner = require './game-runner'
VIS        = require './vis'

class Starter
  run: =>
    @gameRunner = new GameRunner document.body
    @gameRunner.setRenderOptions
      height: $('body').height()
      width: $('body').width()
    @gameRunner.start()
    @bindCommands()
    @listenForPause()

  controlGame: (code) =>
    console.log 'control code', code
    switch code
      when 32 then @gameRunner.fire()
      when 97 then @gameRunner.left()
      when 37 then @gameRunner.left()
      when 65 then @gameRunner.left()
      when 119 then @gameRunner.up()
      when 87 then @gameRunner.up()
      when 38 then @gameRunner.up()
      when 100 then @gameRunner.right()
      when 68 then @gameRunner.right()
      when 39 then @gameRunner.right()
      when 115 then @gameRunner.down()
      when 80 then @gameRunner.down()
      when 40 then @gameRunner.down()

  bindCommands: =>
    $(document).keyup (event) =>
      @controlGame event.which ? event.keyCode

  listenForPause: =>
    vis = new VIS
    vis.start (state) =>
      return @gameRunner.pause() unless state
      return @gameRunner.resume()

starter = new Starter
starter.run()
