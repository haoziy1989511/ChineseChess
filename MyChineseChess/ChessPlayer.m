//
//  ChessPlayer.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ChessPlayer.h"

#import "KingChess.h"
#import "GuardChess.h"
#import "PrimeMinisterChess.h"
#import "HorseChess.h"
#import "CarChess.h"
#import "GunFireChess.h"
#import "SoldierChess.h"


@implementation ChessPlayer
-(void)play{
    
}
-(instancetype)initWith:(ChessCampType)camp
{
    self  = [super init];
    if (self) {
        [self initChess:camp];
    }
    return self;
}

-(void)initChess:(ChessCampType)camp
{
    _campType = camp;
    _chessMap = [[NSMutableDictionary alloc]init];
}

@end
