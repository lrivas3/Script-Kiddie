# Description
Find the flag being held on this server to get ahead of the competition http://mercury.picoctf.net:21939/

the title sugests that we this has something to do with the GET http method, if we take a look at 

```
curl -I http://mercury.picoctf.net:53554/index.php
# the flag -I is to send a request that returns only the headers

#output
HTTP/1.1 200 OK
flag: picoCTF{r3j3ct_th3_du4l1ty_6ef27873}
Content-type: text/html; charset=UTF-8
```
so that's the flag:

picoCTF{r3j3ct_th3_du4l1ty_6ef27873}


