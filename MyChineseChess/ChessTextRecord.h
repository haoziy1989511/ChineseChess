//
//  ChessTextRecord.h
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/14.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseChess.h"
/**
 *  行棋记录;//可以转为json在网络,蓝牙等之间传播,不引入自定义类型是为了方便本地化的可读性;
 */

//

typedef NS_ENUM(NSInteger,ChessTextMoveTpye)
{
    ChessTextMoveTypeUnknow = 0,//未知的.不合法
    ChessTextMoveUp,//虚拟坐标位置row减小了;往棋盘上方走
    ChessTextMoveDown,//虚拟坐标位置row增加了;往棋盘下方走
    
    ChessTextMoveLeft,//左平,只能针对平行移动的棋
    
    ChessTextMoveRight//右平,只能针对平行移动的棋
};

@interface ChessTextRecord : NSObject

@property(nonatomic,assign,readonly)int recordOrder;//回合数;
@property(nonatomic,copy,readonly)NSString *chessName;//棋子名字;//如果出现一列两个子是同一类型;则会有前后区分;//车
@property(nonatomic,assign,readonly)int chessColumnStart;//列 移动前
@property(nonatomic,assign,readonly)int chessRowStart;//行,移动前
@property(nonatomic,assign,readonly)ChessTextMoveTpye chessMoveType;//移动的方向
@property(nonatomic,assign,readonly)int chessRowEnd;//行,移动前
@property(nonatomic,assign,readonly)int chessColumnEnd;//
@property(nonatomic,copy,readonly)NSString *chessTextString;//至关重要的Key;能否翻译成行棋,至关重要

-(instancetype)initWithOrder:(int)recordOrder chess:(BaseChess*)chess targetLocation:(ChessLocationModel*)location;
@end

