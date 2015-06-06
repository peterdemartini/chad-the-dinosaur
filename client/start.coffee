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
    $(document).keypress (event) =>
      event ?= window.event
      code = event.which ? event.keyCode
      console.log 'pressed key', code
      switch code
        when 37 then @gameRunner.left()
        when 38 then @gameRunner.up()
        when 39 then @gameRunner.right()
        when 40 then @gameRunner.down()

starter = new Starter
starter.run()
