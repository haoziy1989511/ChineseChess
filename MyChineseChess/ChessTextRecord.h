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
typedef NS_ENUM(NSInteger,ChesstextAmbiguous)
{
    ChessTextAmbiguousNone = 1,//1->1->1-1不含歧义,原始数字->移位数->二进制数->最终数字
    ChessTextAmbiguousFront = 1<<1,//1->1->10->2,前 后面一个兄弟类型
    ChessTextAmbiguousBehind = 1<<2, //1->2->100->4 后 后面没有兄弟类型
    
    ChessTextAmbiguousMiddle = 1<<3, //1->3->1000->8 有三个在一条线上 才会出现
    ChessTextAmbiguousOne = 1<<4,//1->4->10000->16 如果出现四个兵在一条线才会用一，二，三，四，五来表示
    ChessTextAmbiguousTwo = 1<<5,//1->5->100000->32
    ChesstextAmbiguousThree = 1<<6,//1->6->1000000->64
    ChesstextAmbiguousFour = 1<<7,//1->7->10000000->128
    
    ChesstextAmbiguousFive = 1<<8,//1->8->100000000->256
    
};


typedef NS_ENUM(NSInteger,ChessTextMoveTpye)
{
    ChessTextMoveTypeUnknow = 0,//未知的.不合法
    
    ChessTextMoveUp,//虚拟坐标位置row减小了;往棋盘上方走
    ChessTextMoveDown,//虚拟坐标位置row增加了;往棋盘下方走
    
    ChessTextMoveStraightUp, //垂直向上,列相同;行减小
    ChessTextMoveStraightDown, //垂直向下,列相同;行增加
    
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

//最后一个参数是检查是否含有模糊含义的；
-(instancetype)initWithOrder:(int)recordOrder chess:(BaseChess*)chess targetLocation:(ChessLocationModel*)location containAmgious:(ChesstextAmbiguous)ambigous;//
@end

