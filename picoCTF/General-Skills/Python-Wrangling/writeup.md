# Python Wrangling

> AUTHOR: SYREAL

## Description

Python scripts are invoked kind of like programs in the Terminal... Can you run this Python script (on folder) using this password (on folder) to get the flag (on folder)?

**Notes:** 
- We are using python3
- We can use wget to retrieve the files needed for this challenge from picoCTF

On this challenge we will need to have installed python and pip to install a module in case we don't have it, because it requires the cryptography module

once we have everithing we need to run the script, we will run the script by passing the positional parameters it needs to run.

```
# we pass the to python the script, -d to decrypt and then the file to decrypt.
python3 ende.py -d flag.txt.en 
```
Once we've done that, it will ask for a password wich is stored in the file "pw.txt"

We paste the password and it will give us the password.

