#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#

import binascii
import sys


def main():
    with open(sys.argv[1], 'rb') as f:
        data = f.read()
    s = ''
    warning = False
    sys.stderr.write('{0}\n'.format(len(data)))
    for i in data:
        if i == 0:
            warning = True
        s += '\\x{:02x}'.format(i)
    if warning:
        sys.stderr.write(' [!] Null bytes found!\n')
    sys.stdout.write('$(python -c \'print "{0}"\')'.format(s))

if __name__ == '__main__':
    main()
