//
//  SoldierChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "SoldierChess.h"



@interface SoldierChess ()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end

@implementation SoldierChess
-(void)setup
{
    pFunctionType = functionTypeSoldier;
    pChessName = self.campType==campTypeRed?@"兵":@"卒";
    pAttackType = attacktiveType;
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
