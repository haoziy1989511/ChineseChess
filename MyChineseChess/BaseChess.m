//
//  BaseChess.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "BaseChess.h"

@implementation BaseChess

- (id)copyWithZone:(nullable NSZone *)zone;
{
    BaseChess *copy = [[[self class] allocWithZone:zone]initWithCamp:self.campType location:[self.relativeLocation copy]  chessSize:self.chessSize];
    return copy;
}
//-(id)copy
//{
//    return [super copy];
//}

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
-(instancetype)initWithCamp:(ChessCampType)camp location:(ChessLocationModel*)initPosition chessSize:(CGSize)chessSize;
{
    NSAssert(initPosition!=nil, @"不能用空的位置对象初始化");
    NSAssert(chessSize.width!=0||chessSize.height!=0, @"棋子大小不能为0");
    self = [super init];
    if (self) {
        _originRelativeLocation = initPosition;
        _relativeLocation = initPosition;
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
        _uiExhition.frame = CGRectMake(initPosition.absolutPoint.x-chessSize.width/2, initPosition.absolutPoint.y-chessSize.height/2, chessSize.width, chessSize.height);
        _uiExhition.layer.cornerRadius = chessSize.width/2;
        _chessSize = chessSize;
        [self setup];
    }
    return self;
}
-(void)resetToOrigin;
{
    self.uiExhition.selected = NO;
    self.relativeLocation = self.originRelativeLocation;
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
