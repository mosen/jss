# jss #

A JAMF Pro API client framework, for Cocoa.

**NOTE:** Currently super broken prototype only.



## Architecture ##

### JSS Objects ###

Each object that is part of the JSS is represented as its own Swift object.
Ideally you should be able to use this framework at a lower level to parse your own objects too.

Every JSS Object inherits from `JSSResource`, this ensures that the JSS Object will implement
the __NSCoding__ protocol. In our case, we use __NSCoding__ to convert the model to an **XMLDocument**.

An **NSCoder** called `JSSXMLKeyedArchiver` is used to "visit" all the members of a data structure
and write them as elements into an XMLDocument.

### Parsing Responses ###

The parser is implemented as an `XMLParserDelegate`. It uses swifts reflection API to determine the
properties associated with tag names in the response. It can often be the case that this default
behaviour is not desirable, so there will be a method of registering delegates when certain elements
are encountered that are unknown to the reflection parser.

