//
//  BaseChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "BaseChess.h"

@implementation BaseChess

-(void)chess_move:(CGPoint)targetLocation;//移动方法
{
    self.localtion = targetLocation;
}
-(BOOL)chess_canMoveToLocation:(CGPoint)location;
{
    return NO;
}
-(instancetype)initWithCamp:(ChessCampType)camp location:(CGPoint)initPosition;
{
    self = [super init];
    if (self) {
        _campType = camp;
        _localtion = initPosition;
        [self setup];
    }
    return self;
}
-(void)setup
{
    
}
@end
