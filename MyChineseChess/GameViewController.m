//
//  GameViewController.m
//  MyChineseChess
//
//  Created by ZEROLEE on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "GameViewController.h"
#import "KingChess.h"
#import "GuardChess.h"
#import "PrimeMinisterChess.h"
#import "HorseChess.h"
#import "CarChess.h"
#import "GunFireChess.h"
#import "SoldierChess.h"
#import "ChessBoard.h"

@interface GameViewController()<ChessBoardDelegate,BaseChessDelegate>
{
    
}

@end
@implementation GameViewController



-(instancetype)initWithChessBoard:(ChessBoard*)chessBoard;
{
    self = [super init];
    if (self) {
        _gameChessBoard = chessBoard;
        _chessMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(instancetype)init
{
    assert(@"请使用 initWithChessBoard:(ChessBoard*)chessBard方法初始化");
    return nil;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    _gameChessBoard.gameDelegate = self;
    [self.view addSubview:_gameChessBoard];
    [self prepareForPlay];
    
}
-(void)prepareForPlay
{
    
    if (_chessMap.allKeys.count>0) {
        return;
    }
    if(_gameChessBoard.coordinateDictionay.allKeys.count>0)
    {
        for (int colum=1; colum<=ChessBoardColums; colum++) {
            for (int row = 1 ; row<=ChessBoardRows; row++) {
                NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,colum];
                CGPoint p = CGPointFromString((NSString*)[_gameChessBoard.coordinateDictionay objectForKey:key]);
                BaseChess *chess;
                
                if (row==1) {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[KingChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        case 1:
                            chess = [[GuardChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        case 2:
                            chess = [[PrimeMinisterChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        case 3:
                            chess = [[HorseChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        case 4:
                            chess = [[CarChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        default:
                            break;
                    }
                }else if (row==3)
                {
                    if (colum==2||colum==ChessBoardColums-1) {
                        chess = [[GunFireChess alloc]initWithCamp:campTypeBlack location:p];
                    }
                    
                }else if (row==4)
                {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        case 2:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        case 4:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeBlack location:p];
                            break;
                        default:
                            break;
                    }
                }else if (row==10)
                {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[KingChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        case 1:
                            chess = [[GuardChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        case 2:
                            chess = [[PrimeMinisterChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        case 3:
                            chess = [[HorseChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        case 4:
                            chess = [[CarChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        default:
                            break;
                    }
                }else if(row==7)
                {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        case 2:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        case 4:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeRed location:p];
                            break;
                        default:
                            break;
                    }
                }else if (row==8)
                {
                    if (colum==2||colum==ChessBoardColums-1) {
                        chess = [[GunFireChess alloc]initWithCamp:campTypeRed location:p];
                    }
                }
                if (chess) {
                    chess.chessDelage = self;
                    chess.uiExhition.frame = CGRectMake(p.x-_gameChessBoard.chessSize.width/2, p.y-_gameChessBoard.chessSize.height/2, _gameChessBoard.chessSize.width, _gameChessBoard.chessSize.height);
                    chess.uiExhition.layer.cornerRadius = _gameChessBoard.chessSize.width/2;
                    [_gameChessBoard addSubview:chess.uiExhition];
                    [_chessMap setObject:chess forKey:key];
                }
            }
        }
    }
    [_gameChessBoard setNeedsDisplay];
}

-(void)chessBoard:(ChessBoard*)chessBoard TouchCoordinationString:(NSString*)coordinate;
{
    if (_currentChess) {
        [ _currentChess chess_move:CGPointFromString((NSString*)[chessBoard.coordinateDictionay objectForKey:coordinate])];
    }
}
-(void)chess:(BaseChess*)chess uiBeClicked:(UIButton*)btn;
{
    _currentChess = chess;
}
-(void)play
{
    
}
@end
