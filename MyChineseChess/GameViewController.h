//
//  GameViewController.h
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ViewController.h"
@class ChessBoard;
@class BaseChess;
@interface GameViewController : ViewController

@property(nonatomic,strong)BaseChess *currentChess;
@property(nonatomic,strong,readonly)ChessBoard *gameChessBoard;
@property(nonatomic,strong,readonly)NSMutableDictionary *chessMap;//真正进行游戏的棋子

@property(nonatomic,strong,readonly)NSMutableArray<BaseChess*> *orginChess;//初始化阶段的棋子;
-(instancetype)initWithChessBoard:(ChessBoard*)chessBoard;
-(void)prepareForPlay;//准备完毕;
-(void)play;
@end
