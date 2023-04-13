# Insp3ct0r

## Description
Kishor Balan tipped us off that the following code may need inspection: 

https://jupiter.challenges.picoctf.org/problem/41511/ (link) or 
http://jupiter.challenges.picoctf.org:41511

## Hits

1. There's 3 parts
2. How do you inspect the web code on a browser?

## Solution:

I first opened the dev tools in the browser with `ctrl + shift + c` and then went to the code where I first found the first part to the flag under the HTML:


````html
<!-- Html is neat. Anyways have 1/3 of the flag: picoCTF{tru3_d3 -->
````

The second part, was inside the CSS as expected

````css
/* You need CSS to make pretty pages. Here's part 2/3 of the flag: t3ct1ve_0r_ju5t */

````

And finally the third part is inside of the javascript file

````javascript
/* Javascript sure is neat. Anyways part 3/3 of the flag: _lucky?832b0699} */
````

And the complete flag is:

````
picoCTF{tru3_d3t3ct1ve_0r_ju5t_lucky?832b0699}
````
