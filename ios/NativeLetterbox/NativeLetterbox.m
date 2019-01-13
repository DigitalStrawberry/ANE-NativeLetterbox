/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2019 Digital Strawberry LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import "FlashRuntimeExtensions.h"
#import "NativeLetterbox.h"
#import "Functions/SetHorizontalLetterboxFunc.h"
#import "Functions/SetVerticalLetterboxFunc.h"
#import "Functions/BringToFrontFunc.h"
#import <UIKit/UIKit.h>

FREContext NativeLetterboxExtContext = nil;
NativeLetterbox* NativeLetterboxSharedInstance = nil;

@implementation NativeLetterbox {
    UIView* mLetterboxLeft;
    UIView* mLetterboxRight;
    UIView* mLetterboxTop;
    UIView* mLetterboxBottom;
}

- (void) bringToFront
{
    UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    [self bringToFront:mLetterboxLeft superview:view];
    [self bringToFront:mLetterboxRight superview:view];
    [self bringToFront:mLetterboxTop superview:view];
    [self bringToFront:mLetterboxBottom superview:view];
}

- (void) setHorizontalLetterbox:(double) size color:(int) color alpha:(double) alpha
{
    if(size > 0)
    {
        UIScreen* screen = [UIScreen mainScreen];
        size /= screen.scale;
        
        UIColor* uiColor = [[self getUIColorFromHex:color] colorWithAlphaComponent:alpha];
        
        // Left letterbox
        mLetterboxLeft = [self initializeLetterbox:mLetterboxLeft color:uiColor frame:CGRectMake(0, 0, size, screen.bounds.size.height)];
        
        // Right letterbox
        mLetterboxRight = [self initializeLetterbox:mLetterboxRight color:uiColor frame:CGRectMake(screen.bounds.size.width - size, 0, size, screen.bounds.size.height)];
        
        UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        [view addSubview:mLetterboxLeft];
        [view addSubview:mLetterboxRight];
    }
    else
    {
        if(mLetterboxLeft != nil)
        {
            [mLetterboxLeft removeFromSuperview];
            mLetterboxLeft = nil;
        }
        if(mLetterboxRight != nil)
        {
            [mLetterboxRight removeFromSuperview];
            mLetterboxRight = nil;
        }
    }
}

- (void) setVerticalLetterbox:(double) size color:(int) color alpha:(double) alpha
{
    if(size > 0)
    {
        UIScreen* screen = [UIScreen mainScreen];
        size /= screen.scale;
        
        UIColor* uiColor = [[self getUIColorFromHex:color] colorWithAlphaComponent:alpha];
        
        // Top letterbox
        mLetterboxTop = [self initializeLetterbox:mLetterboxTop color:uiColor frame:CGRectMake(0, 0, screen.bounds.size.width, size)];
        
        // Bottom letterbox
        mLetterboxBottom = [self initializeLetterbox:mLetterboxBottom color:uiColor frame:CGRectMake(0, screen.bounds.size.height - size, screen.bounds.size.width, size)];
        
        UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        [view addSubview:mLetterboxTop];
        [view addSubview:mLetterboxBottom];
    }
    else
    {
        if(mLetterboxTop != nil)
        {
            [mLetterboxTop removeFromSuperview];
            mLetterboxTop = nil;
        }
        if(mLetterboxBottom != nil)
        {
            [mLetterboxBottom removeFromSuperview];
            mLetterboxBottom = nil;
        }
    }
}

- (UIView*) initializeLetterbox:(UIView*) view color:(UIColor*) color frame:(CGRect) frame
{
    UIView* letterbox = view;
    if(letterbox == nil)
    {
        letterbox = [UIView new];
    }
    letterbox.backgroundColor = color;
    letterbox.frame = frame;
    return letterbox;
}

- (void) bringToFront:(UIView*) view superview:(UIView*) superview
{
    if(view != nil)
    {
        [view removeFromSuperview];
        [superview addSubview:view];
    }
}

- (void) dispose
{
    if(mLetterboxLeft != nil)
    {
        [mLetterboxLeft removeFromSuperview];
        mLetterboxLeft = nil;
    }
    if(mLetterboxRight != nil)
    {
        [mLetterboxRight removeFromSuperview];
        mLetterboxRight = nil;
    }
    if(mLetterboxTop != nil)
    {
        [mLetterboxTop removeFromSuperview];
        mLetterboxTop = nil;
    }
    if(mLetterboxBottom != nil)
    {
        [mLetterboxBottom removeFromSuperview];
        mLetterboxBottom = nil;
    }
}

- (UIColor*) getUIColorFromHex:(NSInteger) colorHex
{
    unsigned char r, g, b, a;
    b = colorHex & 0xFF;
    g = (colorHex >> 8) & 0xFF;
    r = (colorHex >> 16) & 0xFF;
    a = (colorHex >> 24) & 0xFF;
    if(a == 0)
    {
        a = 255;
    }
    return [UIColor colorWithRed:(float) r / 255.0f green:(float) g / 255.0f blue:(float) b / 255.0f alpha:(float) a / 255.0f];
}

- (nullable UIViewController*) rootViewController
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if(delegate == nil)
    {
        return nil;
    }
    
    UIWindow* window = delegate.window;
    if(window == nil)
    {
        return nil;
    }
    
    return window.rootViewController;
}

# pragma mark - Static

+ (nonnull NativeLetterbox*) sharedInstance
{
    if(NativeLetterboxSharedInstance == nil)
    {
        NativeLetterboxSharedInstance = [[NativeLetterbox alloc] init];
    }
    return NativeLetterboxSharedInstance;
}

@end

# pragma mark - Extension

void NativeLetterboxContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet)
{
    static FRENamedFunction airNativeLetterboxExtFunctions[] =
    {
        { (const uint8_t*) "setHorizontalLetterbox", 0, nlbx_setHorizontalLetterbox },
        { (const uint8_t*) "setVerticalLetterbox", 0, nlbx_setVerticalLetterbox },
        { (const uint8_t*) "bringToFront", 0, nlbx_bringToFront }
    };
    
    *numFunctionsToSet = sizeof( airNativeLetterboxExtFunctions ) / sizeof( FRENamedFunction );
    
    *functionsToSet = airNativeLetterboxExtFunctions;
    
    NativeLetterboxExtContext = ctx;
}

void NativeLetterboxContextFinalizer(FREContext ctx)
{
    if(NativeLetterboxSharedInstance != nil)
    {
        [NativeLetterboxSharedInstance dispose];
        NativeLetterboxSharedInstance = nil;
    }
}

void NativeLetterboxInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &NativeLetterboxContextInitializer;
    *ctxFinalizerToSet = &NativeLetterboxContextFinalizer;
}

void NativeLetterboxFinalizer(void* extData) { }







