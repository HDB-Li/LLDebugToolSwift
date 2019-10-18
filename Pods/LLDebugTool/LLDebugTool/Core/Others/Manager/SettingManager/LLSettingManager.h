//
//  LLSettingManager.h
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugTool)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLSettingManager : NSObject

@property (nonatomic, strong) NSNumber *doubleClickAction;

@property (nonatomic, strong) NSNumber *colorStyle;

@property (nonatomic, strong) NSNumber *entryWindowStyle;

@property (nonatomic, strong) NSNumber *statusBarStyle;

@property (nonatomic, strong) NSNumber *logStyle;

@property (nonatomic, strong) NSNumber *shrinkToEdgeWhenInactive;

@property (nonatomic, strong) NSNumber *shakeToHide;

@property (nonatomic, strong) NSNumber *magnifierZoomLevel;

@property (nonatomic, strong) NSNumber *magnifierSize;

@property (nonatomic, strong) NSNumber *showWidgetBorder;

@property (nonatomic, strong) NSNumber *hierarchyIgnorePrivateClass;

@property (nonatomic, copy) NSString *webViewClass;

@property (nonatomic, copy) NSString *lastWebViewUrl;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
