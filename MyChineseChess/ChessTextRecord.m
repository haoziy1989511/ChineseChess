//
//  ChessTextRecord.m
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/14.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ChessTextRecord.h"

@interface ChessTextRecord()
{
    int stepLength;//用于文字信息的
    ChesstextAmbiguous isContaintAmbigous;//模糊含义；
}

@end

@implementation ChessTextRecord

-(instancetype)init
{
    assert(@"should init with -(instancetype)initWithOrder:(int)recordOrder chess:(BaseChess*)chess targetLocation:(ChessLocationModel*)location");
    return nil;
}

-(instancetype)initWithOrder:(int)recordOrder chess:(BaseChess*)chess targetLocation:(ChessLocationModel*)location containAmgious:(ChesstextAmbiguous)ambigous;
{
    self = [super init];
    if (self) {
        _recordOrder = recordOrder;//顺序执行
        _chessName = chess.chessName;//名字
        _chessColumnStart = chess.relativeLocation.column;//列
        _chessRowStart = chess.relativeLocation.row;
        _chessColumnEnd = location.column;
        _chessRowEnd = location.row;
        isContaintAmbigous = ambigous;
        if (location.column==chess.relativeLocation.column)//只有车，或者炮会走到此情形
        {
            stepLength = abs(_chessRowEnd-_chessRowStart);
        }else
        {
            stepLength = _chessColumnEnd;
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
    NSString *startName = nil;
    if (_chessMoveType==ChessTextMoveLeft||_chessMoveType==ChessTextMoveRight) {
        startName = [self horizonMoveMapStepLength:stepLength];
    }else{
        startName = [self chineseNameMapSteplength:stepLength];
    }
    
    switch (isContaintAmbigous) {
        case ChessTextAmbiguousNone:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",_recordOrder,
                    _chessName,
                    [self chineseNameMapOrder:_recordOrder number:_chessColumnStart],
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
            break;
        case ChessTextAmbiguousFront:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    @"前",
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        case ChessTextAmbiguousBehind:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    @"后",
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    [self chineseNameMapSteplength:stepLength]];
        }
        case ChessTextAmbiguousMiddle:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    @"中",
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        case ChessTextAmbiguousOne:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    [self chineseNameMapSteplength:1],
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        case ChessTextAmbiguousTwo:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    [self chineseNameMapSteplength:2],
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        case ChesstextAmbiguousThree:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    [self chineseNameMapSteplength:3],
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        case ChesstextAmbiguousFour:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    [self chineseNameMapSteplength:4],
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        case ChesstextAmbiguousFive:
        {
            return [NSString stringWithFormat:@"%d.%@%@%@%@",
                    _recordOrder,
                    [self chineseNameMapSteplength:1],
                    _chessName,
                    [self forwardOrBack:_chessMoveType],
                    startName];
        }
        default:
            break;
    }
    
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
-(NSString*)horizonMoveMapStepLength:(uint)number//水平移动的左边映射
{
    assert(number<=9&&number>0);
    if (_recordOrder%2==1)//红棋 返回大写中文
    {
        switch (10-number) {
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

-(NSString*)chineseNameMapSteplength:(uint)number;//前进或者后退步长转化，实际切换
{
    assert(number<=9&&number>0);
    if (_recordOrder%2==1)//红棋 返回大写中文
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


-(NSString*)chineseNameMapOrder:(int)order number:(uint)number;//列转化，红方的坐标系要逆转
{
    assert(number<=9&&number>0);
    if (order%2==1)//红棋 返回大写中文
    {
        switch (10-number) {
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
