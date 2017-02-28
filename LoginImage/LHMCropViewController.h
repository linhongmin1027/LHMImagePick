//
//  LHMCropViewController.h
//  LoginImage
//
//  Created by hengli on 16/10/19.
//  Copyright © 2016年 heng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LHMCropViewDelegate<NSObject>
@end
@interface LHMCropViewController : UIViewController
@property(nonatomic,strong)UIImage*SourceImage;
@property(nonatomic,strong)UIView*CropView;
@property(nonatomic,assign)BOOL isFixCropSize;
@property(nonatomic,weak)id<LHMCropViewDelegate>delegate;
@end
