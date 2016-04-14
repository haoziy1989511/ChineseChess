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
        _recordOrder = recordOrder;//顺序执行
        _chessName = chess.chessName;//名字
        _chessColumn = chess.relativeLocation.column;//列
        if (location.column==chess.relativeLocation.column) {
             _stepLength = abs(location.row-chess.relativeLocation.row);//步长
        }else
        {
             _stepLength = abs(location.column-chess.relativeLocation.column);//步长
        }
        
       
        if (chess.relativeLocation.row==location.row)//行相同,则平
        {
            if(chess.relativeLocation.column>location.column)
            {
                _chessMoveType = ChessTextMoveLeft;//左平
            }else
            {
                _chessMoveType = ChessTextMoveRight;//右平
            }
        }else
        {
            if (chess.relativeLocation.row>location.row)//行减少;
            {
                _chessMoveType = ChessTextMoveUp ;//行减少了;往棋盘上方移动
            }else
            {
                _chessMoveType =  ChessTextMoveDown;//行增加;棋盘下方移动
            }
        }
    }
    return self;
}

-(NSString*)chessTextString
{
    
    return [NSString stringWithFormat:@"%@%@%@%@",_chessName,[self chineseNameMapOrder:_recordOrder number:_chessColumn],[self forwardOrBack:_chessMoveType],[self chineseNameMapOrder:_recordOrder number:_stepLength]];
}

-(NSString*)forwardOrBack:(ChessTextMoveTpye)type
{
    
    switch (type) {
        case ChessTextMoveUp:
        {
            if (_recordOrder%2==1)//红棋往上方移动是 进 反之 退
            {
                return  @"进";
            }else
            {
                return @"退";
            }
        }
            break;
        case ChessTextMoveDown:
        {
            if (_recordOrder%2==0)//黑棋往下方移动 是进 反之 退
            {
                return  @"进";
            }else
            {
                return @"退";
            }
        }
        case ChessTextMoveRight:
        {
            return @"平";
        }
        case ChessTextMoveLeft:
        {
            return @"平";
        }
        default:
            return nil;
            break;
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
