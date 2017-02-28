//
//  LHMCropViewController.m
//  LoginImage
//
//  Created by hengli on 16/10/19.
//  Copyright © 2016年 heng. All rights reserved.
//

#import "LHMCropViewController.h"
#import "ViewController.h"
#define ORIGINAL_TAG (300)
#define CROP_TAG (400)
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
//static CGPoint PreviousTapPoint = (CGPoint){SCREEN_W/2,SCREEN_H/2};
//记录图片最小的缩放大小
static  CGSize originImageViewSmallSize = (CGSize){0,0};
//记录图片最大的缩放大小
static  CGSize originImageViewBigestSize = (CGSize){0,0};

static const CGSize kCropViewDefaultSize = (CGSize){200,200};


@interface LHMCropViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *OriginalImageView;
@property(nonatomic,assign)CGPoint PreviousTapPoint;
@property(nonatomic,assign)CGPoint BeginPoint;
@end

@implementation LHMCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _PreviousTapPoint=CGPointMake(0, 0);
    self.CropView.frame=CGRectMake(self.navigationController.view.center.x-100, self.navigationController.view.center.y-100, 200, 200);
    if (self.SourceImage.size.width <= kCropViewDefaultSize.width || self.SourceImage.size.height <= kCropViewDefaultSize.height) {
        
        self.OriginalImageView.frame = CGRectMake(0, 0,kCropViewDefaultSize.width, kCropViewDefaultSize.height);
        
    }
    
    if (self.SourceImage.size.width > self.SourceImage.size.height) {
        
        
        self.OriginalImageView.frame = CGRectMake(0, 0,kCropViewDefaultSize.height *  self.SourceImage.size.width / self.SourceImage.size.height, kCropViewDefaultSize.height);
        
    }else{
        
        self.OriginalImageView.frame = CGRectMake(0, 0,kCropViewDefaultSize.width,kCropViewDefaultSize.width * self.SourceImage.size.height / self.SourceImage.size.width);
        
    }
    
    
    originImageViewSmallSize = CGSizeMake(self.OriginalImageView.frame.size.width, self.OriginalImageView.frame.size.height);
    
    originImageViewBigestSize = CGSizeMake(self.SourceImage.size.width * 2, self.SourceImage.size.height * 2);
    
self.OriginalImageView.center = self.navigationController.view.center;
    _OriginalImageView.image=_SourceImage;
    _OriginalImageView.tag=ORIGINAL_TAG;
        NSLog(@"%@",_SourceImage);
    
    _OriginalImageView.userInteractionEnabled=YES;
    [self bindGestureAction];
    [self getView:self.view withRect:CGRectMake(self.navigationController.view.center.x-100, self.navigationController.view.center.y-100, 200, 200)];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Sure:(id)sender {
    
   UIImage*loginImage= [self generateCropImage];
    ViewController*vc=[[ViewController alloc]init];
    vc.cropImage=loginImage;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    
    
}
- (UIImage *)generateCropImage {
    
    
    //    self.shadeView.hidden = YES;
    
    UIGraphicsBeginImageContext(self.navigationController.view.bounds.size); //currentView 当前的view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *originFullImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGImageRef imageRef = originFullImage.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(self.navigationController.view.center.x-100, self.navigationController.view.center.y-100, 200, 200));
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    
    return cropImage;
}


//添加滤镜
- (void)getView:(UIView *)backView withRect:(CGRect) rect
{
    
    int radius = 100;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:backView.frame cornerRadius:0];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    [path appendPath:circlePath];
    
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer  layer];
    
    fillLayer.path = path.CGPath;
    
    fillLayer.fillRule =kCAFillRuleEvenOdd;
    
    fillLayer.fillColor = [UIColor  blackColor].CGColor;
    
    fillLayer.opacity =0.5;
    
    [backView.layer  addSublayer:fillLayer];
    
}
//给图片添加手势，并限定范围
#pragma mark gesture recognizer action
- (void)bindGestureAction {
    
    UIPinchGestureRecognizer *pinchOriginGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureAction:)];
    
    UIPanGestureRecognizer *panOriginGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    
    panOriginGestureRecognizer.maximumNumberOfTouches = 1;
    
    
    pinchOriginGestureRecognizer.delegate = panOriginGestureRecognizer.delegate =  self;
    
    [self.OriginalImageView addGestureRecognizer:pinchOriginGestureRecognizer];
    [self.OriginalImageView addGestureRecognizer:panOriginGestureRecognizer];
    
    panOriginGestureRecognizer.maximumNumberOfTouches = 1;
    
}

- (void)pinchGestureAction:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    UIView *gestureView = gestureRecognizer.view;
    CGAffineTransform affineTransform = CGAffineTransformScale(gestureView.transform,gestureRecognizer.scale, gestureRecognizer.scale);
    
    gestureView.transform = affineTransform;
    
    gestureRecognizer.scale = 1;

    
    
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gestureRecognizer {
    
    UIView *gestureView = gestureRecognizer.view;
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureView.superview];
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
        _BeginPoint=CGPointMake(touchPoint.x-gestureView.center.x, touchPoint.y-gestureView.center.y);
    }
   
  CGPoint centerPoint = CGPointMake(touchPoint.x-_BeginPoint.x,touchPoint.y-_BeginPoint.y);
        gestureView.center=centerPoint;
}


@end
