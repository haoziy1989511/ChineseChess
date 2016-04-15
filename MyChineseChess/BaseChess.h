//
//  BaseChess.h
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChessLocationModel.h"

@class BaseChess;
@protocol BaseChessDelegate <NSObject>

-(void)chess:(BaseChess*)chess uiBeClicked:(UIButton*)btn;
/**
 *  移动
 *
 *  @param chess    要移动的棋子
 *  @param location 目标位置
 */
-(void)chess:(BaseChess*)chess moveToLocation:(ChessLocationModel*)location;
/**
 *  吃子
 *
 *  @param chess       要行动的棋子
 *  @param targetChess 要被吃掉的棋子
 */
-(void)chess:(BaseChess*)chess eateChess:(BaseChess*)targetChess;
@end


@interface BaseChess : NSObject<NSCopying>
typedef NS_ENUM(NSInteger,ChessAttackType)//棋子分为能过河和不能过河的
{
    unknowAttacktiveType = 0,//未知类型属于不合法棋子
    attacktiveType ,//攻击型的，占大多数
    unAttacktiveType //不能过河的 象，士，将，帅，
    
    
};
typedef NS_ENUM(NSInteger,ChessCampType)//棋子分为红旗和黑棋
{
    campTypeUnkown = 0,//未知阵营，不合法的棋子
    campTypeRed,//阵营，红棋
    campTypeBlack//阵营，黑棋
};
typedef NS_ENUM(NSInteger,ChessFunctionType)//棋子功能类型
{
 
    functionUnknow = 0,//未知功能棋子，不合法
    functionTypeKing,//将，帅
    functionTypeGuard,//士，仕
    functionTypePrimeMinister,//象、相
    functionTypeSoldier,//卒，兵
    functionTypeGunFire,//砲，炮
    functionTypeHorse,//馬
    functionTypeCar,//車
};
@property(nonatomic,assign,readonly)ChessCampType campType;//阵营
@property(nonatomic,assign,readonly)ChessFunctionType functionType;//功能
@property(nonatomic,copy,readonly)NSString *chessName;//名字
@property(nonatomic,assign,readonly)ChessAttackType attackType;//进攻型\防守型
@property(nonatomic,copy)ChessLocationModel *relativeLocation;//位置对象
@property(nonatomic,copy,readonly) ChessLocationModel *originRelativeLocation;//棋子原始位置,便于一键复位
@property(nonatomic,assign)BOOL isDeath;//是否已经死亡
@property(nonatomic,readonly,copy)UIButton *uiExhition;//棋子的UI呈现
@property(nonatomic,weak) id<BaseChessDelegate> chessDelage;
@property(nonatomic,assign)CGSize chessSize;

-(void)chess_move:(ChessLocationModel*)targetLocation;//移动方法
-(BOOL)chess_canMoveToLocation:(ChessLocationModel*)location;//只包含几何关系的判断;例如车走直线,但是不能判断中间都阻挡;相走田也不能判断相眼是否被塞;
-(instancetype)initWithCamp:(ChessCampType)camp location:(ChessLocationModel*)initPosition chessSize:(CGSize)chessSize;
-(void)resetToOrigin;
-(void)setup;
@end
