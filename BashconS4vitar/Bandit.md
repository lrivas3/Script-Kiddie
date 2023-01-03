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

El output es:
./inhere/-file00: data
./inhere/-file01: data
./inhere/-file02: data
./inhere/-file03: data
./inhere/-file04: data
./inhere/-file05: data
./inhere/-file06: data
./inhere/-file07: ASCII text
./inhere/-file08: data
./inhere/-file09: data
````

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

The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several "=" characters.

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

On this script we first declare a variable called "name_decompressed" to store the output of the console command that determines the name of the next file to be decompressed. Once the script has the name, it decompresses, but first it checks if the next file wich will result from that decompressing is againg a compressed file, if it is, the process repeats, if it isn't, then we break the loop and cat the last file.

The Script is:
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


**Password for the next level =** wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw 

## Level 13

The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don't get the next password, but you get a private SSH key that can be used to log into the next level. Note: localhost is a hostname that refers to the machine you are working on

### Solution.

In this level we are provided with a private rsa ssh key. In order to connect as the user bandit14 and read the password file for the next level we can pass that private key to a user so that he can now connect using this key as identity file without providing a password.

To connect to the server:

- The name of the private key is: sshkey.private
- The server don't allow ssh connections through port 22, only port 2220
- The parameter to use the identity_file is: [-i identity_file]

````
ssh -i sshkey.private bandit14@localhost -p 2220
````

Once we login as user bandit14 we can finally see the password for bandit 14 at /etc/bandit_pass/bandit14

**Password for the next level =** fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq

## Level 14

The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

To verify if a port is open, we can sendo something to it and see the code it shows

Explample:

````
echo "" > /dev/tcp/127.0.0.1/30000

echo $?
# output
0
````
De esta forma vemos que efectivamente el puerto está abierto y debería responder a la indicación de este nivel

Que se puede traducir a:
````
bash -c "echo '' > /dev/tcp/127.0.0.1/300 " 2>/dev/null && echo "[*] Puerto Abierto" || echo "[] Puerto cerrado"
````
Now, we can't just send the password to that port with echo, or at least I can't lol.

To send the password will have to send it using netcat.

Like this:

````
echo "fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq" | nc localhost 30000

# output
Correct!
jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt
````

Or, using Telnet
````
telnet localhost 30000

Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
# We paste the password:
fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq
# and the output is:
Correct!
jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt

Connection closed by foreign host.
````

**Password for next level =** jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt


## Level 15

The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL encryption.

Using openssl, we specify that we will act as a client and not a server with s_client

````
openssl s_client -connect 127.0.0.1:30001
````

To take into consideration in order to see encrypter traffic

once we connect, we paste the password we found in the previous level and it'll give us the password for the next level

**password for next level =** JQttfApK4SeyHwDlI9SXGR50qclOAil1

## Level 16

The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

For this we'll use nmap

````
nmap --open -T5 -v -n -p31000-32000 127.0.0.1
````
In nmap:

- we list the ports opened, 
- we use the T5 parameter which is the most aggressive mode, but we're on a controlled environment. 
- -v verbose mode
- n without DNS resolution
- p to indicate the ports range

**output:**

````
Starting Nmap 7.80 ( https://nmap.org ) at 2023-01-02 07:22 UTC
Initiating Ping Scan at 07:22
Scanning localhost (127.0.0.1) [2 ports]
Completed Ping Scan at 07:22, 0.00s elapsed (1 total hosts)
Initiating Connect Scan at 07:22
Scanning localhost (127.0.0.1) [1001 ports]
Discovered open port 31046/tcp on 127.0.0.1
Discovered open port 31691/tcp on 127.0.0.1
Discovered open port 31960/tcp on 127.0.0.1
Discovered open port 31518/tcp on 127.0.0.1
Discovered open port 31790/tcp on 127.0.0.1
Completed Connect Scan at 07:22, 0.03s elapsed (1001 total ports)
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00010s latency).
Not shown: 996 closed ports
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 0.06 seconds
````

The next step now is do connect to the port that speaks SSL, the others will simply print out the same we send them

for that, as well as in the previous level we use:

`````
openssl s_client -connect 127.0.0.1:andtheport
```````

the right port is 31790

If we send now the password for the current user, it will send a private key and then close the connection

````
JQttfApK4SeyHwDlI9SXGR50qclOAil1
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

closed
````

with this key copied, we create a directory under /tmp/ with the command:

`````
mktemp -d
`````

and go to that directory.

`````
cd !$
`````

after that we paste the key in a file named id_rsa and we use it as an identity file to connect as bandit17

`````
ssh -i id_rsa bandit17@localhost -p 2220
`````
And we get an access as bandit17. At this point we can cat out the password for the current user at /etc/bandit_pass/bandit17

**password for next level =** VwOSWtCA7lRKkTfbr2IDh6awj9RNZM5e

## Level 17

There are 2 files in the homedirectory: passwords.old and passwords.new. The password for the next level is in passwords.new and is the only line that has been changed between passwords.old and passwords.new

each file contains 100 lines with a password for each line.

To see the differences between the two files we can run diff in both of the files to see their differences

`````
diff password.old password.new

#output

42c42
< U79zsNCl1urwJ5rU6pg7ZSCi7ifWOWpT
---
> hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg
`````

**password for next level =** hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg

## Level 18

The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified .bashrc to log you out when you log in with SSH.

The bashrc has been modified to execute the command "exit 0" wich will log me out every time I log in.

The solution to this problem is thanks to a time frame in wich the commands from the .bashrc file execute.

to keep loged into the system we can modify the command for our connection to the server to spawn a shell or execute a command like this:

`````
ssh bandit18@bandit.labs.overthewire.org -p 2220 bash

# or

ssh bandit18@bandit.labs.overthewire.org -p 2220 "bash --norc"
`````

this will let us log into the system and remain there, then we just need to cat out the password in the readme file in the home directory

**password for next level =** awhqfNnAbc1naukrpqDYcF95h7HoMTrC

## Level 19

To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

The setuid allows us to run a command as another user, like the user owner bandit20

so to get the password stored in /etc/bandit_pass/bandit20 for the next level, we need to use:

````
./bandit20-do cat /etc/bandit_pass/bandit20
# output

VxCazJaVykI6W36BkBU0mJTCM8rR95XT
````

or we could even spawn a shell

````
# with bash. We use the -p parameter to attend to the suid
./bandit20-do bash -p

# with sh
./bandit20-do sh
````

**password for the next level =** VxCazJaVykI6W36BkBU0mJTCM8rR95XT


## Level 20

There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).

NOTE: Try connecting to your own network daemon to see if it works as you think

For this we connected from both sides.

First we listened on pot 5757 with:

````
nc -nlvp 5757

# output

Listening on 0.0.0.0 5757
````
Then from the other side, we execute ./suconnect 

````
./suconnect 5757
````
output from the other side of the connection

````
# output
connection received on 127.0.0.1 54526
````
Now, if we send the password for this level on this side, the other side will copare it and send the password for the next level if the password we send and the one from the current level match.

**setuid  binary side**
````
Read: VxCazJaVykI6W36BkBU0mJTCM8rR95XT
Password matches, sending next password
````

**Listening side** 
````
# password we sent:
VxCazJaVykI6W36BkBU0mJTCM8rR95XT
# password received from setuid binary side
NvEJF7oVjkddltPSrdKEFOllh9V1IBcq
````

**password for next level =** NvEJF7oVjkddltPSrdKEFOllh9V1IBcq

## Level 21

A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.



