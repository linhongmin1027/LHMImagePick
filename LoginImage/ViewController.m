//
//  ViewController.m
//  LoginImage
//
//  Created by hengli on 16/10/19.
//  Copyright © 2016年 heng. All rights reserved.
//

#import "ViewController.h"
#import "LHMImagePickViewController.h"
@interface ViewController ()<LHMImagePickViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *LoginImageView;
@property(nonatomic,strong)LHMImagePickViewController*ImagePick;
@end

@implementation ViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    NSArray*nib=[[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:self options:nil];
    UIView*LGView=[nib firstObject];
    [self.view addSubview:LGView];
    self.view.backgroundColor=[UIColor whiteColor];
    _LoginImageView.layer.cornerRadius=50;
    _LoginImageView.layer.masksToBounds=YES;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLonginImage)];
    _LoginImageView.image=self.cropImage;
    if (_LoginImageView.image==nil) {
        _LoginImageView.image=[UIImage imageNamed:@"user_logo"];
    }
    _LoginImageView.userInteractionEnabled=YES;
    [_LoginImageView addGestureRecognizer:tap];
    
}
-(void)ClickLonginImage{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        [self action];
        
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self action1];
    }];
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    NSLog(@"点击了头像");
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
-(void)action{
    _ImagePick=[[LHMImagePickViewController alloc]init];
    self.ImagePick.picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    _ImagePick.delegate=self;
    
    
    [self presentViewController:self.ImagePick.picker animated:YES completion:nil];
    
}
-(void)action1{
    _ImagePick=[[LHMImagePickViewController alloc]init];
    self.ImagePick.picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.ImagePick.picker animated:YES completion:nil];
    
}
#pragma mark--UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    _LoginImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];}


@end
