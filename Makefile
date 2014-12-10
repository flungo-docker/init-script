export SERVICE = docker-service
export CONTAINER = $(SERVICE)
export DESCRIPTION = A service to provide interface to the docker container <CONTAINER>

export TEMPLATE = docker-service-init

export OUTPUTDIR = build/
export OUTPUT = $(OUTPUTDIR)$(SERVICE)

INSTALLDIR = /etc/init.d/
INSTALL = $(INSTALLDIR)$(SERVICE)

export  PRE_START_SCRIPT    = PRE_START
export POST_START_SCRIPT    = POST_START
export  PRE_STOP_SCRIPT     = PRE_STOP
export POST_STOP_SCRIPT     = POST_STOP
export  PRE_RESTART_SCRIPT  = PRE_RESTART
export POST_RESTART_SCRIPT  = POST_RESTART
export  PRE_PAUSE_SCRIPT    = PRE_PAUSE
export POST_PAUSE_SCRIPT    = POST_PAUSE
export  PRE_UNPAUSE_SCRIPT  = PRE_UNPAUSE
export POST_UNPAUSE_SCRIPT  = POST_UNPAUSE

$(OUTPUT) : $(OUTPUTDIR) $(TEMPLATE) subs.sh
  cp $(TEMPLATE) $@
  bash subs.sh

$(OUTPUTDIR) :
  mkdir -p $@

$(INSTALLDIR) :
  mkdir -p $@

$(INSTALL) : $(OUTPUT) $(INSTALLDIR)
  cp $(OUTPUT) $@

$(PRE_START_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(POST_START_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(PRE_STOP_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(POST_STOP_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(PRE_RESTART_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(POST_RESTART_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(PRE_PAUSE_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(POST_PAUSE_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(PRE_UNPAUSE_SCRIPT) :
  echo "# $@ CONTENT" > $@

$(POST_UNPAUSE_SCRIPT) :
  echo "# $@ CONTENT" > $@

.PHONY : START_SCRIPTS STOP_SCRIPTS RESTART_SCRIPTS PAUSE_SCRIPTS UNPAUSE_SCRIPTS

START_SCRIPTS : $(PRE_START_SCRIPT) $(POST_START_SCRIPT)

STOP_SCRIPTS : $(PRE_STOP_SCRIPT) $(POST_STOP_SCRIPT)

RESTART_SCRIPTS : $(PRE_RESTART_SCRIPT) $(POST_RESTART_SCRIPT)

PAUSE_SCRIPTS : $(PRE_PAUSE_SCRIPT) $(POST_PAUSE_SCRIPT)

UNPAUSE_SCRIPTS : $(PRE_UNPAUSE_SCRIPT) $(POST_UNPAUSE_SCRIPT)

.PHONY : scripts generate install enable disable uninstall clean

scripts : START_SCRIPTS STOP_SCRIPTS RESTART_SCRIPTS PAUSE_SCRIPTS UNPAUSE_SCRIPTS

generate : $(OUTPUT)

install : $(INSTALL)

enable : install
  update-rc.d $(SERVICE) defaults

disable : $(INSTALL)
  update-rc.d -f $(SERVICE) remove

uninstall : disable
  rm $(INSTALL)

clean :
  rm -r $(OUTPUTDIR)
