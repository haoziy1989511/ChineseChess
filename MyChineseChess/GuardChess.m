//
//  GuardChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "GuardChess.h"

@interface GuardChess ()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end


@implementation GuardChess

-(instancetype)initWithCamp:(ChessCampType)camp location:(CGPoint)initPosition
{
    self = [super initWithCamp:camp location:initPosition];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    pFunctionType = functionTypeGuard;
    pChessName = self.campType==campTypeRed?@"仕":@"士";
    pAttackType = unAttacktiveType;
    [super setup];
}
-(ChessFunctionType)functionType
{
    return pFunctionType;
}
-(NSString*)chessName
{
    return pChessName;
}
-(ChessAttackType)attackType
{
    return pAttackType;
}
@end
