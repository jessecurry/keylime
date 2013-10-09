//
//  KLPassthroughTableViewDelegate.m
//
// Copyright (c) 2013 jessecurry
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "KLPassthroughTableViewDelegate.h"

@implementation KLPassthroughTableViewDelegate
@synthesize passthroughDelegate=_passthroughDelegate;

+ (instancetype)delegateWithPassthroughDelegate: (id<UITableViewDelegate>)passthroughDelegate
{
  KLPassthroughTableViewDelegate* delegate = [self delegate];

  if ( delegate )
  {
    delegate.passthroughDelegate = passthroughDelegate;
  }

  return delegate;
}

// Forward to the passthrough delegate
- (BOOL)respondsToSelector: (SEL)aSelector
{
  // TODO: make sure that this works the way we want it to.
  BOOL respondsToSelector = [super respondsToSelector: aSelector];

  if ( !respondsToSelector )
    respondsToSelector = [self.passthroughDelegate respondsToSelector: aSelector];

  return respondsToSelector;
}

- (void)forwardInvocation: (NSInvocation*)invocation
{
  if ( [self.passthroughDelegate respondsToSelector: [invocation selector]] )
  {
    [invocation invokeWithTarget: self.passthroughDelegate];
  }
  else
  {
    [super forwardInvocation: invocation];
  }
}
@end
