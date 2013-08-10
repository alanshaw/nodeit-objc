![nodeit logo](https://raw.github.com/alanshaw/nodeit/master/design/icon_128x128.png)
# nodeit [![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)

> Objective-C wrapper for the [nodeit](https://github.com/alanshaw/nodeit) text editor


## Container functionality notes

* Create `~/.nodeit` folder for installed plugins and themes
* Inject plugin code into WebView
* Read and expose config to editor e.g. `~/.nodeitrc` ([look in usual places for configuration](https://github.com/dominictarr/rc#standards))

### Container API

#### From nodeit to container

* Supports - whether the container supports a certain feature or not
* Close window (all tabs closed)
* Save
* Read config

#### From container to nodeit

* onOpenFile
* onConfigChange


## TODO

* Define Plugin API
* Define Theme API (just a CSS file!)