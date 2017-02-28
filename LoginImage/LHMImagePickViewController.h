//
//  LHMImagePickViewController.h
//  LoginImage
//
//  Created by hengli on 16/10/19.
//  Copyright © 2016年 heng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LHMImagePickViewDelegate<NSObject>
@end
@interface LHMImagePickViewController : UIViewController
@property(nonatomic,weak)id<LHMImagePickViewDelegate>delegate;
@property(nonatomic,strong)UIImagePickerController*picker;

@end
