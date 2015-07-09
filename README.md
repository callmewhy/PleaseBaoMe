# PleaseBaoMe

A useful tool to view SQLite file in Web browser while the app is running.

![](http://ww1.sinaimg.cn/large/61d238c7gw1etx1ugxqphj20sd0fdtd4.jpg)

## Why it's called PleaseBaoMe?

Viewing SQLite file in iOS developing is a little inconvenient. So I've wanted to make a tool to view my SQLite file for a long time. 

Thanks to [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer), it makes this idea come true. And thanks to my friend: [Mr.Bao](https://github.com/baoyongzhang), he has dawned on me to use DynamicServer to handle request.

So this project have been named after him for showing gratitude.

In Chinese, 'Bao' means 'Hug', means purity and happiness.

## Installation

There are three ways to use SDWebImage in your project:

- using Cocoapods
- copying all the files into your project

### With Cocoapods

Podfile:

    pod "PleaseBaoMe"


### Copying all the files

All needed files are in  "Classes" folder. And all dependencies are in "Vendor" folder. You can copy them into your project to import PleaseBaoMe.

## How To Use

You can see the sample code in Demo project.

### Step1: start

You can start the serve by using:

    [PBMTool start];

### Step2: setup

You have to tell me where is yor database file:

    [PBMTool setDBFilePath:writableDBPath];

### Step3: finish

Run your app, you will see the following log in console:

    You can see you SQLite in 192.168.xxx.xx:12345

Copy and paste the address to your browser's address bar and press enter key, you will see all the databse in your browser.


## Function

### Input SQL in URL

You can input your SQL query in the URI just like this:

    http://192.168.xxx.xx:12345/SELECT * from test_table

### Convenient Filter

You can set TableName、 LIMIT、 OFFSET in navigation bar easily.




# License
MIT