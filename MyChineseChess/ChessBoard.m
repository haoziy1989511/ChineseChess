//
//  ChessBoard.m
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ChessBoard.h"

@interface ChessBoard()
{
    CGFloat horizonGap;
    CGFloat verticalGap;
}
@end

@implementation ChessBoard

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coordinateDictionay = [[NSMutableDictionary alloc]init];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _coordinateDictionay = [[NSMutableDictionary alloc]init];
        horizonGap = frame.size.height/(ChessBoardColums+1);//10跟线,11个区间;水平间距,跟列数相关
        verticalGap = frame.size.width/(ChessBoardRows+1);//9根线,10各区间;//竖直间距跟行数相关
        for (int row=1; row<=ChessBoardRows;row++) {
            for (int cloum=1; cloum<=ChessBoardColums; cloum++) {
                
                NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,cloum];
                
                CGPoint p = CGPointMake(horizonGap*cloum, verticalGap*row);
                [_coordinateDictionay setObject:NSStringFromCGPoint(p) forKey:key];
            }
        }
    }
    return self;
}
-(CGSize)chessSize
{
    return CGSizeMake(MIN(horizonGap, verticalGap),MIN(horizonGap, verticalGap));
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef  context = UIGraphicsGetCurrentContext();
    [self cutomerContex:context Draw:rect];
}

-(void)cutomerContex:(CGContextRef)context Draw:(CGRect)rect
{
    if(_coordinateDictionay.allKeys.count==0)
    {
        return;
    }

    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1);
    //画行
    for (int row=1 ; row<=ChessBoardRows; row++) {
        CGContextMoveToPoint(context, horizonGap, verticalGap*row);
        CGContextAddLineToPoint(context, rect.size.width-horizonGap, verticalGap*row);
        CGContextStrokePath(context);
    }
    //画列
    for(int cloum = 1;cloum<=ChessBoardColums;cloum++)
    {
        NSString *keyBegin = [NSString stringWithFormat:@"(1,%d)",cloum];
        CGPoint pBegin = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:keyBegin]);
        CGContextMoveToPoint(context,pBegin.x,pBegin.y);
        
        if (cloum==1||cloum==ChessBoardColums)//第一条最后一条封闭
        {
            NSString *keyEnd = [NSString stringWithFormat:@"(%d,%d)",(int)ChessBoardRows,cloum];
            
            CGPoint pEnd = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:keyEnd]);
            CGContextAddLineToPoint(context,pEnd.x,pEnd.y);
            //             CGContextStrokePath(context);
        }
        else
        {
            NSString *keyEnd = [NSString stringWithFormat:@"(%d,%d)",(int)ChessBoardRows/2,cloum];
            
            CGPoint pEnd = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:keyEnd]);
            CGContextAddLineToPoint(context,pEnd.x,pEnd.y);
            //             CGContextStrokePath(context);
            //
            NSString *keyBegin2 = [NSString stringWithFormat:@"(%d,%d)",(int)ChessBoardRows/2+1,cloum];
            
            CGPoint pBegin2 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:keyBegin2]);
            CGContextMoveToPoint(context,pBegin2.x,pBegin2.y);
            
            
            //
            NSString *keyEnd2 = [NSString stringWithFormat:@"(%d,%d)",(int)ChessBoardRows,cloum];
            
            CGPoint pEnd2 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:keyEnd2]);
            CGContextAddLineToPoint(context,pEnd2.x,pEnd2.y);
            //             CGContextStrokePath(context);
        }
        CGContextStrokePath(context);
        
        
    }
    //画九宫
    NSString *beginKey1 = @"(1,4)";//1行4列
    NSString *endKey1 = @"(3,6)";//3行6列
    CGPoint endP1 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:endKey1]);
    
    CGPoint beginP1 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:beginKey1]);
    CGContextMoveToPoint(context, beginP1.x, beginP1.y);
    
    CGContextAddLineToPoint(context,endP1.x , endP1.y);
    CGContextStrokePath(context);
    
    
    NSString *beginKey2 = @"(3,4)";//3行4列
    NSString *endKey2 = @"(1,6)";//1行6列
    CGPoint endP2 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:endKey2]);
    
    CGPoint beginP2 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:beginKey2]);
    CGContextMoveToPoint(context, beginP2.x, beginP2.y);
    
    CGContextAddLineToPoint(context,endP2.x , endP2.y);
    CGContextStrokePath(context);
    
    
    NSString *beginKey3 = @"(10,4)";//10行4列
    NSString *endKey3 = @"(8,6)";//8行6列
    CGPoint endP3 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:endKey3]);
    
    CGPoint beginP3 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:beginKey3]);
    CGContextMoveToPoint(context, beginP3.x, beginP3.y);
    
    CGContextAddLineToPoint(context,endP3.x , endP3.y);
    CGContextStrokePath(context);
    
    
    NSString *beginKey4 = @"(8,4)";//8行4列
    NSString *endKey4 = @"(10,6)";//10行6列
    CGPoint endP4 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:endKey4]);
    
    CGPoint beginP4 = CGPointFromString((NSString*)[_coordinateDictionay objectForKey:beginKey4]);
    CGContextMoveToPoint(context, beginP4.x, beginP4.y);
    
    CGContextAddLineToPoint(context,endP4.x , endP4.y);
    CGContextStrokePath(context);
    
    //画文字
    NSString *str1 = @"楚 河";
    NSString *str2 = @"汉 界";
    
    
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *dict = @{NSFontAttributeName:font,
                           NSForegroundColorAttributeName:[UIColor blackColor]};
    CGSize strSize = [str1 sizeWithAttributes:dict];
    
    [str1 drawInRect:CGRectMake(horizonGap+(rect.size.width/2-horizonGap-strSize.width)/2 , rect.size.height/2-strSize.height/2,strSize.width, strSize.height) withAttributes:dict];
    
    [str2 drawInRect:CGRectMake(rect.size.width/2+(rect.size.width/2-horizonGap-strSize.width)/2 , rect.size.height/2-strSize.height/2,strSize.width, strSize.height) withAttributes:dict];
}
-(NSString*)touchLocationToKey:(CGPoint)touchPoint
{
    //误差率;误差处于一半;
    //1 边界以外统统认为在边界
    int row,cloum;
    if (touchPoint.x<horizonGap)//最左边,则认为在左边第一列
    {
        cloum = 1;
    }else if (touchPoint.x>self.bounds.size.width-horizonGap)
    {
        cloum = 9;
    }else
    {
        cloum =  (touchPoint.x + horizonGap/2)/horizonGap;
    }
    
    if (touchPoint.y<verticalGap)//最上面,则认为在第一行
    {
        row = 1;
    }else if (touchPoint.y>self.bounds.size.height-verticalGap)
    {
        cloum = 10;
    }else
    {
        row = (touchPoint.y+verticalGap/2)/verticalGap;
    }
    NSString *str = [NSString stringWithFormat:@"(%d,%d)",row,cloum];
    if ([self.gameDelegate respondsToSelector:@selector(chessBoard:TouchCoordinationString:)]) {
        [self.gameDelegate chessBoard:self TouchCoordinationString:str];
    }
    return str;
    
}

-(void)chessBoard:(ChessBoard*)chessBoard TouchCoordinationString:(NSString*)coordinate;
{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    [self touchLocationToKey:point];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
