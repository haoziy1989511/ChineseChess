//
//  BaseChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "BaseChess.h"

@implementation BaseChess

-(void)chess_move:(ChessLocationModel*)targetLocation;//移动方法
{
    _relativeLocation = targetLocation;
    self.uiExhition.center = targetLocation.absolutPoint;
}
-(void)setRelativeLocation:(ChessLocationModel *)relativeLocation
{
    _relativeLocation = relativeLocation;
    self.uiExhition.center = relativeLocation.absolutPoint;
}
-(BOOL)chess_canMoveToLocation:(ChessLocationModel*)location;
{
    return NO;
}
-(instancetype)initWithCamp:(ChessCampType)camp location:(CGPoint)initPosition;
{
    self = [super init];
    if (self) {
        _campType = camp;
        _uiExhition  = [[UIButton alloc]init];
        if (camp==campTypeRed) {
            _uiExhition.backgroundColor = [UIColor purpleColor];
            [_uiExhition setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else
        {
            [_uiExhition setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _uiExhition.backgroundColor = [UIColor grayColor];
        }
         [_uiExhition setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_uiExhition addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self setup];
    }
    return self;
}
/**
 *  点击棋子,视为选中自己,或者吃掉别人棋子
 *
 *  @param btn 棋子UI呈现
 */
-(void)clicked:(UIButton*)btn
{
    if ([_chessDelage respondsToSelector:@selector(chess:uiBeClicked:)]) {
        [_chessDelage chess:self uiBeClicked:btn];
    }
}
-(void)setup
{
    [_uiExhition setTitle:self.chessName forState:UIControlStateNormal];
}
@end
