
ALL_SAMPLES := $(wildcard *.xml) $(wildcard *.xml.gz)
ALL_VALIDATED = $(ALL_SAMPLES:%=%.aggregated.ok)
VERSION = $(shell cat VERSION)
CAR_XSD_FORM = car_v1.2.xsd
CAR_XSD_AGGREGATED_FORM = car_aggregated_v1.2.xsd
release_filename = /tmp/carval-$(VERSION).tar

help:
	@echo "EMI CAR Validation test suite"
	@echo ""
	@echo "Targets:"	
	@echo "   test      --  run samples against schema"
	@echo "   testclean --  remove generated files"
	@echo "   clean     --  remove generated files and old backups"
	@echo "   release   --  create a tar.gz file from current repository"

test: $(ALL_VALIDATED)

%.aggregated.ok : % $(CAR_XSD_AGGREGATED_FORM)
	@( xmllint --noout --schema $(CAR_XSD_AGGREGATED_FORM) $< ) && touch $@ && ls *.aggregated.ok

testclean:
	rm -f $(ALL_VALIDATED)

distclean: clean

clean: testclean
	rm -f *~ *.bak

release: $(release_filename:%=%.gz)
	@echo ""
	@echo " Release $(VERSION) available as $<"	@echo

$(release_filename:%=%.gz) : $(release_filename)
	gzip $<


$(release_filename): distclean
	tar -cf $@ --transform="s,\(.*\),starval-$(VERSION)/\1," *

