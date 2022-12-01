local spotify = {}
spotify.commands = {}

spotify.commands.base = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player."

spotify.commands.toggle = spotify.commands.base .. "PlayPause"
spotify.commands.stop = spotify.commands.base .. "Stop"
spotify.commands.prev = spotify.commands.base .. "Previous"
spotify.commands.next = spotify.commands.base .. "Next"

spotify.commands.cmd = "zsh -c"
spotify.commands.cmdnext = string.format("%s '%s'", spotify.commands.cmd, spotify.commands.next)
spotify.commands.cmdprev = string.format("%s '%s'", spotify.commands.cmd, spotify.commands.prev)
spotify.commands.cmdtoggle = string.format("%s '%s'", spotify.commands.cmd, spotify.commands.toggle)

return spotify
