SERVICE = docker-service
CONTAINER = $(SERVICE)
DESCRIPTION = A service to provide interface to the docker container <CONTAINER>

TEMPLATE = docker-service-init

OUTPUTDIR = build/
OUTPUT = $(OUTPUTDIR)$(SERVICE)

INSTALLDIR = /etc/init.d/
INSTALL = $(INSTALLDIR)$(SERVICE)

$(OUTPUT) : $(OUTPUTDIR) $(TEMPLATE)
	cp $(TEMPLATE) $(OUTPUT)
	sed -i 's/<DESCRIPTION>/$(DESCRIPTION)/' $(OUTPUT)
	sed -i 's/<SERVICE>/$(SERVICE)/' $(OUTPUT)
	sed -i 's/<CONTAINER>/$(CONTAINER)/' $(OUTPUT)

$(OUTPUTDIR) :
	mkdir -p $(OUTPUTDIR)

$(INSTALLDIR) :
	mkdir -p $(INSTALLDIR)

$(INSTALL) : $(OUTPUT) $(INSTALLDIR)
	cp $(OUTPUT) $(INSTALL)

.PHONY : generate install enable disable uninstall clean

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
