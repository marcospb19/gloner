# Gloner

Gloner stands for Git cLONER, but it does more

Save your time and go spend it on something else

Then thank me for wasting mine doing this

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

See help for any command
```sh
gloner help <Command>
gloner help help
gloner help clone
gloner help list
```

Get the remote URL from local repositories
```sh
gloner geturl
gloner geturl folder1 folder2 folder3
```

Set the remote URL to SSH format
```sh
gloner setssh
gloner setssh folder1 folder2 folder3
```

Set the remote URL to HTTP format
```sh
gloner sethttp
gloner sethttp folder1 folder2 folder3
```

List all repositories from a user
```sh
gloner list <User>
gloner list marcospb19
```
_Yeah, it's true_

Clone repository without the URL
```sh
gloner clone <User> <Repository>
gloner clone <User> <Repository> <Target>
gloner clone marcospb19 gloner
gloner clone marcospb19 gloner --ssh
gloner clone marcospb19 gloner --http
```
_Gloner will automaticaly look for ~/.ssh folder, and detect if you can use ssh_

The installation is so simple you should try it right now :D

I'll be glad to hear your suggestions and critiques, register an "issue" if you
find any xDDD

TODO next: clone "user" will show a list of repositories from the person in a menu
to clone like real magic
