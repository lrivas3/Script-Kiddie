# Glory of the Garden

## Description
This garden contains more than it seems.
![garden](./garden.jpg)
## Solution:
Based on the description, I first used the exiftool to look for something in the metadata of the file, but I found nothing. Then I used xxd and at the end of the hexadecimal representation of the file alongside its representation in ASCII, and there it was, the flag.

````
xxd garden.jpg | tail -n 5
````

output:
````
00230550: a2bb bdac 9687 98e4 d3b2 e87f ffd9 4865  ..............He
00230560: 7265 2069 7320 6120 666c 6167 2022 7069  re is a flag "pi
00230570: 636f 4354 467b 6d6f 7265 5f74 6861 6e5f  coCTF{more_than_
00230580: 6d33 3374 735f 7468 655f 3379 3336 3537  m33ts_the_3y3657
00230590: 4261 4232 437d 220a                      BaB2C}".
````

Text cleaned:

```
Here is a flag "picoCTF{more_than_m33ts_the_3y3657BaB2C}".
```

Flag: picoCTF{more_than_m33ts_the_3y3657BaB2C}

