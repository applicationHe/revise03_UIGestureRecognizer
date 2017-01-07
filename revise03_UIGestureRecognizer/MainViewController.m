
//
//  MainViewController.m
//  revise03_UIGestureRecognizer
//
//  Created by 何万牡 on 17/1/6.
//  Copyright © 2017年 何万牡. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myImageView.userInteractionEnabled = YES;
    //[self tap];
   // [self pan];
    //[self pinch];
    [self Rotation];
    //UISwipeGestureRecognizer 轻扫手势
    //UILongPressGestureRecognizer 长按手势
    
    /*
     手势状态
    typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
        UIGestureRecognizerStatePossible,   // 尚未识别是何种手势操作（但可能已经触发了触摸事件），默认状态
        UIGestureRecognizerStateBegan,      // 手势已经开始，此时已经被识别，但是这个过程中可能发生变化，手势操作尚未完成
        UIGestureRecognizerStateChanged,    // 手势状态发生转变
        UIGestureRecognizerStateEnded,      // 手势识别操作完成（此时已经松开手指）
        UIGestureRecognizerStateCancelled,  // 手势被取消，恢复到默认状态
        UIGestureRecognizerStateFailed,     // 手势识别失败，恢复到默认状态
        UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // 手势识别完成，同UIGestureRecognizerStateEnded
    };
     */
     /*
    //添加触摸执行事件
    - (void)addTarget:(id)target action:(SEL)action;
    //移除触摸执行事件
    - (void)removeTarget:(id)target action:(SEL)action;
    //触摸点的个数（同时触摸的手指数）
    - (NSUInteger)numberOfTouches;
    //在指定视图中的相对位置
    - (CGPoint)locationInView:(UIView*)view;
    //触摸点相对于指定视图的位置
    - (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView*)view;
    //指定一个手势需要另一个手势执行失败才会执行,可用于解决多个手势冲突
    - (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)otherGestureRecognizer;
   */
}

#pragma mark - UIGestureRecognizer
/**
 *  点击手势
 */
-(void)tap{
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Gesture:)];
    tapGR.numberOfTapsRequired = 2;//连续敲击两次
    tapGR.numberOfTouchesRequired = 2;//取消两个手指同时点击
    tapGR.delegate = self;
    [self.myImageView addGestureRecognizer:tapGR];
}
/**
 *  拖动手势
 */
-(void)pan{
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(Gesture:)];
    [self.myImageView addGestureRecognizer:panGR];
}
/**
 *  缩放手势
 */
-(void)pinch
{
    UIPinchGestureRecognizer * pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(Gesture:)];
    [self.myImageView addGestureRecognizer:pinchGR];
    
}
/**
 *  旋转手势
 */
-(void)Rotation
{
    UIRotationGestureRecognizer * rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(Gesture:)];
    [self.myImageView addGestureRecognizer:rotationGR];
}

#pragma mark - Delegate
//一个控件识别手势后是否沿着响应者链条继续传播手势识别，默认返回NO
//用该代理方法可以实现两个不同控件的手势同时执行，需要让该方法返回YES，手势识别就能传递给不同控件
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}
#pragma mark - Event
-(void)Gesture:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"点击手势触发");
    }
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        NSLog(@"拖动手势触发");
        UIPanGestureRecognizer * panGR = sender;
        //获取移动的点大小
        CGPoint translation = [panGR translationInView:self.view];
        //重新设置图片的位置
        panGR.view.center = CGPointMake(panGR.view.center.x+translation.x, panGR.view.center.y+translation.y);
        //把手势移动点设置为零
        [panGR setTranslation:CGPointZero inView:self.view];
    }
    if ([sender isKindOfClass:[UIPinchGestureRecognizer class]]) {
        NSLog(@"缩放手势触发");
        UIPinchGestureRecognizer * pinchGR = sender;
        //重新设置图片大小
        pinchGR.view.transform = CGAffineTransformScale(pinchGR.view.transform, pinchGR.scale, pinchGR.scale);
        //把缩放倍率重新调回1
        pinchGR.scale = 1;
    }
    if ([sender isKindOfClass:[UIRotationGestureRecognizer class]]) {
        UIRotationGestureRecognizer * rotationGR = sender;
        rotationGR.view.transform = CGAffineTransformRotate(rotationGR.view.transform, rotationGR.rotation);
        rotationGR.rotation = 0;
    }
}

@end
