'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var PhaserCoffeeGenerator = module.exports = function PhaserCoffeeGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(PhaserCoffeeGenerator, yeoman.generators.Base);

PhaserCoffeeGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    name: 'appName',
    message: 'What do you want to call your game',
    default: 'Random Game'
  }, {
    name: 'githubUser',
    message: 'What is your Github user name',
    default: ''
  },{
    type: 'confirm',
    name: 'shallIncludePreloader',
    message: 'Include preloader',
    default: true
  }, {
    name: 'license',
    message: 'License',
    default: 'MIT'
  }];

  this.prompt(prompts, function (props) {
    this.appName = props.appName;
    this.githubUser = props.githubUser;
    this.shallIncludePreloader = props.shallIncludePreloader;
    this.shallUseGithubRepo = !!props.githubUser;
    this.license = props.license;
    cb();
  }.bind(this));
};

PhaserCoffeeGenerator.prototype.app = function () {
  this.mkdir('app');
  this.mkdir('app/assets/images');
  this.mkdir('app/assets/sounds');
  this.mkdir('app/coffee');

  this.copy('_package.json', 'package.json');
  this.copy('_bower.json', 'bower.json');
};

PhaserCoffeeGenerator.prototype.projectfiles = function () {
  this.copy('_README.md', 'README.md');
  this.copy('app/_index.html', 'app/index.html');

  var mainFilename = this.shallIncludePreloader ? 'main_preloader' : 'main';
  this.copy('app/coffee/' + mainFilename + '.coffee');
};
