#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LLDebug.h"
#import "LLConfig.h"
#import "LLDebugTool.h"
#import "LLDebugToolMacros.h"

FOUNDATION_EXPORT double LLDebugToolVersionNumber;
FOUNDATION_EXPORT const unsigned char LLDebugToolVersionString[];

