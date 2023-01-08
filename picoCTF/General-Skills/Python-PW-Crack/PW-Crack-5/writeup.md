# PW Crack 5

## Description
Can you crack the password to get the flag?
Download the password checker here and you'll need the encrypted flag and the hash in the same directory too. Here's a dictionary with all possible passwords based on the password conventions we've seen so far.

## Solution

For this challenge I wrote a loop that goes through the given dictionary and looks at every line, then removes the first character, hashes the line and then assigns the value of the line to the user password in the case that the hashes match up.

> Note:
>
> "each_line.rstrip()" removes the first character from the right because we don't want next line character '\n' to be hashed, it would give a totally different hash.

```
user_pw = "a"

file_handler = open("dictionary.txt", "r")

for each_line in file_handler:
    each_line = each_line.rstrip()
    word_hashed=hash_pw(each_line)
    if word_hashed == correct_pw_hash:
        user_pw = each_line
```

output from the program:
````
Welcome back... your flag, user:
picoCTF{h45h_sl1ng1ng_36e992a6}
````

Flag:

picoCTF{h45h_sl1ng1ng_36e992a6}