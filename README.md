docker-init-script
==================

Build/generate and install an init script for your docker containers making them run as services on Debian/Ubuntu based systems. This will quickly and easily generate a generic docker init script capable of forwarding all docker commands to the docker instance and include support for start, stop, restart so that Debian based systems will be able to safely start and shutdown the instances at the appropriate run level when enabled.

* [Basic usage](#basic-usage)
* [Advanced usage](#advanced-usage)
  * [Variables](#variables)
  * [Targets](#targets)
  * [Script Hooks](#script-hooks)
    * [Creating Hooks](#creating-hooks)
* [Tutorial](#tutorial)
* [Contributing](#contributing)

Basic Usage
-----------

```bash
git clone git@github.com:flungo/docker-init-script.git
cd docker-init-script
make enable SERVICE=service-name DESCRIPTION="A description of your service (this is optional)"
```

The values for **SERVICE** and **DESCRIPTION** should be filled out when running the script with the appropriate details (see **Variables** below for more information).

This git can also be included as a submodule within your package and call the make file as appropriate from either a bash script or another make file. This makes it easy to build a fully distributable package for your application that not only includes the Dockerfile and everything else required to build the container but that you can provide easy but customisable methods of implementing (see [tutorial](#tutorial)).

Advanced usage
--------------

To use some of the more advanced features you will probably want to further customise the parameters that make can take.

```bash
make <target> [<variable>=<value> ...]
```

The make script also allows you to provide additional code to the executed on events through the use of Script Hooks.

### Variables

* **SERVICE** the name of the container and hence the service that will be created. *(Default: `docker-service`)*
* **CONTAINER** the name of the container *(Default: The same as the value of __SERVICE__)*
* **DESCRIPTION** a description of the service (only used in the header of the generated init script) *(Default: "A service to provide interface to the docker container <NAME>")*
* **TEMPLATE** the location of the template to use if you wish to use an alternative template to the default one docker-service-init *(Default: `docker-service-init`)*
* **OUTPUTDIR** the location to output the files to including a trailing slash *(Default: `build/`)*

### Targets
-------

* **generate** - Generates the file to build/<SERVICE>
* **install** - Builds if required and installs the init script to the `/etc/init.d` directory
* **enable** - Installs if required and enables the script to automatically start the service on startup and stop it on shutdown
* **disable** - Disables the script from starting at boot time and being stopped when shutdown
* **uninstall** - Removes the init script from the `/etc/init.d` directory
* **clean** - Removed the `build` directory and all the files within it
* **scripts** - Generates dummy scripts for all hook scripts.

### Script Hooks

Hook scripts allow you to build persistent environments on the host system. Some great uses for this functionality would be when using  [pipework][https://github.com/jpetazzo/pipework] or when you might need to do some cleanup. With hook scripts you can specify a set of commands for certain events: for example, with pipework I would use a POST_START script to setup the networking. This makes your configurations for the host persistent and consistent.

Currently there are 10 script hooks available as listed below:

* **PRE_START** - Executed before the container is started.
* **POST_START** - Executed after the container is started.
* **PRE_STOP** - Executed before the container is stopped.
* **POST_STOP** - Executed after the container is stopped.
* **PRE_RESTART** - Executed before the container is restarted.
* **POST_RESTART** - Executed after the container is restarted.
* **PRE_PAUSE** - Executed before the container is paused.
* **POST_PAUSE** - Executed after the container is paused.
* **PRE_UNPAUSE** - Executed before the container is unpaused.
* **POST_UNPAUSE** - Executed after the container is unpaused.

The hooks provided are more than I could even think of uses for but if there is a hook for another command that would be useful, please suggest it in the issues section with an explanation of what you would like to achieve.

#### Creating hooks

To use a script hook, simply create a file with the respective hook name in the same directory as the Makefile and then when `make` is run, the contents of the file will be inserted into the init file template at the appropriate point. There have also been some convenience targets added to the Makefile meaning to quickly generate a stub file for a PRE_START event you can execute `make PRE_START`. As well as a target for each event, there are also some grouped targets that will create a batch of files:

* **START_SCRIPTS** - Generates both a `PRE_START` and `POST_START` script file.
* **STOP_SCRIPTS** - Generates both a `PRE_STOP` and `POST_STOP` script file.
* **RESTART_SCRIPTS** - Generates both a `PRE_RESTART` and `POST_RESTART` script file.
* **PAUSE_SCRIPTS** - Generates both a `PRE_PAUSE` and `POST_PAUSE` script file.
* **UNPAUSE_SCRIPTS** - Generates both a `PRE_UNPAUSE` and `POST_UNPAUSE` script file.
* **scripts** - Generates all hook scripts.

#### Scripting

All script files are expected to be in bash syntax as well as being fully self-contained. If you wish to use external files please not that the Makefile does not handle importing and making your dependencies available. It may be usefull to look into bash heredocs which can allow scripts of languages other than bash to be included in your script.

Additionally you can use variable tags which will be substituted at make time. See [Template Tags](#template-tags)

### Templates

In the event you need to do some really complicated changes to the generated init file or you just don't like the template provided, then this can be edited. This file is currently in the format of a bash init file but I suppose there is nothing stopping you from writing yours in perl, python or even [Brainfuck][http://en.wikipedia.org/wiki/Brainfuck] but bash was chosen as those languages require an interpreter that may not be included as standard on some minimal debian images. Most modern images use BASH so this seemed like a safe choice.

#### Template Tags

If you do write your own template then it would be good to know about the template tags used. At the moment the tags are limited to:

* **<DESCRIPTION>** - Replaced with the value of `DESCRIPTION` as defined in the make command.
* **<SERVICE>** - Replaced with the value of `SERVICE` as defined in the Makefile.
* **<CONTAINER>** - Replaced with the value of `CONTAINER` as defined in the Makefile.

The substitutions are made in the order provided so if a <DESCRIPTION> contains a <SERVICE> tag, it will be replaced.

#### Script Hooks

Script hooks are implemented by adding the contents of the script file after the line containing a match for `### BEGIN PRE_START_SCRIPT ###` (in the situation of marking where the `PRE_START` script should be inserted). For clarity of reading after generation, I have implemented the tags as shown below but the END tag is not required.

```bash
    ### BEGIN PRE_START_SCRIPT ###
    ###  END  PRE_START_SCRIPT ###
```

Tutorial
--------

A tutorial of usage will be added here showing as many features as possible with an example project (which will also be available as a separate repository.)

Contributing
------------

Found a problem? Want a feature? Submit an issue in the issue tracker and I will see if it can be done. Pull requests are welcomed if you are able to make the modifications you would like to see yourself but please try to maintain the structure and organisation of the code you write.
