ffcrm_cli
=========

A command line interface to FFCRM

Export
------
```
ffcrm export -r user -a name,password_hash,password_salt tmp/users.csv
```



Import
------
```
ffcrm import -r user -a name,password_hash,password_salt tmp/users.csv
```
