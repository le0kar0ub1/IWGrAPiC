# IWGrAPiC

Installer for the `GrAPiC` graphic library provided by Lyon 1.

The goal of this installer is to minimize the side effects and the user job while installing and using a little library like GrAPiC.

This installer is working for Linux machine only.

## Philosophy

When you want to create a project with the library `GrAPiC` juste clone this repository, install with a command and create your project inside this repository.

So, you don't have to install permanently the library.

## Dependencies

* make
* git
* SDL2 SDL2_image SDL2_ttf

## Install

`git clone https://github.com/le0kar0ub1/IWGrAPiC.git && cd IWGrAPiC && make install`

## Build

You can code your project in the provided `src` directory and put your personnal headers in the `inc` one.

then the following command to build:

`make`

and the following one to run;

`make run`

clean the build:

`make clean`

### Epilogue

Feel free to fork, use, improve.
