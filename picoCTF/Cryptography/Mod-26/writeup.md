# Mod 26

## Description
Cryptography can be easy, do you know what ROT13 is? 
cvpbPGS{arkg_gvzr_V'yy_gel_2_ebhaqf_bs_ebg13_MAZyqFQj}

Here we are presented with a string encoded with ROT13, so what we need to do is to rotate the characters by 13 positions. We can do this online, which is the fastest way or we can do it by using the "tr" command like this

Fisrt, if we take a look at the letters of the English alphabet they are:

ABCDEFGHIJKLMNOPQRSTUVWXYZ

And our encoded string starts with a letter "c", so we will start the rotation from there.

We echo the encoded string and then pipe it to tr

````
echo "cvpbPGS{arkg_gvzr_V'yy_gel_2_ebhaqf_bs_ebg13_MAZyqFQj}" | tr '[C-ZA-Bc-za-b]' '[P-ZA-Op-za-o]'

# output

picoCTF{next_time_I'll_try_2_rounds_of_rot13_ZNMldSDw}
````
And it gave us our flag

