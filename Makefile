SERVICE = docker-service
CONTAINER = $(SERVICE)
DESCRIPTION = A service to provide interface to the docker container <CONTAINER>

TEMPLATE = docker-service-init

OUTPUTDIR = build/
OUTPUT = $(OUTPUTDIR)$(SERVICE)

INSTALLDIR = /etc/init.d/
INSTALL = $(INSTALLDIR)$(SERVICE)

$(OUTPUT) : $(OUTPUTDIR) 
	cp $(TEMPLATE) $(OUTPUT)
	sed -i 's/<DESCRIPTION>/$(DESCRIPTION)/' $(OUTPUT)
	sed -i 's/<SERVICE>/$(SERVICE)/' $(OUTPUT)
	sed -i 's/<CONTAINER>/$(CONTAINER)/' $(OUTPUT)

$(OUTPUTDIR) :
	mkdir -p $(OUTPUTDIR)

.PHONY : generate install disable enable uninstall clean

generate : $(OUTPUT)

install : generate
	cp $(OUTPUT) $(INSTALL)

enable : install
	update-rc.d $(SERVICE) defaults

disable :
	update-rc.d $(SERVICE) remove

uninstall : disable
	rm $(INSTALL)

clean :
	rm -r $(OUTPUTDIR)
	
	