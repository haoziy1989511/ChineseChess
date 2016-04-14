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
    //;距离都必须是2
    if (abs(location.row-self.relativeLocation.row)==2&&abs(self.relativeLocation.column-location.column)==2) {
        if (self.campType==campTypeRed) {
            return location.row>=6;
        }else
        {
            return location.row<=5;
        }
    }else
    {
        return NO;
    }
}
@end
