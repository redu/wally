# About
Wally is asynchronous server of news feed of [Redu](http://www.redu.com.br). It provides the infrastructure to manage the redu's
news feed, or like we used to call 'Wall'.

## REST API
Wally consists of some basics apis: wall, post and answers. In the wall API you can just get the wall with all posts and
the respective answers, trough of a ``get`` request to ``/wall/:resource_id`` route passing as paramater the 
``resource_id``.
In the post api you can: create, get and delete. Using the usefull http verbs you do all the actions. The answers api is the
same of post api where you can: create, get and delete. You can see the summary of all routes above.

Summary:
```
Wall:
GET /walls/:resource_id (get a Wall)
Post:
GET /posts/:id (get a Post)
POST /posts (create a Post)
DELETE /posts/:id (delete a Post)
Answer:
POST /answers (create an Answer)
GET /answers/:id (get an Answer)
DELETE /answers/:id (delete an Answer)
```

## Running
To run the server you just need run a [goliath](https://github.com/postrank-labs/goliath) server. ```ruby server -sv```.
You can check more options for [goliath](https://github.com/postrank-labs/goliath) in their wiki.

## Maintained and Funded
<img src="https://github.com/downloads/redu/redupy/redutech-marca.png" alt="Redu Educational Technologies" width="300">

This project is maintained and funded by [Redu Educational Techologies](http://tech.redu.com.br).

## Copyright

Copyright (c) 2012 Redu Educational Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
