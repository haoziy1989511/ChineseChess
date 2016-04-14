//
//  ChessBoard.h
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ChessLocationModel.h"
@class BaseChess;
static NSInteger const ChessBoardRows = 10;//10行
static NSInteger const ChessBoardColums = 9;//10列
@class ChessBoard;

@protocol ChessBoardDelegate <NSObject>

@optional

-(void)chessBoardResetChesses:(ChessBoard*)chessBoard ;//重置棋子;
-(void)chessBoardPrepareForPlay:(ChessBoard*)chessBoard ;//摆放棋子
-(void)chessBoard:(ChessBoard*)chessBoard TouchCoordinationString:(NSString*)coordinate;

@end

@interface ChessBoard : UIView


@property(nonatomic,strong,readonly)NSMutableDictionary<NSString*,ChessLocationModel*> *coordinateDictionay;//坐标集

@property(nonatomic,assign)CGSize chessSize;
@property(weak)id<ChessBoardDelegate>gameDelegate;


-(void)prepareForPlay;//开始摆放
-(void)resetChess;//棋子复位

@end
