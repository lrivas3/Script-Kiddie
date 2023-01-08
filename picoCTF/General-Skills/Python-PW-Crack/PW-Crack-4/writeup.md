# PW Crack 4

## Description
Can you crack the password to get the flag?
Download the password checker here and you'll need the encrypted flag and the hash in the same directory too.
There are 100 potential passwords with only 1 being correct. You can find these by examining the password checker script.

## Solution

I added code so that the program would loop through the list of posible passwords, hash it and compare it to the correct hash, then if the has was the same, it would print the correct password and make the value of the user password equal to the right password.

Finally commented the line for user input.
```
user_pw="a"

for x in list:
        x_hashed=hash_pw(x)
        if x_hashed == correct_pw_hash:
            user_pw = x
```

Output:
````
Welcome back... your flag, user:
picoCTF{fl45h_5pr1ng1ng_d770d48c}
````

Flag: 

picoCTF{fl45h_5pr1ng1ng_d770d48c}
