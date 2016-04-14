//
//  CarChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "CarChess.h"
@interface CarChess ()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end
@implementation CarChess
-(void)setup
{
    pFunctionType = functionTypeCar;
    pChessName = self.campType==campTypeRed?@"車":@"車";
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
    return (self.relativeLocation.row==location.row||self.relativeLocation.column==location.column);
}
@end
