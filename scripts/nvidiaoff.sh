#!/bin/bash
rmmod nvidia
tee /proc/acpi/bbswitch <<<OFF
