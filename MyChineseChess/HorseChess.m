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
-(BOOL)chess_canMoveToLocation:(ChessLocationModel *)location
{
    //日形,row相差1 并且colum相差2;或者colum差1;row差2;
    if(abs(self.relativeLocation.row-location.row)+abs(self.relativeLocation.column-location.column)==3)
    {
        if (abs(self.relativeLocation.row-location.row)>=3) {
            return NO;
        }else if(abs(self.relativeLocation.column-location.column)>=3) {
            return NO;
        }else
        {
            return YES;
        }
        
    }else
    {
        return NO;
    }
    
}
@end
