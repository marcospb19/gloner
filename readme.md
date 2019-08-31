# Gloner

Gloner stands for Git cLONER, but it does more

Save your time with this and go spend it on something else

Then thank me for wasting mine doing it

### Bad table of contents

1. [Installation](https://github.com/marcospb19/gloner#installation)
2. [Usage](https://github.com/marcospb19/gloner#usage)

# Installation

Clone this repository and run `make install`
```sh
git clone https://github.com/marcospb19/gloner
cd gloner/src
make install
```

# Usage

See resumed list of available commands
```sh
gloner --help
```

See detailed help for any command (Very useful)
```sh
gloner help <Command>
```

Get the remote URL from local repositories
```sh
gloner geturl # Assumes current folder
gloner geturl folder1 folder2...
```

Set the remote URL to SSH format
```sh
gloner setssh # Assumes current folder
gloner setssh folder1 folder2...
```

Set the remote URL to HTTP format
```sh
gloner sethttp # Assumes current folder
gloner sethttp folder1 folder2...
```

List all repositories from a user (use flag to see the remotes)
```sh
gloner list <User>
gloner list marcospb19
gloner list marcospb19 --http
gloner list python torvalds --ssh
```

Easy repository clone without the URL
```sh
gloner clone <User> <Repository> [Target] [--ssh|--http]
```
_Gloner will automaticaly look for ~/.ssh folder, and detect if you can use ssh_

Some flags sometimes supported (early)
```sh
[-h|--help]
[-V|--version]
[-R|--recursive]
[-v|--verbose]
[-q|--quiet]
--ssh
--http
```

The installation is so simple you should try it right now :D

I'll be glad to hear your suggestions and critiques, register an "issue" if you
find any xDDD

TODO next: clone "user" will show a list of repositories from the person in a menu
to clone like real magic
