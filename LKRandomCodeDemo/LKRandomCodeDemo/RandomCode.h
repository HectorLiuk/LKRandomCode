//
//  RandomCode.h
//  LKRandomCode
//
//  Created by Hector on 16/8/22.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RandomCode;

@protocol RandomCodeDelegate <NSObject>

//点击图形验证码
- (void)didTapGraphCodeView:(RandomCode *)graphCodeView;

@end

@interface RandomCode : UIView
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong) NSString *codeStr;//接收外部传的code
@property (nonatomic,assign) id<RandomCodeDelegate> delegate;
@end
