//
//  PrimeMinisterChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "PrimeMinisterChess.h"

@interface PrimeMinisterChess ()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end


@implementation PrimeMinisterChess


-(void)setup
{
    pFunctionType = functionTypePrimeMinister;
    pChessName = self.campType==campTypeRed?@"相":@"象";
    pAttackType = unAttacktiveType;
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
