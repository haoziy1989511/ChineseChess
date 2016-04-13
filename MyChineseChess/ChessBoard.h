//
//  ChessBoard.h
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
static NSInteger const ChessBoardRows = 10;//10行
static NSInteger const ChessBoardColums = 9;//10列
@class ChessBoard;

@protocol ChessBoardDelegate <NSObject>
-(void)chessBoard:(ChessBoard*)chessBoard TouchCoordinationString:(NSString*)coordinate;

@end

@interface ChessBoard : UIView


@property(nonatomic,strong,readonly)NSMutableDictionary *coordinateDictionay;//坐标集
@property(nonatomic,assign)CGSize chessSize;
@property(weak)id<ChessBoardDelegate>gameDelegate;
@end
