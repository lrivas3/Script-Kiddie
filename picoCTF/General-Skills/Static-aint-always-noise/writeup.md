# Static ain't always noise

> AUTHOR: SYREAL

## Description
Can you look at the data in this [binary](https://mercury.picoctf.net/static/bc72945175d643626d6ea9a689672dbd/static): static? This [BASH script](https://mercury.picoctf.net/static/bc72945175d643626d6ea9a689672dbd/ltdis.sh) might help!

## Solution

For this challenge we had to find the strings in the executable file "static" using the bash script given to us. But I actually just used "strings" and piped it to grep so that we could find the flag
```
strings statuc | grep "pico"
# output
picoCTF{d15a5m_t34s3r_1e6a7731}
```

### Using the script

To use the script, first we need to give it the rights it needs
```
chmod +x ltdis.sh
# output 

Attempting disassembly of static ...
Disassembly successful! Available at: static.ltdis.x86_64.txt
Ripping strings from binary with file offsets...
Any strings found in static have been written to static.ltdis.strings.txt with file offset

```
We get two files from it
- the disassembly static.ltdis.x86_64.txt file, and
- the strings from the static on static.ltdis.strings.txt

with this we can now look for the flag in the static.ltdis.strings.txt file

```
grep 'picoCTF' static.ltdis.strings.txt | awk 'NF{print $NF}'
```

flag=picoCTF{d15a5m_t34s3r_1e6a7731}

