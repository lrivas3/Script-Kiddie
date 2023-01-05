# HashingJobApp

> AUTHOR: LT 'SYREAL' JONES

## Description

If you want to hash with the best, beat this test!
````
nc saturn.picoctf.net 63116
````

For this challenge we had to hash text in md5 and send it to the server for the challenge and after 3 times it would give us the flag.

There are some important considerations when hashing text or a file, because the minor modification to the input text or file will give a different hash.

The command we needed to use for generating the hash was md5sum. when it is not provided with a file, it will accept input.

To avoid coming up with the wrong hash for the challenge, we need to make sure that we are not sending unwanted information to the input for md5sum.

If we take a look at the hexdump of a string passed by the echo command. We can see that it has included at the end the character in base16 0x0a

`````
$ echo "Hello World" | xxd
00000000: 4865 6c6c 6f20 576f 726c 640a            Hello World.
`````
And if we see what it represents in ASCII text, it is the character '\n'

`````
$ python
Python 2.7.18 (default, Jul 14 2021, 08:11:37)
[GCC 10.2.1 20210110] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> chr(0x0a)
'\n'
>>>

`````
If we pass the argument "-n" to the echo command, it removes the character for a new line "\n" and now this is the Correct has for that string
`````
$ echo -n "Hello World" | xxd
00000000: 4865 6c6c 6f20 576f 726c 64              Hello World

`````

Passing the hashes.


```
╭╴ﴣ th3gent at  ~ took 2m23s
╰─ nc saturn.picoctf.net 63116
Please md5 hash the text between quotes, excluding the quotes: 'killer whales'
Answer:
7339bcecf2fe2c278ef6e90586669fbc
7339bcecf2fe2c278ef6e90586669fbc
Correct.
Please md5 hash the text between quotes, excluding the quotes: 'Babe Ruth'
Answer:
3875acc0c1561d949c39685e96b9a4bb
3875acc0c1561d949c39685e96b9a4bb
Correct.
Please md5 hash the text between quotes, excluding the quotes: 'a morgue'
Answer:
1c5d1684ae8cd2f62a070044e5fc40c7
1c5d1684ae8cd2f62a070044e5fc40c7
Correct.
picoCTF{4ppl1c4710n_r3c31v3d_bf2ceb02}

^C
````

Flag:

picoCTF{4ppl1c4710n_r3c31v3d_bf2ceb02}
