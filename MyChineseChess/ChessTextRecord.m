//
//  ChessTextRecord.m
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/14.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ChessTextRecord.h"

@implementation ChessTextRecord

-(instancetype)init
{
    assert(@"should init with -(instancetype)initWithOrder:(int)recordOrder chess:(BaseChess*)chess targetLocation:(ChessLocationModel*)location");
    return nil;
}

-(instancetype)initWithOrder:(int)recordOrder chess:(BaseChess*)chess targetLocation:(ChessLocationModel*)location;
{
    self = [super init];
    if (self) {
        _recordOrder = recordOrder;
        _chessName = chess.chessName;
        _chessColumn = chess.relativeLocation.column;
        _stepLength = abs(location.row-chess.relativeLocation.row);
    }
    return self;
}

-(NSString*)chessTextString
{
    if (_recordOrder%2==1)//红棋回合产生;
    {
        
    }
}

-(NSString*)chineseNameMapOrder:(int)order number:(uint)number;
{
    assert(number<=9&&number>0);
    if (order%2==0)//红棋 返回大写中文
    {
        switch (number) {
            case 1:
                return @"一";
            case 2:
                return @"二";
            case 3:
                return @"三";
            case 4:
                return @"四";
            case 5:
                return @"五";
            case 6:
                return @"六";
            case 7:
                return @"七";
            case 8:
                return @"八";
            case 9:
                return @"九";
            default:
                return nil;
                break;
        }
    }else
    {
        return [NSString stringWithFormat:@"%d",number];
    }
}

@end
