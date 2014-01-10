PlayScene =
  preload: ->

  create: ->

  update: ->

game = new Phaser.Game 640, 480, Phaser.AUTO, 'game'
game.state.add 'play', PlayScene
game.state.start 'play'
