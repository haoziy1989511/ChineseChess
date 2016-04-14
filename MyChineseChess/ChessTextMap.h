//
//  ChessTextMap.h
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/14.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseChess.h"
/**
 *  棋谱对象;棋谱映射关系表;网络对战就通过传递棋谱实现
 */
@interface ChessTextMap : NSObject

@property(nonatomic,copy)NSString *chessTextTitle;//棋谱标题;
@property(nonatomic,copy)NSString *chessText;//棋谱文字信息;

@property(nonatomic,copy)NSString *chessColumnNameMap;

@property(nonatomic,strong)NSMutableArray *chessStepRecord;//一条条的行棋记录;

-(NSString*)chess:(BaseChess*)chess moveToLocation:(ChessLocationModel *)location;//根据棋子走的步骤生成一条棋谱信息;

@end
