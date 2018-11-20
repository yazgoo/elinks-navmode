# elinks-navmode

This plugin for elinks mimics pentadacty/trydactil/cvim/vimium
links navigation.

<a href="https://asciinema.org/a/N69WfAGW41rekd0K18AwjLTi6"><img src="demo.gif"></a>

# install

1. you need to install [elinks-plug](http://github.com/yazgoo/elinks-plug)
1. then you need to add to your hook file the following plugins:

```lua
plug("git@github.com:yazgoo/elinks-basis")
plug("git@github.com:yazgoo/elinks-navmode")
```

# usage

1. press f to enable navmode
2. press ctrl + R to refresh current page
3. press x to goto a link number
4. enter the link number in the dialog
5. press enter
