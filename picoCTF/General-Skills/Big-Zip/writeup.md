# Big Zip

## Description
Unzip this archive and find the flag.
Download zip file

To look for the word CTF I used grep like this:

````
grep -nr "CTF" big_zip_files | awk 'NF{print $NF}'
````

- -n option lists the line in wich it was found
- -r is to recursively search subdirectories listed

Finally I just cleaned out the output with awk.

Flag:

picoCTF{gr3p_15_m4g1c_ef8790dc}
