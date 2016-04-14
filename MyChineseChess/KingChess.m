//
//  KingChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "KingChess.h"

@interface KingChess()
{
    ChessFunctionType pFunctionType;
    NSString *pChessName;
    ChessAttackType pAttackType;
}
@end


@implementation KingChess
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
    pFunctionType = functionTypeKing;
    pChessName = self.campType==campTypeRed?@"帅":@"将";
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
    if (abs(self.relativeLocation.row-location.row)+abs(self.relativeLocation.column-location.column)<2)
    {
        if (location.column>=4&&location.column<=6) {
            if (self.campType == campTypeRed) {
                return location.row>=8&&location.row<=10;
            }else
            {
                return location.row>=1&&location.row<=3;
            }
            
        }else{
            return NO;
        }
        
    }else
    {
        return NO;
    }
    
    
}
@end
