SERVICE = docker-service
DESCRIPTION = A service to provide interface to the docker container <NAME>

TEMPLATE = docker-service-init

OUTPUTDIR = build/
OUTPUT = $(OUTPUTDIR)$(SERVICE)

INSTALLDIR = /etc/init.d/
INSTALL = $(INSTALLDIR)$(SERVICE)

$(OUTPUT) :
	cp $(TEMPLATE) $(OUTPUT)
	sed -i 's/<DESCRIPTION>/$(DESCRIPTION)/' $(OUTPUT)
	sed -i 's/<NAME>/$(SERVICE)/' $(OUTPUT)

.PHONY : clean install disable enable uninstall

clean :
	rm -r build/

install : $(OUTPUT)
	cp $(OUTPUT) $(INSTALL)

enable : install
	update-rc.d $(SERVICE) defaults

disable :
	update-rc.d $(SERVICE) remove

uninstall : disable
	rm $(INSTALL)
	
	