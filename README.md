emicar v1.2
======

European Middleware Initiative - Compute Accounting Record V1.2

See https://twiki.cern.ch/twiki/bin/view/EMI/ComputeAccounting

EMI CAR Validation test suite

Targets:
   test			--  run samples against schema
   test_detailed	--  run detailed samples against schema
   test_aggregated	--  run aggregated samples against schema
   testclean		--  remove generated files
   clean		--  remove generated files and old backups
   release		--  create a tar.gz file from current repository

 Use make DETAILED_DIRS=<directory> to specify detailed records directory
 Use make AGGREGATED_DIRS=<directory> to specify aggregated records directory
 Record dirs can also be specified with the aggregatedDir.conf 
  and detailedDir.conf files, one dir per line 
