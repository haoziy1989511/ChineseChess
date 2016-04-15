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
@class KingChess;
@interface GameViewController : ViewController

@property(nonatomic,strong)BaseChess *currentChess;
@property(nonatomic,strong,readonly)ChessBoard *gameChessBoard;
@property(nonatomic,strong,readonly)NSMutableDictionary *chessMap;//真正进行游戏的棋子
@property(nonatomic,strong)NSMutableDictionary *chessMapCopy;//棋子的副本;用于推演行棋合法性(主要是老将是否正在被将军,或者行完后处于将军状态)
@property(nonatomic,weak,readonly)KingChess *redKing;//红方老帅
@property(nonatomic,weak,readonly)KingChess *blackKing;//黑方老将
@property(nonatomic,strong,readonly)NSMutableArray<BaseChess*> *orginChess;//初始化阶段的棋子;
-(instancetype)initWithChessBoard:(ChessBoard*)chessBoard;
-(void)prepareForPlay;//准备完毕;
-(void)play;
@end
