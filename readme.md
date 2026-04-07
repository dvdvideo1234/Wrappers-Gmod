# Wrappers-Gmod

### Description
This contains all my [wrappers][ref-wrap] for Garry's mod. This can be added
as a [submodule][ref-subm] for every tool written. It is updated for every repo being connected.

### Why is it better
Generally, because I am lazy. This way the wrapper will get updated for every
addon that uses it. Otherwise, I have to update each addon individually.

### How is it better
1. Wire [port direction can be configured using matrixes][ref-wire-conf] instead of long senseless arrays
2. You can [override numpad using a wire port when connected][ref-wire-novr] `local w = self:WireRead("Width", true)`
3. Dedicated connection, info, configuration and other already implemented methods/routines with type check
4. Wrapping the [editable SENTs routines with no senseless tables passed down as arguments][ref-edit-pass]. Indexing is automatic

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
6. To keep all the sub-modules updated to the head changes use:
  * `$ git submodule foreach git pull origin main`
  * This will automatically pull and update all changes made
  * This will automatically update the hash in your pointer repo

### Give me some folder structure examples
|Name|Wrapper|
|-|-|
|[LaserSTool][ref-s-laser]|[laseremitter][ref-w-laser]|
|[PropCannonTool][ref-s-cannon]|[propcannon][ref-w-cannon]|
|[HoverModule][ref-s-maglev]|Maglev SENT private repo|

[![](https://img.youtube.com/vi/G_xcm1OFVV0/1.jpg)](http://www.youtube.com/watch?v=G_xcm1OFVV0 "")
[![](https://img.youtube.com/vi/G_xcm1OFVV0/2.jpg)](http://www.youtube.com/watch?v=G_xcm1OFVV0 "")
[![](https://img.youtube.com/vi/G_xcm1OFVV0/3.jpg)](http://www.youtube.com/watch?v=G_xcm1OFVV0 "")

[ref-edit-pass]: https://github.com/dvdvideo1234/LaserSTool/blob/main/lua/autorun/laserlib.lua#L1168
[ref-wire-novr]: https://github.com/dvdvideo1234/PropCannonTool/blob/master/lua/entities/gmod_propcannon/init.lua#L203
[ref-wire-conf]: https://github.com/dvdvideo1234/LaserSTool/blob/main/lua/entities/gmod_laser/init.lua#L23
[ref-subm]: https://git-scm.com/book/en/v2/Git-Tools-Submodules
[ref-wrap]: https://en.wikipedia.org/wiki/Wrapper_function
[ref-s-laser]: https://github.com/dvdvideo1234/LaserSTool/tree/main
[ref-w-laser]: https://github.com/dvdvideo1234/LaserSTool/tree/main/lua/laseremitter
[ref-s-cannon]: https://github.com/dvdvideo1234/PropCannonTool
[ref-w-cannon]: https://github.com/dvdvideo1234/PropCannonTool/tree/master/lua/propcannon
[ref-s-maglev]: https://www.youtube.com/watch?v=G_xcm1OFVV0
