# PleaseBaoMe

A useful tool to view SQLite file in Web browser during app running procedure.

![](http://ww1.sinaimg.cn/large/61d238c7gw1etx1ugxqphj20sd0fdtd4.jpg)

## Why it's called PleaseBaoMe?

Viewing SQLite file in iOS developing brings a variety of inconvenience. Therefore, a visible and effective tool to view SQLite file is terribly￼demanded.

Thanks [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer) for making this idea come true. Thanks Tonny for fixing grammar mistakes in README.md. Thanks my friend [Mr.Bao](https://github.com/baoyongzhang), who has enlightened me to use DynamicServer to handle request.

So this project is named after him for showing gratitude.

In Chinese, 'Bao' means 'Hug', and represents purity and happiness.

## Installation

There are three ways to use PleaseBaoMe in your project:

- using Cocoapods
- copying all the files into your project

### With Cocoapods

Podfile:

    pod "PleaseBaoMe"


### Copying all the files

All needed files are in  "Classes" folder. And all dependencies are in "FMDB" folder. You can copy them into your project to import PleaseBaoMe.

## How To Use

You can see the sample code in Demo project.

### Step1: start

You can start the serve by using:

    [PBMTool start];

### Step2: setup

Then please set file path for your database file:

    [PBMTool setDBFilePath:writableDBPath];

### Step3: finish

Run your app, you will see the following log in console:

    You can see you SQLite in 192.168.xxx.xx:12345

Copy and paste the address to your browser's address bar and press enter key, you will see the entire database in your browser.


## Function

### Input SQL in URL

You can input your SQL query in the URI just like this:

    http://192.168.xxx.xx:12345/SELECT * from test_table

### Convenient Filter

You can set TableName、 LIMIT、 OFFSET in navigation bar easily.


# License
MIT