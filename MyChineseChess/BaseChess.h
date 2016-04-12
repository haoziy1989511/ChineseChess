//
//  BaseChess.h
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseChess : NSObject
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
    campTypeBlack = 1//阵营，黑棋
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
@property(nonatomic,assign,readonly)ChessAttackType attackType;//功能，进攻型\防守型
@property(nonatomic,assign)CGPoint localtion;//位置
@property(nonatomic,assign)BOOL isDeath;//是否已经死亡
-(void)chess_move:(CGPoint)targetLocation;//移动方法
-(BOOL)chess_canMoveToLocation:(CGPoint)location;
-(instancetype)initWithCamp:(ChessCampType)camp location:(CGPoint)initPosition;
-(void)setup;
@end
