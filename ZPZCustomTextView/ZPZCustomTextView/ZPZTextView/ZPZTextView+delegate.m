//
//  ZPZTextView+delegate.m
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextView+delegate.h"
#import <objc/runtime.h>
#import "ZPZLabel.h"

const char * shouldBeginEdittingKey = "shouldBeginEditing";
const char * shouldEndEdittingKey = "shouldEndEditing";
const char * textViewDidBeginEdittingKey = "textViewDidBeginEditting";
const char * textViewDidEndEdittingKey = "textViewDidEndEditting";
const char * shouldChangeAndReplaceTextKey = "shouldChangeAndReplaceText";

@implementation ZPZTextView (delegate)

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    BOOL shouldBegin = YES;
    if (self.shouldBeginEditing) {
        shouldBegin = self.shouldBeginEditing(self);
    }
    if (shouldBegin) {
        [UIView animateWithDuration:0.25 animations:^{
            self.placeHoldLabel.alpha = 0;
        } completion:^(BOOL finished) {
           self.placeHoldLabel.hidden = YES;
        }];
    }
    return shouldBegin;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    BOOL shouldEnd = YES;
    if (self.shouldEndEditing) {
        shouldEnd = self.shouldEndEditing(self);
    }
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.placeHoldLabel.alpha = 1;
        } completion:^(BOOL finished) {
            self.placeHoldLabel.hidden = NO;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.placeHoldLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.placeHoldLabel.hidden = YES;
        }];
    }
    return shouldEnd;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.textViewDidBeginEditing) {
        self.textViewDidBeginEditing(self);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.textViewDidEndEditing) {
        self.textViewDidEndEditing(self);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL shouldChange = YES;
    if (self.shouldChangeAndReplaceText) {
        shouldChange = self.shouldChangeAndReplaceText(self, range, text);
    }
    return shouldChange;
}

#pragma mark - property
- (void)setShouldBeginEditing:(BOOL (^)(ZPZTextView *))shouldBeginEditing {
    objc_setAssociatedObject(self, shouldBeginEdittingKey, shouldBeginEditing, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(ZPZTextView *))shouldBeginEditing {
    return objc_getAssociatedObject(self, shouldBeginEdittingKey);
}

- (void)setShouldEndEditing:(BOOL (^)(ZPZTextView *))shouldEndEditing {
    objc_setAssociatedObject(self, shouldEndEdittingKey, shouldEndEditing, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(ZPZTextView *))shouldEndEditing {
    return objc_getAssociatedObject(self, shouldEndEdittingKey);
}

- (void)setTextViewDidBeginEditing:(void (^)(ZPZTextView *))textViewDidBeginEditing {
    objc_setAssociatedObject(self, textViewDidBeginEdittingKey, textViewDidBeginEditing, OBJC_ASSOCIATION_COPY);
}

- (void (^)(ZPZTextView *))textViewDidBeginEditing {
    return objc_getAssociatedObject(self, textViewDidBeginEdittingKey);
}

- (void)setTextViewDidEndEditing:(void (^)(ZPZTextView *))textViewDidEndEditing {
    objc_setAssociatedObject(self, textViewDidEndEdittingKey, textViewDidEndEditing, OBJC_ASSOCIATION_COPY);
}

- (void (^)(ZPZTextView *))textViewDidEndEditing {
    return objc_getAssociatedObject(self, textViewDidEndEdittingKey);
}

- (void)setShouldChangeAndReplaceText:(BOOL (^)(ZPZTextView *, NSRange, NSString *))shouldChangeAndReplaceText {
    objc_setAssociatedObject(self, shouldChangeAndReplaceTextKey, shouldChangeAndReplaceText, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(ZPZTextView *, NSRange, NSString *))shouldChangeAndReplaceText {
    return objc_getAssociatedObject(self, shouldChangeAndReplaceTextKey);
}

@end
