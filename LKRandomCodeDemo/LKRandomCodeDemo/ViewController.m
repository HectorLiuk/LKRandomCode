//
//  ViewController.m
//  LKRandomCode
//
//  Created by Hector on 16/8/22.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "ViewController.h"
#import "RandomCode.h"
@interface ViewController ()<RandomCodeDelegate>
@property (weak, nonatomic) IBOutlet RandomCode *armViewXib;
@property (nonatomic,strong) RandomCode *randomCodeView;
@end

@implementation ViewController

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    //xib创建
    self.armViewXib.delegate = self;
    
    //代码创建
    [self.view addSubview:self.randomCodeView];
    
}

//图形验证码
- (RandomCode *)randomCodeView{
    if (!_randomCodeView) {
        _randomCodeView=[[RandomCode alloc]initWithFrame:CGRectMake(30, kScreenHeight/2-20.0, 100.0, 40.0)];
        [_randomCodeView setDelegate:self];
    }
    return _randomCodeView;
}

#pragma mark - GraphCodeView delegate
- (void)didTapGraphCodeView:(RandomCode *)graphCodeView{
    NSLog(@"点击了图形验证码");
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",self.randomCodeView.codeStr);
    
}



@end
