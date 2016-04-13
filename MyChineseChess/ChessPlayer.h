//
//  ChessPlayer.h
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseChess.h"
#import "ChessBoard.h"

@interface ChessPlayer : NSObject

//@property(nonatomic,strong,readonly)NSMutableDictionary *kingChess;
//@property(nonatomic,strong,readonly)NSMutableDictionary *guardChess;
//@property(nonatomic,strong,readonly)NSMutableDictionary *primeMinisterChess;
//@property(nonatomic,strong,readonly)NSMutableDictionary *horseChess;
//@property(nonatomic,strong,readonly)NSMutableDictionary *carChess;
//@property(nonatomic,strong,readonly)NSMutableDictionary *gunFireChess;
//@property(nonatomic,strong,readonly)NSMutableDictionary *soldierChess;

@property(nonatomic,strong,readonly)NSMutableDictionary *chessMap;
@property(nonatomic,assign)ChessCampType campType;//阵营;考虑交换阵营的问题;
-(instancetype)initWith:(ChessCampType)camp;//初始化玩家;
-(void)prepareForPlayIn:(ChessBoard*)chessBoard;//准备完毕;
@end
