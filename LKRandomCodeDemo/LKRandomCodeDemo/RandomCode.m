//
//  RandomCode.m
//  LKRandomCode
//
//  Created by Hector on 16/8/22.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "RandomCode.h"
//随机数个数
static int const intCount = 4;

@implementation RandomCode
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //设置随机背景颜色
        self.backgroundColor =[UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
        ;
    }
    return self;
}

- (void)awakeFromNib{
    self.backgroundColor =[UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    
}
//根据服务器返回的或者自己设置的codeStr绘制图形验证码
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self getAuthcode];
    
    //根据要显示的验证码字符串，根据长度，计算每个字符串显示的位置
    NSString *text = [NSString stringWithFormat:@"%@",self.codeStr];
    
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    int width = rect.size.width/text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    
    CGPoint point;
    
    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX,pY;
    for ( int i = 0; i<text.length; i++)
    {
        pX = arc4random() % width + rect.size.width/text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        ;
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:25],NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSForegroundColorAttributeName:[self randomColor]}];
    }
    
    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, 1.0);
    
    //绘制干扰线
    for (int i = 0; i < 2; i++)
    {
        CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);//设置线条填充色
        
        //设置线的起点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        //设置线终点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        //画线
        CGContextStrokePath(context);
    }
    
    //干扰点
    for(int i = 0;i < intCount*6;i++) {
        CGContextSetStrokeColorWithColor(context, [[self randomColor] CGColor]);
        pX = arc4random() % (int)self.frame.size.width;
        pY = arc4random() % (int)self.frame.size.height;
        CGContextMoveToPoint(context, pX, pY);
        CGContextAddLineToPoint(context, pX+1, pY+1);
        CGContextStrokePath(context);
        
    }
}
#pragma mark 获得随机验证码
- (void)getAuthcode
{
    self.codeStr = @"";
    self.codeStr = [[NSMutableString alloc] initWithCapacity:intCount];
    //随机从数组中选取需要个数的字符串，拼接为验证码字符串
    for (int i = 0; i < intCount; i++)
    {
        NSInteger index = arc4random() % (self.dataArray.count-1);
        NSString *tempStr = [_dataArray objectAtIndex:index];
        self.codeStr = (NSMutableString *)[self.codeStr stringByAppendingString:tempStr];
    }
}
#pragma mark 随机颜色
- (UIColor *)randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_delegate&&[_delegate respondsToSelector:@selector(didTapGraphCodeView:)]) {
        [_delegate didTapGraphCodeView:self];
    }
    //setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

@end
