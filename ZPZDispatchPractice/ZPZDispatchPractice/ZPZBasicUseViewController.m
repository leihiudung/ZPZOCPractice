//
//  ZPZBasicUseViewController.m
//  ZPZDispatchPractice
//
//  Created by zhoupengzu on 2017/11/30.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZBasicUseViewController.h"

@interface ZPZBasicUseViewController ()

@end

@implementation ZPZBasicUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Basic Use";
    [self dispatchAsyncF1];
}
/**
 * 创建线程
 * 这两个参数都可以不传
 * 第一个参数主要是为了调试方便，用来标记该队列的唯一性
 * 第二个参数表明要创建一个串行队列还是并行队列，默认什么都不传，会创建一个串行队列
 */
- (void)createSerialQueue {
    dispatch_queue_t serialQueue = dispatch_queue_create(__func__, NULL);
    dispatch_async(serialQueue, ^{
        NSLog(@"createSerialQueue");
    });
}

- (void)createConcurrentQueue {
    dispatch_queue_t concurrentQueue = dispatch_queue_create(__func__, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"createConcurrentQueue1");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"createConcurrentQueue2");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"createConcurrentQueue3");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"createConcurrentQueue4");
    });
}
/**
 * dispatch_set_target_queue
 * 有什么实际的作用？（可以设置优先级，也可以修改原有的行为）
 * 该方法的实际能力是可以将不同线程都归宗到一个线程上运行（即线程号相等）
 */
- (void)dispatchSetTargetQueue1 {
    //创建三个并发并行的队列
    dispatch_queue_t currQueue1 = dispatch_queue_create("com.concurrent.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t currQueue2 = dispatch_queue_create("com.concurrent.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t currQueue3 = dispatch_queue_create("com.concurrent.queue3", DISPATCH_QUEUE_CONCURRENT);
    
    //可以发现，如果没有这里的dispatch_set_target_queue，后面的异步并发是真正意义上的异步并发（此时不在同一个线程上），如果设置了，将会顺序执行（会在同一个线程上运行）
//    dispatch_queue_t targetQueue = dispatch_queue_create("com.target.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_set_target_queue(currQueue1, targetQueue);
//    dispatch_set_target_queue(currQueue2, targetQueue);
//    dispatch_set_target_queue(currQueue3, targetQueue);
    
    dispatch_async(currQueue1, ^{
        NSLog(@"currQueue1 in");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"currQueue1 out:%@",[NSThread currentThread]);
    });
    dispatch_async(currQueue2, ^{
        NSLog(@"currQueue2 in");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"currQueue2 out:%@",[NSThread currentThread]);
    });
    dispatch_async(currQueue3, ^{
        NSLog(@"currQueue3 in");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"currQueue3 out:%@",[NSThread currentThread]);
    });
    
}

- (void)dispatchSetTargetQueue2 {
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.serial.queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.serial.queue2", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_queue_t targetQueue = dispatch_queue_create("com.target.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_set_target_queue(serialQueue1, targetQueue);
//    dispatch_set_target_queue(serialQueue2, targetQueue);
    dispatch_async(serialQueue2, ^{
        NSLog(@"target1");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(serialQueue1, ^{
        NSLog(@"target2");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(serialQueue2, ^{
        NSLog(@"target1-2");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(serialQueue2, ^{
        NSLog(@"target1-3");
        [NSThread sleepForTimeInterval:1];
    });
}
//不起作用？实际起作用了
- (void)dispatchSetTargetQueue3 {
    dispatch_queue_t serial1 = dispatch_queue_create("com.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serial2 = dispatch_queue_create("com.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serial3 = dispatch_queue_create("com.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serial4 = dispatch_queue_create("com.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serial5 = dispatch_queue_create("com.queue.serial", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_queue_t targetQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t targetQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(serial1, targetQueue);
    dispatch_set_target_queue(serial2, targetQueue);
    dispatch_set_target_queue(serial3, targetQueue);
    dispatch_set_target_queue(serial4, targetQueue);
    dispatch_set_target_queue(serial5, targetQueue);
    
    dispatch_async(serial1, ^{
        
        [NSThread sleepForTimeInterval:1];
        NSLog(@"serial1:%@",[NSThread currentThread]);
    });
    dispatch_async(serial2, ^{
       
        [NSThread sleepForTimeInterval:2];
         NSLog(@"serial2:%@",[NSThread currentThread]);
    });
    dispatch_async(serial3, ^{
       
        [NSThread sleepForTimeInterval:1];
         NSLog(@"serial3:%@",[NSThread currentThread]);
    });
    dispatch_async(serial4, ^{
        NSLog(@"serial4:%@",[NSThread currentThread]);
    });
    dispatch_async(serial5, ^{
       
        [NSThread sleepForTimeInterval:2];
         NSLog(@"serial5:%@",[NSThread currentThread]);
    });
}

void testDispatchFunction(void * context){
    int * count = context;
    printf("%d",*count);
//    NSLog(@"dispatch_async_f:%@",@(*i));
}

- (void)dispatchAsyncF1 {
    dispatch_queue_t queue = dispatch_queue_create("com.serial.queue", DISPATCH_QUEUE_SERIAL);
    int count = 10;
    dispatch_async_f(queue, &count, testDispatchFunction);
//    for (int i = 0; i < 10; i++) {
//        int count = i;
//        dispatch_async_f(queue, &count, testDispatchFunction);
//    }
}

@end
