//
//  GunFireChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "GunFireChess.h"

@interface GunFireChess ()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end
@implementation GunFireChess

-(void)setup
{
    pFunctionType = functionTypeGunFire;
    pChessName = self.campType==campTypeRed?@"炮":@"砲";
    pAttackType = attacktiveType;
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
