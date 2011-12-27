#!/bin/bash

grep "^= " */README.rdoc | sed "s;/README.rdoc:=;::;"
