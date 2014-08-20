docker-init-script
==================

Build/generate and install an init script for your docker containers making them run as services on Debian based systems.

Basic Usage
-----------

```
git clone git@github.com:flungo/docker-init-script.git
cd docker-init-script
make enable SERVICE=service-name DESCRIPTION="A descption of your service (this is optional)"
```

The values for **SERVICE** and **DESCRIPTION** should be filled out when running the script with the appropriate details (see **Variables** below for more information).

Advanced usage
--------------

```
make <target> [<variable>=<value> ...]
```

Variables
---------

* **SERVICE** the name of the container and hence the service that will be created. *(Default: `docker-service`)*
* **DESCRIPTION** a description of the service (only used in the header of the generated init script) *(Default: "A service to provide interface to the docker container <NAME>")*
* **TEMPLATE** the location of the template to use if you wish to use an alternative template to the default one docker-service-init *(Default: `docker-service-init`)*
* **OUTPUTDIR** the location to output the files to including a trailing slash *(Default: `build/`)*

Targets
-------

* **build** - Generates the file to build/<SERVICE>
* **install** - Builds if required and installs the init script to the `/etc/init.d` directory
* **enable** - Installs if required and enables the script to automatically start the service on startup and stop it on shutdown
* **disable** - Disables the script from starting at boottime and being stopped when shutdown
* **uninstall** - Removes the init script from the `/etc/init.d` directory
* **clean** - Removed the `build` dir and all the files within it
