//
//  LLWindowViewController.h
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

#import <UIKit/UIKit.h>
#import "LLConfig.h"

@class LLWindow;

/**
 Root View Controller.
 */
@interface LLWindowViewController : UIViewController

/**
 SuspensionBall width.
 */
@property (nonatomic , assign) CGFloat sBallWidth;

/**
 Window style.
 */
@property (nonatomic , assign) LLConfigWindowStyle windowStyle;

/**
 Parent window.
 */
@property (nonatomic , weak) LLWindow *window;

/**
 Release current tabBarController.
 */
- (void)reloadTabbar;

/**
 Register app helper notification.
 */
- (void)registerLLAppHelperNotification;

/**
 Unregister app helper notification.
 */
- (void)unregisterLLAppHelperNotification;

/**
 Automatic open debug view controller with index.
 */
- (void)showDebugViewControllerWithIndex:(NSInteger)index;

@end
