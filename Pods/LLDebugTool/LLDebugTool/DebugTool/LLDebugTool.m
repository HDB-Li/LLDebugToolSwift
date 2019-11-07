//
//  LLDebugTool.m
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

#import "LLDebugTool.h"
#import "LLScreenshotHelper.h"
#import "LLStorageManager.h"
#import "LLNetworkHelper.h"
#import "LLCrashHelper.h"
#import "LLLogHelper.h"
#import "LLAppInfoHelper.h"
#import "LLDebugToolMacros.h"
#import "LLLogHelperEventDefine.h"
#import "LLConfig.h"
#import "LLTool.h"
#import "LLWindowManager.h"
#import "LLFunctionItemModel.h"
#import "LLSettingManager.h"
#import "UIResponder+LL_Utils.h"
#import "LLComponent.h"

static LLDebugTool *_instance = nil;

@interface LLDebugTool ()

@property (nonatomic, copy) NSString *versionNumber;

@property (nonatomic, assign) BOOL installed;

@end

@implementation LLDebugTool

/**
 * Singleton
 @return Singleton
 */
+ (instancetype)sharedTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LLDebugTool alloc] init];
        [_instance initial];
    });
    return _instance;
}

- (void)startWorking{
    if (!_isWorking) {
        _isWorking = YES;
        LLConfigAvailableFeature available = [LLConfig shared].availables;
        if (available & LLConfigAvailableCrash) {
            // Open crash helper
            [[LLCrashHelper shared] setEnable:YES];
        }
        if (available & LLConfigAvailableLog) {
            // Open log helper
            [[LLLogHelper shared] setEnable:YES];
        }
        if (available & LLConfigAvailableNetwork) {
            // Open network monitoring
            [[LLNetworkHelper shared] setEnable:YES];
        }
        if (available & LLConfigAvailableAppInfo) {
            // Open app monitoring
            [[LLAppInfoHelper shared] setEnable:YES];
        }
        if (available & LLConfigAvailableScreenshot) {
            // Open screenshot
            [[LLScreenshotHelper shared] setEnable:YES];
        }
        [self prepareToStart];
        // show window
        if (self.installed || ![LLConfig shared].hideWhenInstall) {
            self.installed = YES;
            [self showWindow];
        }
        
        [self registerNotifications];
    }
}

- (void)startWorkingWithConfigBlock:(void (^)(LLConfig *config))configBlock {
    if (configBlock) {
        configBlock([LLConfig shared]);
    }
    [self startWorking];
}

- (void)stopWorking {
    if (_isWorking) {
        _isWorking = NO;
        // Close screenshot
        [[LLScreenshotHelper shared] setEnable:NO];
        // Close app monitoring
        [[LLAppInfoHelper shared] setEnable:NO];
        // Close network monitoring
        [[LLNetworkHelper shared] setEnable:NO];
        // Close log helper
        [[LLLogHelper shared] setEnable:NO];
        // Close crash helper
        [[LLCrashHelper shared] setEnable:NO];
        // hide window
        [self hideWindow];
        
        [self unregisterNotifications];
    }
}

- (void)showWindow
{
    [[LLWindowManager shared] showEntryWindow];
}

- (void)hideWindow
{
    [[LLWindowManager shared] hideEntryWindow];
}

- (void)executeAction:(LLDebugToolAction)action {
    [self executeAction:action data:nil];
}

- (void)executeAction:(LLDebugToolAction)action data:(NSDictionary <NSString *, id>*_Nullable)data {
    LLFunctionItemModel *model = [[LLFunctionItemModel alloc] initWithAction:action];
    [model.component componentDidLoad:data];
}

- (void)logInFile:(NSString *)file function:(NSString *)function lineNo:(NSInteger)lineNo level:(LLConfigLogLevel)level onEvent:(NSString *)onEvent message:(NSString *)message {
    [[LLLogHelper shared] logInFile:file function:function lineNo:lineNo level:level onEvent:onEvent message:message];
}

#pragma mark - Notifications
- (void)didReceiveDidShakeNotification:(NSNotification *)notification {
    if ([LLConfig shared].isShakeToHide) {
        if ([LLWindowManager shared].entryWindow.isHidden) {
            [self showWindow];
        } else {
            [self hideWindow];
        }
    }
}

#pragma mark - Primary
- (void)initial {
    // Set Default
    _isBetaVersion = NO;

    _versionNumber = @"1.3.6";

    _version = _isBetaVersion ? [_versionNumber stringByAppendingString:@"(BETA)"] : _versionNumber;
    
    // Check version.
    [self checkVersion];
}

- (void)checkVersion {
    [LLTool createDirectoryAtPath:[LLConfig shared].folderPath];
    __block NSString *filePath = [[LLConfig shared].folderPath stringByAppendingPathComponent:@"LLDebugTool.plist"];
    NSMutableDictionary *localInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    if (!localInfo) {
        localInfo = [[NSMutableDictionary alloc] init];
    }
    NSString *version = localInfo[@"version"];
    // localInfo will be nil before version 1.1.2
    if (!version) {
        version = @"0.0.0";
    }
    
    if ([self.versionNumber compare:version] == NSOrderedDescending) {
        // Do update if needed.
        [self updateSomethingWithVersion:version completion:^(BOOL result) {
            if (!result) {
                NSLog(@"Failed to update old data");
            }
            [localInfo setObject:self.versionNumber forKey:@"version"];
            [localInfo writeToFile:filePath atomically:YES];
        }];
    }
    
    if (self.isBetaVersion) {
        // This method called in instancetype, can't use macros to log.
        [LLTool log:kLLLogHelperUseBetaAlert];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Check whether has a new LLDebugTool version.
        if ([LLConfig shared].autoCheckDebugToolVersion) {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://cocoapods.org/pods/LLDebugTool"]];
            NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (error == nil && data != nil) {
                    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSArray *array = [htmlString componentsSeparatedByString:@"http://cocoadocs.org/docsets/LLDebugTool/"];
                    if (array.count > 2) {
                        NSString *str = array[1];
                        NSArray *array2 = [str componentsSeparatedByString:@"/preview.png"];
                        if (array2.count >= 2) {
                            NSString *newVersion = array2[0];
                            if ([newVersion componentsSeparatedByString:@"."].count == 3) {
                                if ([self.version compare:newVersion] == NSOrderedAscending) {
                                    NSString *message = [NSString stringWithFormat:@"A new version for LLDebugTool is available, New Version : %@, Current Version : %@",newVersion,self.version];
                                    [LLTool log:message];
                                }
                            }
                        }
                    }
                }
            }];
            [dataTask resume];
        }
    });
}

- (void)updateSomethingWithVersion:(NSString *)version completion:(void (^)(BOOL result))completion {
    // Refactory database. Need rename tableName and table structure.
    if ([version compare:@"1.1.3"] == NSOrderedAscending) {
        [[LLStorageManager shared] updateDatabaseWithVersion:@"1.1.3" complete:^(BOOL result) {
            if (completion) {
                completion(result);
            }
        }];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}

- (void)prepareToStart {
    NSNumber *doubleClickAction = [LLSettingManager shared].doubleClickAction;
    if (doubleClickAction != nil) {
        [LLConfig shared].doubleClickAction = [doubleClickAction integerValue];
    }
    NSNumber *colorStyle = [LLSettingManager shared].colorStyle;
    if (colorStyle != nil) {
        [LLConfig shared].colorStyle = colorStyle.integerValue;
    }
    NSNumber *entryWindowStyle = [LLSettingManager shared].entryWindowStyle;
    if (entryWindowStyle != nil) {
        [LLConfig shared].entryWindowStyle = entryWindowStyle.integerValue;
    }
    NSNumber *statusBarStyle = [LLSettingManager shared].statusBarStyle;
    if (statusBarStyle != nil) {
        [[LLConfig shared] configStatusBarStyle:statusBarStyle.integerValue];
    }
    NSNumber *logStyle = [LLSettingManager shared].logStyle;
    if (logStyle != nil) {
        [LLConfig shared].logStyle = logStyle.integerValue;
    }
    NSNumber *shrinkToEdgeWhenInactive = [LLSettingManager shared].shrinkToEdgeWhenInactive;
    if (shrinkToEdgeWhenInactive != nil) {
        [LLConfig shared].shrinkToEdgeWhenInactive = [shrinkToEdgeWhenInactive boolValue];
    }
    NSNumber *shakeToHide = [LLSettingManager shared].shakeToHide;
    if (shakeToHide != nil) {
        [LLConfig shared].shakeToHide = [shakeToHide boolValue];
    }
    NSNumber *magnifierZoomLevel = [LLSettingManager shared].magnifierZoomLevel;
    if (magnifierZoomLevel != nil) {
        [LLConfig shared].magnifierZoomLevel = [magnifierZoomLevel integerValue];
    }
    NSNumber *magnifierSize = [LLSettingManager shared].magnifierSize;
    if (magnifierSize != nil) {
        [LLConfig shared].magnifierSize = [magnifierSize integerValue];
    }
    NSNumber *showWidgetBorder = [LLSettingManager shared].showWidgetBorder;
    if (showWidgetBorder != nil) {
        [LLConfig shared].showWidgetBorder = [showWidgetBorder boolValue];
    }
    NSNumber *hierarchyIgnorePrivateClass = [LLSettingManager shared].hierarchyIgnorePrivateClass;
    if (hierarchyIgnorePrivateClass != nil) {
        [LLConfig shared].hierarchyIgnorePrivateClass = [hierarchyIgnorePrivateClass boolValue];
    }
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDidShakeNotification:) name:kLLDidShakeNotificationName object:nil];
}

- (void)unregisterNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
