#!/bin/bash
checkmodule -m -o ${1}.mod ${1}.te
semodule_package -o ${1}.pp -m ${1}.mod
sudo semodule -u ${1}.pp
rm ${1}.mod
rm ${1}.pp
