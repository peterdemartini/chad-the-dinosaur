GameRunner = require './game-runner'

class Starter
  run: =>
    elementId = 'the-game'
    @gameRunner = new GameRunner elementId
    screen =
      height: $("##{elementId}").height()
      width: $("##{elementId}").width()
    @gameRunner.setScreen screen
    @gameRunner.start()
    @bindCommands()

  bindCommands: =>
    document.onkeypress = (event) =>
      code = event.which ? event.keyCode
      console.log 'pressed key', code
      switch code
        when 97 then @gameRunner.left()
        when 119 then @gameRunner.up()
        when 100 then @gameRunner.right()
        when 115 then @gameRunner.down()

starter = new Starter
starter.run()
