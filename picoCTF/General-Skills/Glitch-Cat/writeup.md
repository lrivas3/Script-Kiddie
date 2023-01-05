# Glitch Cat

> AUTHOR: LT 'SYREAL' JONES

## Description

Our flag printing service has started glitching!

````
nc saturn.picoctf.net 53933
````

For this level we connected to that server and got a "glitched" message from it.

the message was:

````
'picoCTF{gl17ch_m3_n07_' + chr(0x61) + chr(0x34) + chr(0x33) + chr(0x39) + chr(0x32) + chr(0x64) + chr(0x32) + chr(0x65) + '}'
````

This message contains base 16 ASCII characters that are inside of the chr() function that in python shows the corresponding letter in ASCII for the given number. The opposite of this is the function ord().

with that message we can now jus print() with the "glitched" string.

````
#! /usr/bin/python3

glitched='picoCTF{gl17ch_m3_n07_' + chr(0x61) + chr(0x34) + chr(0x33) + chr(0x39) + chr(0x32) + chr(0x64) + chr(0x32) + chr(0x65) + '}'

print(glitched)
````

and that way we had our flag:

````
picoCTF{gl17ch_m3_n07_a4392d2e}
````
