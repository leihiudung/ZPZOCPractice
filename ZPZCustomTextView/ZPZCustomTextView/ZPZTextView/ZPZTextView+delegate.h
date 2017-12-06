//
//  ZPZTextView+delegate.h
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextView.h"

@interface ZPZTextView (delegate)<UITextViewDelegate>

@property (nonatomic, copy) BOOL (^shouldBeginEditing)(ZPZTextView *);
@property (nonatomic, copy) BOOL (^shouldEndEditing)(ZPZTextView *);
@property (nonatomic, copy) void (^textViewDidBeginEditing)(ZPZTextView *);
@property (nonatomic, copy) void (^textViewDidEndEditing)(ZPZTextView *);
@property (nonatomic, copy) BOOL (^shouldChangeAndReplaceText)(ZPZTextView *,NSRange textInRange,NSString * replaceText);

@end
