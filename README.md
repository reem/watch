# Watch

> Simple watch function to do a command whenever certain files change.

Simply source `watch.zsh` in your `~/.zshrc` to get access to the
watch command.

## Docs

### Usage:

> `watch <CMD> <FILES>`

You can pass any command in quotes and you can pass
any number of files either as a list or through using
a glob pattern.

For instance, to watch all the C files in a directory
and `make` whenever they change, you can just:

> `watch make **/*.c`

