DETAILED_CONF=./detailedDir.conf
DETAILED_DIRS := $(shell cat $(DETAILED_CONF)) 
DETAILED_SAMPLES := $(foreach dir,$(DETAILED_DIRS),$(wildcard $(dir)/*.xml) $(wildcard $(dir)/*.xml.gz))
DETAILED_VALIDATED = $(DETAILED_SAMPLES:%=%.detailed.ok)

AGGREGATED_CONF=./aggregatedDir.conf
AGGREGATED_DIRS := $(shell cat $(AGGREGATED_CONF)) 
AGGREGATED_SAMPLES := $(foreach dir,$(AGGREGATED_DIRS),$(wildcard $(dir)/*.xml) $(wildcard $(dir)/*.xml.gz))
AGGREGATED_VALIDATED = $(AGGREGATED_SAMPLES:%=%.aggregated.ok)

VERSION = $(shell cat VERSION)
CAR_XSD_FORM = car_v1.2.xsd
CAR_XSD_AGGREGATED_FORM = car_aggregated_v1.2.xsd
release_filename = /tmp/carval-$(VERSION).tar

help:
	@echo "EMI CAR Validation test suite"
	@echo ""
	@echo "Targets:"	
	@echo "   test			--  run samples against schema"
	@echo "   test_detailed	--  run detailed samples against schema"
	@echo "   test_aggregated	--  run aggregated samples against schema"
	@echo "   testclean		--  remove generated files"
	@echo "   clean		--  remove generated files and old backups"
	@echo "   release		--  create a tar.gz file from current repository"
	@echo ""
	@echo " Use make DETAILED_DIRS=<directory> to specify detailed records directory"
	@echo " Use make AGGREGATED_DIRS=<directory> to specify aggregated records directory"
	@echo " Record dirs can also be specified with the aggregatedDir.conf \n  and detailedDir.conf files, one dir per line "

test: test_detailed test_aggregated

test_detailed: $(DETAILED_VALIDATED)

test_aggregated: $(AGGREGATED_VALIDATED)

%.detailed.ok : % $(CAR_XSD_FORM)
	@( xmllint --noout --schema $(CAR_XSD_FORM) $<  ) && touch $@

%.aggregated.ok : % $(CAR_XSD_FORM)
	@( xmllint --noout --schema $(CAR_XSD_AGGREGATED_FORM) $< ) && touch $@

detailedclean:
	rm -f $(DETAILED_VALIDATED)

aggregatedclean:
	rm -f $(AGGREGATED_VALIDATED)

distclean: clean

clean: detailedclean aggregatedclean
	rm -f *~ *.bak

release: $(release_filename:%=%.gz)
	@echo ""
	@echo " Release $(VERSION) available as $<"	@echo

$(release_filename:%=%.gz) : $(release_filename)
	gzip $<


$(release_filename): distclean
	tar -cf $@ *

