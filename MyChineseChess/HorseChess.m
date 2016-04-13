//
//  HorseChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "HorseChess.h"

@interface HorseChess ()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end
@implementation HorseChess
-(void)setup
{
    pFunctionType = functionTypeHorse;
    pChessName = self.campType==campTypeRed?@"馬":@"馬";
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
