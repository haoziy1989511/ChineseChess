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

-(instancetype)initWithCamp:(ChessCampType)camp location:(ChessLocationModel*)initPosition chessSize:(CGSize)chessSize;
{
    self = [super initWithCamp:camp location:initPosition chessSize:chessSize];
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
-(BOOL)chess_canMoveToLocation:(ChessLocationModel *)location
{
    //;距离都必须是1
    if (abs(location.row-self.relativeLocation.row)==1&&abs(self.relativeLocation.column-location.column)==1) {
        if (location.column>=4&&location.column<=6) {
            if (self.campType==campTypeRed) {
                return location.row>=8&&location.row<=10;
            }else
            {
                return location.row>=1&&location.row<=3;
            }
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}
@end
