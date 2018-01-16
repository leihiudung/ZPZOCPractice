
struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

static void _I_ViewController_viewDidLoad(ViewController * self, SEL _cmd) {
    ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("ViewController"))}, sel_registerName("viewDidLoad"));
    ((void (*)(id, SEL, UIRectEdge))(void *)objc_msgSend)((id)self, sel_registerName("setEdgesForExtendedLayout:"), (UIRectEdge)UIRectEdgeNone);
    ((void (*)(id, SEL, UIColor * _Nullable))(void *)objc_msgSend)((id)((UIView *(*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("view")), sel_registerName("setBackgroundColor:"), (UIColor *)((UIColor *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("UIColor"), sel_registerName("orangeColor")));
    ((void (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("addButton"));




    ((void (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("defineGlobalNormalBlockWithLocalParams"));
}





static void _I_ViewController_getObjectIsa(ViewController * self, SEL _cmd) {
    ZPZIsaTestModel * model = ((ZPZIsaTestModel *(*)(id, SEL))(void *)objc_msgSend)((id)((ZPZIsaTestModel *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("ZPZIsaTestModel"), sel_registerName("alloc")), sel_registerName("init"));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_0,object_getClass(model));
    Class cls = ((Class (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("ZPZIsaTestModel"), sel_registerName("class"));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_1,object_getClass(cls));
}




struct __ViewController__defineNormalLocalBlock_block_impl_0 {
  struct __block_impl impl;
  struct __ViewController__defineNormalLocalBlock_block_desc_0* Desc;
  __ViewController__defineNormalLocalBlock_block_impl_0(void *fp, struct __ViewController__defineNormalLocalBlock_block_desc_0 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineNormalLocalBlock_block_func_0(struct __ViewController__defineNormalLocalBlock_block_impl_0 *__cself) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_2);
    }

static struct __ViewController__defineNormalLocalBlock_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineNormalLocalBlock_block_desc_0_DATA = { 0, sizeof(struct __ViewController__defineNormalLocalBlock_block_impl_0)};

static void _I_ViewController_defineNormalLocalBlock(ViewController * self, SEL _cmd) {
    void(*localBlock)(void) = ((void (*)())&__ViewController__defineNormalLocalBlock_block_impl_0((void *)__ViewController__defineNormalLocalBlock_block_func_0, &__ViewController__defineNormalLocalBlock_block_desc_0_DATA));
    Class cls = object_getClass((id _Nullable)localBlock);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_3,cls);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_4,class_getSuperclass(cls));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_5,object_getClass(cls));

}




struct __ViewController__defineBlockWithOutLocalParams_block_impl_0 {
  struct __block_impl impl;
  struct __ViewController__defineBlockWithOutLocalParams_block_desc_0* Desc;
  int a;
  __ViewController__defineBlockWithOutLocalParams_block_impl_0(void *fp, struct __ViewController__defineBlockWithOutLocalParams_block_desc_0 *desc, int _a, int flags=0) : a(_a) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineBlockWithOutLocalParams_block_func_0(struct __ViewController__defineBlockWithOutLocalParams_block_impl_0 *__cself) {
  int a = __cself->a; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_6,((NSNumber *(*)(Class, SEL, int))(void *)objc_msgSend)(objc_getClass("NSNumber"), sel_registerName("numberWithInt:"), (int)(a)));
    }

static struct __ViewController__defineBlockWithOutLocalParams_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineBlockWithOutLocalParams_block_desc_0_DATA = { 0, sizeof(struct __ViewController__defineBlockWithOutLocalParams_block_impl_0)};

static void _I_ViewController_defineBlockWithOutLocalParams(ViewController * self, SEL _cmd) {
                int a = 10;
    void(*localBlock)(void) = ((void (*)())&__ViewController__defineBlockWithOutLocalParams_block_impl_0((void *)__ViewController__defineBlockWithOutLocalParams_block_func_0, &__ViewController__defineBlockWithOutLocalParams_block_desc_0_DATA, a));
    Class cls = object_getClass((id _Nullable)localBlock);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_7,cls);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_8,class_getSuperclass(cls));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_9,object_getClass(cls));
}


struct __ViewController__defineGlobalNormalBlock_block_impl_0 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlock_block_desc_0* Desc;
  __ViewController__defineGlobalNormalBlock_block_impl_0(void *fp, struct __ViewController__defineGlobalNormalBlock_block_desc_0 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlock_block_func_0(struct __ViewController__defineGlobalNormalBlock_block_impl_0 *__cself) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_10);
    }

static struct __ViewController__defineGlobalNormalBlock_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlock_block_desc_0_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlock_block_impl_0)};

struct __ViewController__defineGlobalNormalBlock_block_impl_1 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlock_block_desc_1* Desc;
  __ViewController__defineGlobalNormalBlock_block_impl_1(void *fp, struct __ViewController__defineGlobalNormalBlock_block_desc_1 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlock_block_func_1(struct __ViewController__defineGlobalNormalBlock_block_impl_1 *__cself) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_11);
    }

static struct __ViewController__defineGlobalNormalBlock_block_desc_1 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlock_block_desc_1_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlock_block_impl_1)};

struct __ViewController__defineGlobalNormalBlock_block_impl_2 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlock_block_desc_2* Desc;
  __ViewController__defineGlobalNormalBlock_block_impl_2(void *fp, struct __ViewController__defineGlobalNormalBlock_block_desc_2 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlock_block_func_2(struct __ViewController__defineGlobalNormalBlock_block_impl_2 *__cself) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_12);
    }

static struct __ViewController__defineGlobalNormalBlock_block_desc_2 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlock_block_desc_2_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlock_block_impl_2)};

struct __ViewController__defineGlobalNormalBlock_block_impl_3 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlock_block_desc_3* Desc;
  __ViewController__defineGlobalNormalBlock_block_impl_3(void *fp, struct __ViewController__defineGlobalNormalBlock_block_desc_3 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlock_block_func_3(struct __ViewController__defineGlobalNormalBlock_block_impl_3 *__cself, int a) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_14);
    }

static struct __ViewController__defineGlobalNormalBlock_block_desc_3 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlock_block_desc_3_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlock_block_impl_3)};

struct __ViewController__defineGlobalNormalBlock_block_impl_4 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlock_block_desc_4* Desc;
  __ViewController__defineGlobalNormalBlock_block_impl_4(void *fp, struct __ViewController__defineGlobalNormalBlock_block_desc_4 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlock_block_func_4(struct __ViewController__defineGlobalNormalBlock_block_impl_4 *__cself, int a) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_15);
    }

static struct __ViewController__defineGlobalNormalBlock_block_desc_4 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlock_block_desc_4_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlock_block_impl_4)};

struct __ViewController__defineGlobalNormalBlock_block_impl_5 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlock_block_desc_5* Desc;
  __ViewController__defineGlobalNormalBlock_block_impl_5(void *fp, struct __ViewController__defineGlobalNormalBlock_block_desc_5 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlock_block_func_5(struct __ViewController__defineGlobalNormalBlock_block_impl_5 *__cself, int a) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_16);
    }

static struct __ViewController__defineGlobalNormalBlock_block_desc_5 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlock_block_desc_5_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlock_block_impl_5)};

static void _I_ViewController_defineGlobalNormalBlock(ViewController * self, SEL _cmd) {
    (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock)) = ((void (*)())&__ViewController__defineGlobalNormalBlock_block_impl_0((void *)__ViewController__defineGlobalNormalBlock_block_func_0, &__ViewController__defineGlobalNormalBlock_block_desc_0_DATA));
    (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock)) = ((void (*)())&__ViewController__defineGlobalNormalBlock_block_impl_1((void *)__ViewController__defineGlobalNormalBlock_block_func_1, &__ViewController__defineGlobalNormalBlock_block_desc_1_DATA));
    (*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)) = ((void (*)())&__ViewController__defineGlobalNormalBlock_block_impl_2((void *)__ViewController__defineGlobalNormalBlock_block_func_2, &__ViewController__defineGlobalNormalBlock_block_desc_2_DATA));

    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_13,object_getClass((id _Nullable)(*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock))),object_getClass((id _Nullable)(*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock))),object_getClass((id _Nullable)(*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock))));
    (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock1)) = ((void (*)(int))&__ViewController__defineGlobalNormalBlock_block_impl_3((void *)__ViewController__defineGlobalNormalBlock_block_func_3, &__ViewController__defineGlobalNormalBlock_block_desc_3_DATA));
    (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock1)) = ((void (*)(int))&__ViewController__defineGlobalNormalBlock_block_impl_4((void *)__ViewController__defineGlobalNormalBlock_block_func_4, &__ViewController__defineGlobalNormalBlock_block_desc_4_DATA));
    (*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1)) = ((void (*)(int))&__ViewController__defineGlobalNormalBlock_block_impl_5((void *)__ViewController__defineGlobalNormalBlock_block_func_5, &__ViewController__defineGlobalNormalBlock_block_desc_5_DATA));

    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_17,object_getClass((id _Nullable)(*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock1))),object_getClass((id _Nullable)(*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock1))),object_getClass((id _Nullable)(*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1))));
}


struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_0 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_0* Desc;
  int k;
  __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_0(void *fp, struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_0 *desc, int _k, int flags=0) : k(_k) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlockWithLocalParams_block_func_0(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_0 *__cself) {
  int k = __cself->k; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_18,k);
    }

static struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_0_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_0)};

struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_1 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_1* Desc;
  int k;
  __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_1(void *fp, struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_1 *desc, int _k, int flags=0) : k(_k) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlockWithLocalParams_block_func_1(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_1 *__cself) {
  int k = __cself->k; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_19,k);
    }

static struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_1 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_1_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_1)};

struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_2 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_2* Desc;
  int k;
  __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_2(void *fp, struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_2 *desc, int _k, int flags=0) : k(_k) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlockWithLocalParams_block_func_2(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_2 *__cself) {
  int k = __cself->k; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_20,k);
    }

static struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_2 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_2_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_2)};

struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_3 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_3* Desc;
  int k;
  __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_3(void *fp, struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_3 *desc, int _k, int flags=0) : k(_k) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlockWithLocalParams_block_func_3(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_3 *__cself, int a) {
  int k = __cself->k; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_23,k);
    }

static struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_3 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_3_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_3)};

struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_4 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_4* Desc;
  int k;
  __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_4(void *fp, struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_4 *desc, int _k, int flags=0) : k(_k) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlockWithLocalParams_block_func_4(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_4 *__cself, int a) {
  int k = __cself->k; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_24,k);
    }

static struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_4 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_4_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_4)};

struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_5 {
  struct __block_impl impl;
  struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_5* Desc;
  int k;
  __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_5(void *fp, struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_5 *desc, int _k, int flags=0) : k(_k) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __ViewController__defineGlobalNormalBlockWithLocalParams_block_func_5(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_5 *__cself, int a) {
  int k = __cself->k; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_25,k);
    }

static struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_5 {
  size_t reserved;
  size_t Block_size;
} __ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_5_DATA = { 0, sizeof(struct __ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_5)};

static void _I_ViewController_defineGlobalNormalBlockWithLocalParams(ViewController * self, SEL _cmd) {
                int k = 10;
    (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock)) = ((void (*)())&__ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_0((void *)__ViewController__defineGlobalNormalBlockWithLocalParams_block_func_0, &__ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_0_DATA, k));
    (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock)) = ((void (*)())&__ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_1((void *)__ViewController__defineGlobalNormalBlockWithLocalParams_block_func_1, &__ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_1_DATA, k));
    (*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)) = ((void (*)())&__ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_2((void *)__ViewController__defineGlobalNormalBlockWithLocalParams_block_func_2, &__ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_2_DATA, k));

    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_21,object_getClass((id _Nullable)(*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock))),object_getClass((id _Nullable)(*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock))),object_getClass((id _Nullable)(*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock))));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_22,&(*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)));
    (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock1)) = ((void (*)(int))&__ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_3((void *)__ViewController__defineGlobalNormalBlockWithLocalParams_block_func_3, &__ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_3_DATA, k));
    (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock1)) = ((void (*)(int))&__ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_4((void *)__ViewController__defineGlobalNormalBlockWithLocalParams_block_func_4, &__ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_4_DATA, k));
    (*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1)) = ((void (*)(int))&__ViewController__defineGlobalNormalBlockWithLocalParams_block_impl_5((void *)__ViewController__defineGlobalNormalBlockWithLocalParams_block_func_5, &__ViewController__defineGlobalNormalBlockWithLocalParams_block_desc_5_DATA, k));

    NSLog((NSString *)&__NSConstantStringImpl__var_folders_hk_zhxz0gtj7z1djqcl5mbjdpd00000gn_T_ViewController_1223ec_mi_26,object_getClass((id _Nullable)(*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock1))),object_getClass((id _Nullable)(*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock1))),object_getClass((id _Nullable)(*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1))));
}

extern "C" void * __cdecl memset(void *_Dst, int _Val, size_t _Size);
namespace {
struct __Stret0 {
	__Stret0(id receiver, SEL sel) {
	  unsigned size = sizeof(CGRect);
	  if (size == 1 || size == 2 || size == 4 || size == 8)
	    s = ((CGRect (*)(id, SEL))(void *)objc_msgSend)(receiver, sel);
	  else if (receiver == 0)
	    memset((void*)&s, 0, sizeof(s));
	  else
	    s = ((CGRect (*)(id, SEL))(void *)objc_msgSend_stret)(receiver, sel);
	}
	CGRect s;
};
};


static void _I_ViewController_addButton(ViewController * self, SEL _cmd) {
    UIButton * btn = ((UIButton *(*)(id, SEL, UIButtonType))(void *)objc_msgSend)((id)objc_getClass("UIButton"), sel_registerName("buttonWithType:"), (UIButtonType)UIButtonTypeCustom);
    ((void (*)(id, SEL, UIColor * _Nullable))(void *)objc_msgSend)((id)btn, sel_registerName("setBackgroundColor:"), (UIColor *)((UIColor *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("UIColor"), sel_registerName("greenColor")));
    ((void (*)(id, SEL, CGRect))(void *)objc_msgSend)((id)btn, sel_registerName("setFrame:"), CGRectMake(0, 0, __Stret0((id)((UIView *(*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("view")), sel_registerName("frame")).s.size.width, 50));
    ((void (*)(id, SEL, id  _Nullable __strong, SEL, UIControlEvents))(void *)objc_msgSend)((id)btn, sel_registerName("addTarget:action:forControlEvents:"), (id _Nullable)self, sel_registerName("clickedToTest"), (UIControlEvents)UIControlEventTouchUpInside);
    ((void (*)(id, SEL, UIView *__strong))(void *)objc_msgSend)((id)((UIView *(*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("view")), sel_registerName("addSubview:"), (UIView *)btn);
}


static void _I_ViewController_clickedToTest(ViewController * self, SEL _cmd) {

    if ((*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock))) {
        ((void (*)(__block_impl *))((__block_impl *)(*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)))->FuncPtr)((__block_impl *)(*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)));
    }
    if ((*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1))) {
        ((void (*)(__block_impl *, int))((__block_impl *)(*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1)))->FuncPtr)((__block_impl *)(*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1)), 10);
    }
}


static void _I_ViewController_didReceiveMemoryWarning(ViewController * self, SEL _cmd) {
    ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("ViewController"))}, sel_registerName("didReceiveMemoryWarning"));

}



static void(* _I_ViewController_strongBlock(ViewController * self, SEL _cmd) )(){ return (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock)); }
static void _I_ViewController_setStrongBlock_(ViewController * self, SEL _cmd, testBlock strongBlock) { (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock)) = strongBlock; }

static void(* _I_ViewController_copyBlock(ViewController * self, SEL _cmd) )(){ return (*(__strong testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock)); }
extern "C" __declspec(dllimport) void objc_setProperty (id, SEL, long, id, bool, bool);

static void _I_ViewController_setCopyBlock_(ViewController * self, SEL _cmd, testBlock copyBlock) { objc_setProperty (self, _cmd, __OFFSETOFIVAR__(struct ViewController, _copyBlock), (id)copyBlock, 0, 1); }

static void(* _I_ViewController_weakBlock(ViewController * self, SEL _cmd) )(){ return (*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)); }
static void _I_ViewController_setWeakBlock_(ViewController * self, SEL _cmd, testBlock weakBlock) { (*(__unsafe_unretained testBlock *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock)) = weakBlock; }

static void(* _I_ViewController_strongBlock1(ViewController * self, SEL _cmd) )(int){ return (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock1)); }
static void _I_ViewController_setStrongBlock1_(ViewController * self, SEL _cmd, testBlock1 strongBlock1) { (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_strongBlock1)) = strongBlock1; }

static void(* _I_ViewController_copyBlock1(ViewController * self, SEL _cmd) )(int){ return (*(__strong testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_copyBlock1)); }
static void _I_ViewController_setCopyBlock1_(ViewController * self, SEL _cmd, testBlock1 copyBlock1) { objc_setProperty (self, _cmd, __OFFSETOFIVAR__(struct ViewController, _copyBlock1), (id)copyBlock1, 0, 1); }

static void(* _I_ViewController_weakBlock1(ViewController * self, SEL _cmd) )(int){ return (*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1)); }
static void _I_ViewController_setWeakBlock1_(ViewController * self, SEL _cmd, testBlock1 weakBlock1) { (*(__unsafe_unretained testBlock1 *)((char *)self + OBJC_IVAR_$_ViewController$_weakBlock1)) = weakBlock1; }
// @end

struct _prop_t {
	const char *name;
	const char *attributes;
};

struct _protocol_t;

struct _objc_method {
	struct objc_selector * _cmd;
	const char *method_type;
	void  *_imp;
};

struct _protocol_t {
	void * isa;  // NULL
	const char *protocol_name;
	const struct _protocol_list_t * protocol_list; // super protocols
	const struct method_list_t *instance_methods;
	const struct method_list_t *class_methods;
	const struct method_list_t *optionalInstanceMethods;
	const struct method_list_t *optionalClassMethods;
	const struct _prop_list_t * properties;
	const unsigned int size;  // sizeof(struct _protocol_t)
	const unsigned int flags;  // = 0
	const char ** extendedMethodTypes;
};

struct _ivar_t {
	unsigned long int *offset;  // pointer to ivar offset location
	const char *name;
	const char *type;
	unsigned int alignment;
	unsigned int  size;
};

struct _class_ro_t {
	unsigned int flags;
	unsigned int instanceStart;
	unsigned int instanceSize;
	unsigned int reserved;
	const unsigned char *ivarLayout;
	const char *name;
	const struct _method_list_t *baseMethods;
	const struct _objc_protocol_list *baseProtocols;
	const struct _ivar_list_t *ivars;
	const unsigned char *weakIvarLayout;
	const struct _prop_list_t *properties;
};

struct _class_t {
	struct _class_t *isa;
	struct _class_t *superclass;
	void *cache;
	void *vtable;
	struct _class_ro_t *ro;
};

struct _category_t {
	const char *name;
	struct _class_t *cls;
	const struct _method_list_t *instance_methods;
	const struct _method_list_t *class_methods;
	const struct _protocol_list_t *protocols;
	const struct _prop_list_t *properties;
};
extern "C" __declspec(dllimport) struct objc_cache _objc_empty_cache;
#pragma warning(disable:4273)

extern "C" unsigned long int OBJC_IVAR_$_ViewController$_strongBlock __attribute__ ((used, section ("__DATA,__objc_ivar"))) = __OFFSETOFIVAR__(struct ViewController, _strongBlock);
extern "C" unsigned long int OBJC_IVAR_$_ViewController$_copyBlock __attribute__ ((used, section ("__DATA,__objc_ivar"))) = __OFFSETOFIVAR__(struct ViewController, _copyBlock);
extern "C" unsigned long int OBJC_IVAR_$_ViewController$_weakBlock __attribute__ ((used, section ("__DATA,__objc_ivar"))) = __OFFSETOFIVAR__(struct ViewController, _weakBlock);
extern "C" unsigned long int OBJC_IVAR_$_ViewController$_strongBlock1 __attribute__ ((used, section ("__DATA,__objc_ivar"))) = __OFFSETOFIVAR__(struct ViewController, _strongBlock1);
extern "C" unsigned long int OBJC_IVAR_$_ViewController$_copyBlock1 __attribute__ ((used, section ("__DATA,__objc_ivar"))) = __OFFSETOFIVAR__(struct ViewController, _copyBlock1);
extern "C" unsigned long int OBJC_IVAR_$_ViewController$_weakBlock1 __attribute__ ((used, section ("__DATA,__objc_ivar"))) = __OFFSETOFIVAR__(struct ViewController, _weakBlock1);

static struct /*_ivar_list_t*/ {
	unsigned int entsize;  // sizeof(struct _prop_t)
	unsigned int count;
	struct _ivar_t ivar_list[6];
} _OBJC_$_INSTANCE_VARIABLES_ViewController __attribute__ ((used, section ("__DATA,__objc_const"))) = {
	sizeof(_ivar_t),
	6,
	{{(unsigned long int *)&OBJC_IVAR_$_ViewController$_strongBlock, "_strongBlock", "@?", 3, 8},
	 {(unsigned long int *)&OBJC_IVAR_$_ViewController$_copyBlock, "_copyBlock", "@?", 3, 8},
	 {(unsigned long int *)&OBJC_IVAR_$_ViewController$_weakBlock, "_weakBlock", "@?", 3, 8},
	 {(unsigned long int *)&OBJC_IVAR_$_ViewController$_strongBlock1, "_strongBlock1", "@?", 3, 8},
	 {(unsigned long int *)&OBJC_IVAR_$_ViewController$_copyBlock1, "_copyBlock1", "@?", 3, 8},
	 {(unsigned long int *)&OBJC_IVAR_$_ViewController$_weakBlock1, "_weakBlock1", "@?", 3, 8}}
};

static struct /*_method_list_t*/ {
	unsigned int entsize;  // sizeof(struct _objc_method)
	unsigned int method_count;
	struct _objc_method method_list[21];
} _OBJC_$_INSTANCE_METHODS_ViewController __attribute__ ((used, section ("__DATA,__objc_const"))) = {
	sizeof(_objc_method),
	21,
	{{(struct objc_selector *)"viewDidLoad", "v16@0:8", (void *)_I_ViewController_viewDidLoad},
	{(struct objc_selector *)"getObjectIsa", "v16@0:8", (void *)_I_ViewController_getObjectIsa},
	{(struct objc_selector *)"defineNormalLocalBlock", "v16@0:8", (void *)_I_ViewController_defineNormalLocalBlock},
	{(struct objc_selector *)"defineBlockWithOutLocalParams", "v16@0:8", (void *)_I_ViewController_defineBlockWithOutLocalParams},
	{(struct objc_selector *)"defineGlobalNormalBlock", "v16@0:8", (void *)_I_ViewController_defineGlobalNormalBlock},
	{(struct objc_selector *)"defineGlobalNormalBlockWithLocalParams", "v16@0:8", (void *)_I_ViewController_defineGlobalNormalBlockWithLocalParams},
	{(struct objc_selector *)"addButton", "v16@0:8", (void *)_I_ViewController_addButton},
	{(struct objc_selector *)"clickedToTest", "v16@0:8", (void *)_I_ViewController_clickedToTest},
	{(struct objc_selector *)"didReceiveMemoryWarning", "v16@0:8", (void *)_I_ViewController_didReceiveMemoryWarning},
	{(struct objc_selector *)"strongBlock", "@?16@0:8", (void *)_I_ViewController_strongBlock},
	{(struct objc_selector *)"setStrongBlock:", "v24@0:8@?16", (void *)_I_ViewController_setStrongBlock_},
	{(struct objc_selector *)"copyBlock", "@?16@0:8", (void *)_I_ViewController_copyBlock},
	{(struct objc_selector *)"setCopyBlock:", "v24@0:8@?16", (void *)_I_ViewController_setCopyBlock_},
	{(struct objc_selector *)"weakBlock", "@?16@0:8", (void *)_I_ViewController_weakBlock},
	{(struct objc_selector *)"setWeakBlock:", "v24@0:8@?16", (void *)_I_ViewController_setWeakBlock_},
	{(struct objc_selector *)"strongBlock1", "@?16@0:8", (void *)_I_ViewController_strongBlock1},
	{(struct objc_selector *)"setStrongBlock1:", "v24@0:8@?16", (void *)_I_ViewController_setStrongBlock1_},
	{(struct objc_selector *)"copyBlock1", "@?16@0:8", (void *)_I_ViewController_copyBlock1},
	{(struct objc_selector *)"setCopyBlock1:", "v24@0:8@?16", (void *)_I_ViewController_setCopyBlock1_},
	{(struct objc_selector *)"weakBlock1", "@?16@0:8", (void *)_I_ViewController_weakBlock1},
	{(struct objc_selector *)"setWeakBlock1:", "v24@0:8@?16", (void *)_I_ViewController_setWeakBlock1_}}
};

static struct _class_ro_t _OBJC_METACLASS_RO_$_ViewController __attribute__ ((used, section ("__DATA,__objc_const"))) = {
	1, sizeof(struct _class_t), sizeof(struct _class_t), 
	(unsigned int)0, 
	0, 
	"ViewController",
	0, 
	0, 
	0, 
	0, 
	0, 
};

static struct _class_ro_t _OBJC_CLASS_RO_$_ViewController __attribute__ ((used, section ("__DATA,__objc_const"))) = {
	0, __OFFSETOFIVAR__(struct ViewController, _strongBlock), sizeof(struct ViewController_IMPL), 
	(unsigned int)0, 
	0, 
	"ViewController",
	(const struct _method_list_t *)&_OBJC_$_INSTANCE_METHODS_ViewController,
	0, 
	(const struct _ivar_list_t *)&_OBJC_$_INSTANCE_VARIABLES_ViewController,
	0, 
	0, 
};

extern "C" __declspec(dllimport) struct _class_t OBJC_METACLASS_$_UIViewController;
extern "C" __declspec(dllimport) struct _class_t OBJC_METACLASS_$_NSObject;

extern "C" __declspec(dllexport) struct _class_t OBJC_METACLASS_$_ViewController __attribute__ ((used, section ("__DATA,__objc_data"))) = {
	0, // &OBJC_METACLASS_$_NSObject,
	0, // &OBJC_METACLASS_$_UIViewController,
	0, // (void *)&_objc_empty_cache,
	0, // unused, was (void *)&_objc_empty_vtable,
	&_OBJC_METACLASS_RO_$_ViewController,
};

extern "C" __declspec(dllimport) struct _class_t OBJC_CLASS_$_UIViewController;

extern "C" __declspec(dllexport) struct _class_t OBJC_CLASS_$_ViewController __attribute__ ((used, section ("__DATA,__objc_data"))) = {
	0, // &OBJC_METACLASS_$_ViewController,
	0, // &OBJC_CLASS_$_UIViewController,
	0, // (void *)&_objc_empty_cache,
	0, // unused, was (void *)&_objc_empty_vtable,
	&_OBJC_CLASS_RO_$_ViewController,
};
static void OBJC_CLASS_SETUP_$_ViewController(void ) {
	OBJC_METACLASS_$_ViewController.isa = &OBJC_METACLASS_$_NSObject;
	OBJC_METACLASS_$_ViewController.superclass = &OBJC_METACLASS_$_UIViewController;
	OBJC_METACLASS_$_ViewController.cache = &_objc_empty_cache;
	OBJC_CLASS_$_ViewController.isa = &OBJC_METACLASS_$_ViewController;
	OBJC_CLASS_$_ViewController.superclass = &OBJC_CLASS_$_UIViewController;
	OBJC_CLASS_$_ViewController.cache = &_objc_empty_cache;
}
#pragma section(".objc_inithooks$B", long, read, write)
__declspec(allocate(".objc_inithooks$B")) static void *OBJC_CLASS_SETUP[] = {
	(void *)&OBJC_CLASS_SETUP_$_ViewController,
};
static struct _class_t *L_OBJC_LABEL_CLASS_$ [1] __attribute__((used, section ("__DATA, __objc_classlist,regular,no_dead_strip")))= {
	&OBJC_CLASS_$_ViewController,
};
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
