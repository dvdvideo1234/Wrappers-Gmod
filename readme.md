# Wrappers-Gmod

### Description
This contains all my [wrappers][ref-wrap] for Garry's mod. This can be added
as a [submodule][ref-subm] for every tool written. It is updated for every repo being connected.

### Why is it better
Generally, because I am lazy. This way the wrapper will get updated for every
addon that uses it. Otherwise, I have to update each addon individually.

### Ho to use
1. In your `/lua` folder create a folder matching your addon name
  * This is done because you can make your files unique
  * I am going to call this folder `test` for the tutorial’s sake
  * You must name this folder on your own differently
2. In your addon folder name `test` add a sub-module:
  * $ `$ git submodule add git@github.com:dvdvideo1234/Wrappers-Gmod.git wrapper`
3. This will populate the wrapper folder with this project
4. Add the desired wrapper in your project like so:
  * Relative to the `/lua` folder `include("test/wrapper/wire.lua")`
5. To update the wrappers, you can update the sub-module:
  * `$ git submodule update --init --recursive`
  * This will update the hash to point to the latest revision

### Give me some folder structure examples
|Name|Wrapper|
|-|-|
|[Laser STool][ref-s-laser]|[laseremitter][ref-w-laser]|
|[PropCannonTool][ref-s-cannon]|[propcannon][ref-w-cannon]|

[ref-subm]: https://git-scm.com/book/en/v2/Git-Tools-Submodules
[ref-wrap]: https://en.wikipedia.org/wiki/Wrapper_function
[ref-s-laser]: https://github.com/dvdvideo1234/LaserSTool/tree/main
[ref-w-laser]: https://github.com/dvdvideo1234/LaserSTool/tree/main/lua/laseremitter
[ref-s-cannon]: https://github.com/dvdvideo1234/PropCannonTool
[ref-w-cannon]: https://github.com/dvdvideo1234/PropCannonTool/tree/master/lua/propcannon
