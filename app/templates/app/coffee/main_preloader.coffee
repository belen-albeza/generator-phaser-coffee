BootScene =
  preload: ->
    # load here assets required for loading screen
    @game.load.image 'preloader_bar', 'assets/images/preloader_bar.png'

  create: ->
    @game.state.start 'preloader'


PreloaderScene =
  preload: ->
    @loadingBar = @game.add.sprite 0, 240, 'preloader_bar'
    @loadingBar.anchor.setTo 0, 0.5
    @load.setPreloadSprite @loadingBar

    # load here the assets we need

  create: ->
    @game.state.start 'play'


game = new Phaser.Game 640, 480, Phaser.AUTO, 'game'

game.state.add 'boot', BootScene
game.state.add 'preloader', PreloaderScene
game.state.add 'play', PlayScene

game.state.start 'boot'
