This is a toolchain for an experimental parallel processor architecture 
called [Nyuzi](https://github.com/jbush001/NyuziProcessor), based on 
[LLVM](http://llvm.org/).  It includes a C/C++ compiler (clang), assembler, 
linker and partially functional debugger (lldb). 

While this project includes a C/C++ compiler, the LLVM backend can be used for 
any language.  There is a small, experimental SPMD parallel compiler in 
tools/spmd_compiler.

Questions or comments can be directed to the mailing list:
https://groups.google.com/forum/#!forum/nyuzi-processor-dev

# Getting Started

## Required Software

Instructions for installing these packages are in the following sections.

- gcc 4.8+ or Apple clang 4.2+
- cmake 2.8.12+
- python 2.7
- libxml (including headers)
- zlib (including headers)
- bison 2.7+
- flex 2.5+
- swig (http://www.swig.org/) with python wrappers
- libedit (http://thrysoee.dk/editline/)
- ncurses

## Building on Linux 

On Linux, required packages can be installed using the built-in package 
manager (apt-get, yum, etc). I've only tested this on Ubuntu, for which 
the instructions are below. You may need to tweak the package names for 
other distros (for example, on Fedora, replace python-dev with python-devel):

    sudo apt-get install libxml2-dev cmake gcc g++ python bison flex zlib1g-dev swig python-dev libedit-dev ncurses-dev

    git clone git@github.com:jbush001/NyuziToolchain.git
    cd NyuziToolchain
    mkdir build
    cd build
    cmake ..
    make
    sudo make install

## Building on MacOS

On Mavericks and later, the command line compiler can be installed like this
if you don't have it already:

    xcode-select --install
    
On earlier versions, you can download XCode from the app store.  You will
also need to install a package manager like [MacPorts](https://www.macports.org/)
to obtain the remaining dependencies. Be sure to open a new terminal to do the
build after installing MacPorts, because it installs alternate versions of some
utilities and updates the PATH. Once you have done this:

    sudo port install cmake bison swig swig-python

    git clone git@github.com:jbush001/NyuziToolchain.git
    cd NyuziToolchain
    mkdir build
    cd build
    cmake ..
    make
    sudo make install

**Note: if you upgrade 'flex' using the package manager, you will get build
errors, so I would recommend using the system supplied version.**

## Building on Windows

I have not tested this on Windows. Many of the libraries are already cross platform, 
so it should theoretically be possible.

## Other Notes

* The triple for this target is 'nyuzi-'.
* There are also bits of an autoconf based build system in this project.  It doesn't work.
* Using sudo on make install as described can leave files with root ownership in your build directory, which can then cause cryptic build errors later when building as non-root.  Doing a 'sudo chown -R &#x60;whoami&#x60; .' in the build directory will fix this.

## Invoking the Compiler

Once built, the toolchain will be installed into /usr/local/llvm-nyuzi

    /usr/local/llvm-nyuzi/bin/clang -o program.elf test_program.c 

## Running Regression Tests

Change PATH environment variable to include the binary directory (build/bin). This is only required 
for llvm-lit based tests. The test can be run as follows (assuming you are at the top of the project 
directory):

```
export PATH=<BUILDDIR>/build/bin:$PATH
llvm-lit test
llvm-lit tools/clang/test/CodeGen/nyuzi*
```

All tests should pass.

## Running Whole Program Tests

There are a set of tests in https://github.com/jbush001/NyuziProcessor/tree/master/tests/compiler
Each test case is compiled and then run in the instruction set simulator.
The output is checked for validity. This is similar to the test-suite project
in LLVM. Instructions are found in that directory.
