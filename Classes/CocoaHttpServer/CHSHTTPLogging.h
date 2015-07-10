/**
 * In order to provide fast and flexible logging, this project uses Cocoa Lumberjack.
 * 
 * The Google Code page has a wealth of documentation if you have any questions.
 * https://github.com/robbiehanson/CocoaLumberjack
 * 
 * Here's what you need to know concerning how logging is setup for CocoaHTTPServer:
 * 
 * There are 4 log levels:
 * - Error
 * - Warning
 * - Info
 * - Verbose
 * 
 * In addition to this, there is a Trace flag that can be enabled.
 * When tracing is enabled, it spits out the methods that are being called.
 * 
 * Please note that tracing is separate from the log levels.
 * For example, one could set the log level to warning, and enable tracing.
 * 
 * All logging is asynchronous, except errors.
 * To use logging within your own custom files, follow the steps below.
 * 
 * Step 1:
 * Import this header in your implementation file:
 * 
 * #import "HTTPLogging.h"
 * 
 * Step 2:
 * Define your logging level in your implementation file:
 * 
 * // Log levels: off, error, warn, info, verbose
 * static const int httpLogLevel = HTTP_LOG_LEVEL_VERBOSE;
 * 
 * If you wish to enable tracing, you could do something like this:
 * 
 * // Debug levels: off, error, warn, info, verbose
 * static const int httpLogLevel = HTTP_LOG_LEVEL_INFO | HTTP_LOG_FLAG_TRACE;
 * 
 * Step 3:
 * Replace your NSLog statements with HTTPLog statements according to the severity of the message.
 * 
 * NSLog(@"Fatal error, no dohickey found!"); -> HTTPLogError(@"Fatal error, no dohickey found!");
 * 
 * HTTPLog works exactly the same as NSLog.
 * This means you can pass it multiple variables just like NSLog.
**/

// Configure log levels.
#define HTTP_LOG_LEVEL_OFF     0                                              // 0...00000
#define HTTP_LOG_LEVEL_ERROR   (HTTP_LOG_LEVEL_OFF   | HTTP_LOG_FLAG_ERROR)   // 0...00001
#define HTTP_LOG_LEVEL_WARN    (HTTP_LOG_LEVEL_ERROR | HTTP_LOG_FLAG_WARN)    // 0...00011
#define HTTP_LOG_LEVEL_INFO    (HTTP_LOG_LEVEL_WARN  | HTTP_LOG_FLAG_INFO)    // 0...00111
#define HTTP_LOG_LEVEL_VERBOSE (HTTP_LOG_LEVEL_INFO  | HTTP_LOG_FLAG_VERBOSE) // 0...01111

// Setup fine grained logging.
// The first 4 bits are being used by the standard log levels (0 - 3)
// 
// We're going to add tracing, but NOT as a log level.
// Tracing can be turned on and off independently of log level.

#define HTTP_LOG_FLAG_TRACE   (1 << 4) // 0...10000

#define THIS_FILE [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]
#define THIS_METHOD [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]

// Define logging primitives.
#define HTTPLogError(frmt, ...)    if (NO) { NSLog(frmt, ##__VA_ARGS__);}

#define HTTPLogWarn(frmt, ...)     if (NO) { NSLog(frmt, ##__VA_ARGS__);}

#define HTTPLogInfo(frmt, ...)     if (NO) { NSLog(frmt, ##__VA_ARGS__);}

#define HTTPLogVerbose(frmt, ...)  if (NO) { NSLog(frmt, ##__VA_ARGS__);}

#define HTTPLogTrace()             if (NO) { }

#define HTTPLogTrace2(frmt, ...)   if (NO) { NSLog(frmt, ##__VA_ARGS__);}