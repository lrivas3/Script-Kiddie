# Information

## Description

Files can always be changed in a secret way. Can you find the flag? cat.jpg

link to the image: https://mercury.picoctf.net/static/b4d62f6e431dc8e563309ea8c33a06b3/cat.jpg

![cat](./cat.jpg)


for this exercise we first had to take a look at the metadata of the file with:
```
exiftool cat.png

# output

ExifTool Version Number         : 12.40
File Name                       : cat.jpg
Directory                       : .
File Size                       : 858 KiB
File Modification Date/Time     : 2021:03:15 18:24:46+00:00
File Access Date/Time           : 2023:01:03 06:31:31+00:00
File Inode Change Date/Time     : 2023:01:03 06:31:26+00:00
File Permissions                : -rw-rw-r--
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg
JFIF Version                    : 1.02
Resolution Unit                 : None
X Resolution                    : 1
Y Resolution                    : 1
Current IPTC Digest             : 7a78f3d9cfb1ce42ab5a3aa30573d617
Copyright Notice                : PicoCTF
Application Record Version      : 4
XMP Toolkit                     : Image::ExifTool 10.80
License                         : cGljb0NURnt0aGVfbTN0YWRhdGFfMXNfbW9kaWZpZWR9
Rights                          : PicoCTF
Image Width                     : 2560
Image Height                    : 1598
Encoding Process                : Baseline DCT, Huffman coding
Bits Per Sample                 : 8
Color Components                : 3
Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
Image Size                      : 2560x1598
Megapixels                      : 4.1
```

If we take a look at the License, it appears to be a base64 encoded string. This has been modified for the flag

we can decode it with:

```
exiftool cat.jpg | grep "License" | awk 'NF{print $NF}' | base64 -d ; echo ''

# output

picoCTF{the_m3tadata_1s_modified}

```

flag= picoCTF{the_m3tadata_1s_modified}
