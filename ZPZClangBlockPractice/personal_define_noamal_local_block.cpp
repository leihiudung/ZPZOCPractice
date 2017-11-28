//
//  personal_define_noamal_local_block.cpp
//  ZPZClangBlockPractice
//
//  Created by zhoupengzu on 2017/11/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#include <stdio.h>

struct __rw_objc_super { 
    struct objc_object *object; 
    struct objc_object *superClass; 
    __rw_objc_super(struct objc_object *o, struct objc_object *s) : object(o), superClass(s) {} 
};
