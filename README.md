Name
====

lua-resty-hipchat - Lua library for using the hipchat api

Table of Contents
=================

* [Name](#name)
* [Status](#status)
* [Description](#description)
* [Synopsis](#synopsis)
* [Methods](#methods)
    * [new](#new)
    * [room_message](#room_message)\
* [Limitations](#limitations)
* [Installation](#installation)
* [TODO](#todo)
* [Community](#community)
    * [English Mailing List](#english-mailing-list)
    * [Chinese Mailing List](#chinese-mailing-list)
* [Testing](#testing)
* [Bugs and Patches](#bugs-and-patches)
* [Author](#author)
* [Copyright and License](#copyright-and-license)
* [See Also](#see-also)

Status
======

This library is still under early development and considered experimental.

Description
===========

This Lua library is a hipchat utility for the ngx_lua nginx module:

Synopsis
========

```lua
    lua_package_path "/path/to/lua-resty-hipchat/lib/?.lua;;";

    server {
    
        location /test {
            content_by_lua '
                local hipchat = require "resty.hipchat"
                local hc, err = hipchat:new("token")
                
                local ok, err = hc:set_room("1234")
                
                local ok, err = hc:room_message()
            ';
        }
    
        include *.urls;
        
    }
```

[Back to TOC](#table-of-contents)

Methods
=======

All of the commands return either something that evaluates to true on success, or `nil` and an error message on failure.

new
---
`syntax: hc, err = hipchat:new("token")`

Creates a signing object. In case of failures, returns `nil` and a string describing the error.

[Back to TOC](#table-of-contents)

room_message
------------
`syntax: sig, err = hc:room_message(dtype, message, delimiter)`

`syntax: sig, err = hc:room_message("sha1", "StringToSign")`

Attempts to sign a message using the algorithm set by dtype and the key set with new(). It can also be called using a table as the message with a delimiter used when concatenating the arguments which defaults to a newline (char 10).

```
local args = {"PUT","/path/to/file/","Wed, 19 Mar 2014 21:45:06 +0000"}
local sig, err = hc:room_message("sha1", args)
```

In case of success, returns the signature. In case of errors, returns `nil` with a string describing the error.


[Back to TOC](#table-of-contents)

Limitations
===========

* 

[Back to TOC](#table-of-contents)

Installation
============

If you are using your own nginx + ngx_lua build, then you need to configure the lua_package_path directive to add the path of your lua-resty-hmac source tree to ngx_lua's LUA_PATH search path, as in

```nginx
    # nginx.conf
    http {
        lua_package_path "/path/to/lua-resty-hmac/lib/?.lua;;";
        ...
    }
```

This package also requires the lua-resty-hmac package to be installed https://github.com/jamesmarlowe/lua-resty-hmac

Ensure that the system account running your Nginx ''worker'' proceses have
enough permission to read the `.lua` file.

[Back to TOC](#table-of-contents)

TODO
====

[Back to TOC](#table-of-contents)

Community
=========

[Back to TOC](#table-of-contents)

English Mailing List
--------------------

The [openresty-en](https://groups.google.com/group/openresty-en) mailing list is for English speakers.

[Back to TOC](#table-of-contents)

Chinese Mailing List
--------------------

The [openresty](https://groups.google.com/group/openresty) mailing list is for Chinese speakers.

[Back to TOC](#table-of-contents)

Testing
=======

Running the tests in t/ is simple once you know whats happening. They use perl's prove and agentzh's test-nginx.

```
sudo apt-get install perl build-essential curl
sudo cpan Test::Nginx
mkdir -p ~/work 
cd ~/work 
git clone https://github.com/agentzh/test-nginx.git 
cd /path/to/lua-resty-hmac/
make test #assumes openresty installed to /usr/bin/openresty/
```

[Back to TOC](#table-of-contents)

Bugs and Patches
================

Please report bugs or submit patches by

1. creating a ticket on the [GitHub Issue Tracker](http://github.com/jamesmarlowe/lua-resty-hipchat/issues),

[Back to TOC](#table-of-contents)

Author
======

James Marlowe "jamesmarlowe" <jameskmarlowe@gmail.com>, Lumate LLC.

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2012-2014, by James Marlowe (jamesmarlowe) <jameskmarlowe@gmail.com>, Lumate LLC.

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

See Also
========
* the ngx_lua module: http://wiki.nginx.org/HttpLuaModule
* the [lua-resty-hmac](https://github.com/jamesmarlowe/lua-resty-hmac) library

[Back to TOC](#table-of-contents)
