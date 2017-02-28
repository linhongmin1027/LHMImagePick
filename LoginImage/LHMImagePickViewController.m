//
//  LHMImagePickViewController.m
//  LoginImage
//
//  Created by hengli on 16/10/19.
//  Copyright © 2016年 heng. All rights reserved.
//

#import "LHMImagePickViewController.h"
#import "LHMCropViewController.h"
@interface LHMImagePickViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,LHMCropViewDelegate>

@end

@implementation LHMImagePickViewController
-(instancetype)init{
    if (self=[super init]) {
        _picker=[[UIImagePickerController alloc]init];
        _picker.delegate=self;
    }
    return self;
    
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}
#pragma mark--UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    LHMCropViewController*CropViewController=[[LHMCropViewController alloc]init];
    CropViewController.SourceImage=[info objectForKey:UIImagePickerControllerOriginalImage];

    CropViewController.delegate = self;
    [picker pushViewController:CropViewController animated:YES];
    
}

@end
