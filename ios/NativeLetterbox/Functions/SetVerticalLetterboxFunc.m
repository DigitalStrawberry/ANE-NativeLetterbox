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

#import "SetVerticalLetterboxFunc.h"
#import "NativeLetterbox.h"

FREObject nlbx_setVerticalLetterbox( FREContext context, void* functionData, uint32_t argc, FREObject argv[] )
{
    double size = 0;
    FREGetObjectAsDouble(argv[0], &size);
    int color = 0;
    FREGetObjectAsInt32(argv[1], &color);
    double alpha = 1;
    FREGetObjectAsDouble(argv[2], &alpha);
    
    [[NativeLetterbox sharedInstance] setVerticalLetterbox:size color:color alpha:alpha];
    
    return nil;
}
