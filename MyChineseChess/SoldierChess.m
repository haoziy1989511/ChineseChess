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
-(BOOL)isCanmoveHorizen
{
    if (self.campType==campTypeRed)//默认红棋在下方；
    {
        if (self.relativeLocation.row<6) {
            return YES;
        }else{
            return NO;
        }
    }else
    {
        if (self.relativeLocation.row<6) {
            return NO;
        }else{
            return YES;
        }
        
    }
}
-(BOOL)chess_canMoveToLocation:(ChessLocationModel*)location;
{
    //先判断距离;//步长大于1都不能走
    if (abs(self.relativeLocation.row-location.row)+abs(self.relativeLocation.column-location.column)<2) {
        if(self.relativeLocation.column!=location.column)//横移的凡是未过河都不能走
        {
            return self.isCanmoveHorizen;
        }else
        {
            if (self.campType==campTypeRed) {
                return self.relativeLocation.row>location.row;
            }else{
                return self.relativeLocation.row<location.row;
            }
        }
    }else{
        return NO;
    }
}
@end
