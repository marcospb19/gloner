# gloner

Gloner stands for Git cLONER, but it does more

Gloner is a git utility that deserves a decent readme (this is so sad)

Manage your remotes without pain, and clone repositories without the complete URL

`gloner clone <user> <repo>`

And then go spend the time you saved on something else

There'll be a functionality to clone all repositories from a user, but i'm too lazy right
now to do this... interface programming with bash is easy tho

#### Trying to do a table of contents

1. [Installation](https://github.com/marcospb19/gloner#installation)
2. [Usage](https://github.com/marcospb19/gloner#usage)

## Installation

Clone this repository and run `make install`
```bash
git clone https://github.com/marcospb19/gloner
cd gloner/src
make install
```

## Usage

This is the short output from `gloner --help`:

```
Usage: gloner <Command> [-h|--help] [-V|--version] [-v|--verbose] [-R|--recursive]


Available commands:

    Help:
        help  <Command>                      [-v|--verbose]

    Clone:
        clone  <User> [Repository] [Target]  [--ssh|--http] [-R|--recursive]

    Remote:
        geturl  <Folders>                    [-v|--verbose] [-R|--recursive]
        setssh  <Folders>                    [-v|--verbose] [-R|--recursive]
        sethttp <Folders>                    [-v|--verbose] [-R|--recursive]
```
