# BASH CHALLENGES

THESE ARE CHALLENGES FROM https://overthewire.org that S4vitar showed in a video.

## Level 0

We only had to ssh into a remote server and get the password for the next level.

```
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

**Password for next level =** NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL

## Level 1

We had to connect to the same server but with a different user (bandit1) and read from a file with the name "-"

```
ssh bandit1@bandit.labs.overthewire.org -p 2220
```

The trick here is that if we name a file like "-", when we try to cat out the content we can't because it is being interpreted as a parameter for cat.
So we need to use another method, like: 

- specifying the relative or absolute path to the file or

```
# relative
cat ./-
# absolute
cat /home/bandit1/- 

```

- using a wildcard to cat out the content of the file "-"

```
cat /home/bandit1/*
```

**Password for next level =** rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi

## Level 2

user: bandit2
password: rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi

The file for the next level password has spaces in it, its name is: "spaces in this filename"

To read from it there's many posible solutions like:

- Use the scape character "\" to make suere the shell doesn't read the blank spaces.

```
cat spaces\ in\ this\ filename
```
- Just use tab to autocomplete the filename with spaces in it

- Use a wildcard like *

- Use quotes "" to write the filename

```
cat "spaces in this filename"
```

**Password for next level =** aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG

## Level 3

User: bandit3
password: aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG

We had to find the password for the next level on a hidden file within the "inhere" folder.

hidden files begin with a ".", so that's all we're looking for

```
cat ./inhere/.hidden
```
Some solutions for are using the "find" command 

Using find to find a file with the name .hidden in my current working directory

```
find . -name .hidden
```
Using find to show using tabs:

1. the files, 
2. the absolute path to the file, 
3. the user owner of the file, 
4. the group of the file,
5. The mode or assigned permissions in octal format.

```
find . -type f -printf "%f\t%p\t%u\t%g\t%m\n" | column -t 

# We use a \n to use jump line at the end for every file
# Then we piped it to column -t for a better format of the output

# The final result should look like this:

# .hidden       ./inhere/.hidden  bandit4  bandit3  640
# .bash_logout  ./.bash_logout    root     root     644
# .profile      ./.profile        root     root     644
# .bashrc       ./.bashrc         root     root     644
```
Additionally, we can use xargs to execute a command over the output of a command executed before in a pipe

So to show the values of the hidden file we can use
```
find . -name .hidden | xargs cat
```
**password for next level =** 2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe

## Level 4

The password for the next level is stored in the only human-readable file in the inhere directory. 

to see what type of file we're dealing with, we can use the command "file" wich will give us the type of file of the file(s) we specify.

> ⚠️ **Note:** 
>
> the file command will use the _Magic numbers_ to be able to derermine the type of file, which means that even if the file analized is from a diffrent type, if it has a hexadecimal signature for a different file type, the file utility will see it as that type of file.


To solve it. we can first see the file types from the folder "inhere"
```
file ./inhere/*

#El outout es:
#./inhere/-file00: data
#./inhere/-file01: data
#./inhere/-file02: data
#./inhere/-file03: data
#./inhere/-file04: data
#./inhere/-file05: data
#./inhere/-file06: data
#./inhere/-file07: ASCII text
#./inhere/-file08: data
#./inhere/-file09: data
```
As the file -file07 is the only human-readable file, we then use:

```
cat $(find . -name -file07)
```

**Password for next level =** lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR

## Level 5

The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

1. human-readable
2. 1033 bytes in size
3. not executable

To find it we can again use the command find:

```
find . -type f -readable ! -executable -size 1033c | xargs cat | xargs

# use a c at the end of the size to indicate they're bytes
```

**Password for next level =** P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU 

## Level 6

The password for the next level is stored somewhere on the server and has all of the following properties:

1. owned by user bandit7
2. owned by group
3. 33 bytes in size

With find we can specify all those requirements

```
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null

# We search in the root folder and redirect the stderr to the /dev/null balckhole

# The output is: 

/var/lib/dpkg/info/bandit7.password
```
Now we can cat it out:

```
cat $(find / -user bandit7 -group bandit6 -size 33c 2>/dev/null)
```

**Password for next level =** z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S

## Level 7

The password for the next level is stored in the file data.txt next to the word millionth

For this we can use grep or awk

- grep
```
grep 'millionth' data.txt

# grep by word 'millionth' and then specifies the filename
```

- awk
```
awk '/millionth/' data.txt | awk 'NF{print $NF}'
 
# This filter by the last argument and can also be done like this

awk '/millionth/' data.txt | awk '{print $2}'

```
**password for next level =** TESKZC0XvTetK0S9xNwm25STk5iWrBvP


## Level 8

The password for the next level is stored in the file data.txt and is the only line of text that occurs only once.

We can "sort" the contents of data.txt and then pipe that to "uniq" with the flag -u to only print the unique lines.

```
sort | uniq -u
```

**password for next level =** EN632PlfYiZbn3PhVK3XOGSlNInNE00t

## Level 9

The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

As we have some non human-readable characters in the data.txt file, we need to extract the characters out of the file and then grep the characters we're looking for.

```
strings data.txt | grep "====" | tail -n 1 | awk 'NF{print $NF}'

# we use awk at the end to clean the output and show only the password for the next level
```
Over engineering this with a loop:

```
contador=1 strings data.txt | grep "===" | while read line; do echo "Linea $contador: $line"; let contador+=1; done | awk 'NR==4' | awk 'NF{print $NF}'
```

**password for the next level =** G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s

## Level 10

The password for the next level is stored in the file data.txt, which contains base64 encoded data.

For this we can simply use "base64" with the flag -d and then to further format the output, we pass it to "tr" which will help us to replace characters for the ones we specify to it.

```
cat data.txt | base64 -d | tr ' ' '\n'
# This way we can only show the password using awk and telling it to only show line 4.
cat data.txt | base64 -d | tr ' ' '\n' | awk 'NR==4'
```


> ⚠️ **Note:** 
>
> "tr" can help us replace specific characters but it doesn't replace whole words like "sed" would do.

**password for next level =** 6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM

## Level 11

The password for the next level is stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

To solve this and apply the rotation, we can use an online tool or use "tr"

If we cat out the rotated content from data.txt, the result is:

```
cat data.txt
# The result is
Gur cnffjbeq vf WIAOOSFzMjXXBC0KoSKBbJ8puQm5lIEi
```
We can see that the first letter in the text is "G", so we'll start from there

With tr we can replace characters for those we specify, like this:
```
cat data.txt | tr '[G-ZA-Fg-za-f]' '[T-ZA-St-za-s]' | awk 'NF{print $NF}'
```
the output from that command is: 
```
JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv
```
**Password for the next level =** JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv


## Level 12

The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work using mkdir. For example: mkdir /tmp/myname123. Then copy the datafile using cp, and rename it using mv (read the manpages!)

The hexadecimal dump of a compressed file could be turn back to normal with the use of "xxd" with the flag -r to revert the hexadecimal conversion and then be redirected to another file wich we will keep on using. Like this:

```
xxd -r data.txt > data
```

the out put is now the compressed file that has been compressed multiple times.

using "file" to see the file type using the magick numbers in the file, we see that it is a gzip compressed file.

```
> file data
data: gzip compressed data, was "data2.bin", last modified: Sat Dec  3 08:13:49 2022, max compression, from Unix, original size modulo 2^32 580
```
As the file has been compressed multiple times, we will create a bash script that will help us decompress it untill we're left with the non compressed file.

### Creating the script

For the script we need to create a loop that will do the repetitive job of decompressing this file, and we also need to know the name of the newly decompressed file

to decompress we'll use 7z

### Script Explanation 

On this script we first declare a variable called "name_decompressed" to store the output of the console command that determines the name of the next file to be decompressed.

once we 
```
#!/bin/bash

name_decompressed=$(7z l content.gzip | grep 'Name' -A 2 | tail -n 1 | awk 'NF{print $NF}')
7z x content.gzip > /dev/null 2>&1

while true; do
	7z l $name_decompressed > /dev/null 2>&1

	if [ "$(echo $?)" == "0" ]; then
		decompressed_next=$(7z l $name_decompressed | grep "Name" -A 2 | tail -n 1 | awk 'NF{print $NF}')
		7z x $name_decompressed > /dev/null 2>&1 && name_decompressed=$decompressed_next
	else
		cat $name_decompressed | awk 'NF{print $NF}' && rm data*
		exit 1
	fi
done
```


