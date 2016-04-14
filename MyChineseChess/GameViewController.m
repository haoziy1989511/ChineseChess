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
#import "ChessTextRecord.h"

@interface GameViewController()<ChessBoardDelegate,BaseChessDelegate>
{
    ChessCampType currentMoveCamp;//当前行棋阵营;默认是红色
    UIView *controlPane;//控制面板;
    NSMutableArray<ChessTextRecord*> *chessTextArr;
    int gameOrder;//游戏回合
}

@end
@implementation GameViewController



-(instancetype)initWithChessBoard:(ChessBoard*)chessBoard;
{
    self = [super init];
    if (self) {
        _gameChessBoard = chessBoard;
        _chessMap = [[NSMutableDictionary alloc]init];
        _orginChess = [[NSMutableArray alloc]init];
        chessTextArr = [[NSMutableArray alloc]init];
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
    gameOrder = 1;
    CGFloat margin = 20;
    CGFloat btnWith = (self.view.frame.size.width-margin*2)/3;
    
    for (int i = 0; i<3; i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(margin+btnWith*i,64,btnWith,44)];
        btn.tag = i+1000;
        NSString *title = nil;
        if (i==0) {
            title = @"开始游戏";
        }else if(i==1)
        {
            title = @"重置游戏";
        }else
        {
            title = @"退出游戏";
        }
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gameControl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    CGFloat panelWith = self.view.frame.size.width-(_gameChessBoard.frame.size.width+_gameChessBoard.frame.origin.x);
    CGFloat panelHeight = _gameChessBoard.frame.size.height;
    controlPane = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-panelWith, _gameChessBoard.frame.origin.y, panelWith, panelHeight)];
    controlPane.backgroundColor = [UIColor blueColor];
    [self.view addSubview:controlPane];
//    _gameChessBoard.transform = CGAffineTransformMakeRotation(M_PI/2);
    [self.view addSubview:_gameChessBoard];
}

-(void)gameControl:(UIButton*)btn
{
    if (btn.tag==1000) {
        [self prepareForPlay];
    }else if(btn.tag==1001)
    {
        [self restChess];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)restChess
{
    currentMoveCamp = campTypeRed;
    for (BaseChess *chess in [_chessMap allValues]) {
        [chess.uiExhition removeFromSuperview];
    }
    [_chessMap removeAllObjects];
    for (BaseChess *chess in _orginChess) {
        [chess resetToOrigin];
        [_gameChessBoard addSubview:chess.uiExhition];
        [_chessMap setObject:chess forKey:chess.relativeLocation.locationString];
    }
    _currentChess = nil;
}
-(void)prepareForPlay
{
    currentMoveCamp = campTypeRed;
    if (_orginChess.count>0) {
        [self restChess];
        return;
    }
    if(_gameChessBoard.coordinateDictionay.allKeys.count>0)
    {
        for (int colum=1; colum<=ChessBoardColums; colum++) {
            for (int row = 1 ; row<=ChessBoardRows; row++) {
                NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,colum];
                ChessLocationModel *p = [_gameChessBoard.coordinateDictionay objectForKey:key];
                BaseChess *chess;
                
                if (row==1) {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[KingChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 1:
                            chess = [[GuardChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 2:
                            chess = [[PrimeMinisterChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 3:
                            chess = [[HorseChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 4:
                            chess = [[CarChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        default:
                            break;
                    }
                }else if (row==3)
                {
                    if (colum==2||colum==ChessBoardColums-1) {
                        chess = [[GunFireChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                    }
                    
                }else if (row==4)
                {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 2:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 4:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeBlack location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        default:
                            break;
                    }
                }else if (row==10)
                {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[KingChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 1:
                            chess = [[GuardChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 2:
                            chess = [[PrimeMinisterChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 3:
                            chess = [[HorseChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 4:
                            chess = [[CarChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        default:
                            break;
                    }
                }else if(row==7)
                {
                    switch (abs(colum-5)) {
                        case 0:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 2:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        case 4:
                            chess = [[SoldierChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                            break;
                        default:
                            break;
                    }
                }else if (row==8)
                {
                    if (colum==2||colum==ChessBoardColums-1) {
                        chess = [[GunFireChess alloc]initWithCamp:campTypeRed location:p chessSize:_gameChessBoard.chessSize];
                    }
                }
                if (chess) {
                    chess.chessDelage = self;
                    [_gameChessBoard addSubview:chess.uiExhition];
                    [_orginChess addObject:chess];
                    [_chessMap setObject:chess forKey:key];
                }
            }
        }
    }
}


#pragma chessBoadDelegate
-(void)chessBoard:(ChessBoard*)chessBoard TouchCoordinationString:(NSString*)coordinate;
{
    if (_currentChess.campType!=currentMoveCamp)//没有轮到自己行棋,均视为不合法;
    {
        return;
    }
    if ([self isExistChessInCoordinateString:coordinate]) {
        return;
    }
    //无论如何先移除
    ChessLocationModel *model = [chessBoard.coordinateDictionay objectForKey:coordinate];
    
    if ([self chess:_currentChess isCanLocationTo:model]) {
        [self createChessText:_currentChess location:model];
        [_chessMap removeObjectForKey:_currentChess.relativeLocation.locationString];
        [_currentChess chess_move:model];
        [_chessMap setObject:_currentChess forKey:model.locationString];
        _currentChess.uiExhition.selected = NO;
        
        if (currentMoveCamp == campTypeRed) {
            currentMoveCamp = campTypeBlack;
        }else
        {
            currentMoveCamp = campTypeRed;
        }
        gameOrder++;
        _currentChess = nil;
        
    }else
    {
        _currentChess.uiExhition.selected = NO;
        _currentChess = nil;
    }
}
-(void)chessBoardPrepareForPlay:(ChessBoard *)chessBoard
{
    [self prepareForPlay];
}
-(void)chessBoardResetChesses:(ChessBoard *)chessBoard
{
    [self restChess];
}


#pragma chessDelegate
-(void)chess:(BaseChess*)chess uiBeClicked:(UIButton*)btn;
{
    
    //1:在没有选中棋子的情况下;点击棋子视为选中;
    if(_currentChess==nil)
    {
        if (chess.campType!=currentMoveCamp)//没有轮到自己行棋,均视为不合法;
        {
            return;
        }
        _currentChess = chess;
        btn.selected = YES;
        return;
    }else if(_currentChess==chess)//选中的还是自己;不做任何操作
    {
        btn.selected = NO;
        _currentChess = nil;
        return;
        
    }else if(_currentChess.campType==chess.campType)//点到自己其他棋子
    {
        btn.selected = YES;
        _currentChess.uiExhition.selected = NO;//原来的棋子放弃选中
        _currentChess = chess;//改为选中最新的
    }else //吃子
    {
        if (_currentChess.campType!=currentMoveCamp)//没有轮到自己行棋,均视为不合法;
        {
            return;
        }
        //判断是否可以吃
        if ([self chess:_currentChess isCanLocationTo:chess.relativeLocation]) {
            
            [self createChessText:_currentChess location:chess.relativeLocation];
            //吃子过程
            chess.isDeath = YES;//杀死目标棋子
            [chess.uiExhition removeFromSuperview];//从棋盘上移除
            [_chessMap removeObjectForKey:_currentChess.relativeLocation.locationString];//移出map
            //子落到位置
            _currentChess.relativeLocation = chess.relativeLocation;
            //更新字典
            [_chessMap setObject:_currentChess forKey:_currentChess.relativeLocation.locationString];
            _currentChess.uiExhition.selected = NO;
            
            if (currentMoveCamp == campTypeRed) {
                currentMoveCamp = campTypeBlack;
            }else
            {
                currentMoveCamp = campTypeRed;
            }
            gameOrder++;
            _currentChess = nil;
        }else
        {
            _currentChess.uiExhition.selected = NO;
            _currentChess = nil;
            
        }
    }
}
/**
 *  实时的判断某个坐标点是否有棋子
 *
 *  @param coordinateString 坐标点
 *
 *  @return 是否有
 */
-(BOOL)isExistChessInCoordinateString:(NSString*)coordinateString
{
    return [_chessMap objectForKey:coordinateString]!=nil;
}

-(BOOL)chess:(BaseChess*)chess isCanLocationTo:(ChessLocationModel*)location
{
    if (![chess chess_canMoveToLocation:location]) {
        return NO;
    }else
    {
        if ([chess isKindOfClass:[CarChess class]])//如果是车;//中间不能有阻挡
        {
            if (chess.relativeLocation.row==location.row)//如果是同行,则判断列
            {
                for (int colom = MIN(chess.relativeLocation.column, location.column)+1; colom<MAX(chess.relativeLocation.column, location.column); colom++) {
                    NSString *key = [NSString stringWithFormat:@"(%d,%d)",location.row,colom];
                    if ([self isExistChessInCoordinateString:key]) {
                        return NO;
                    }
                }
                return YES;
            }else
            {
                for (int row = MIN(chess.relativeLocation.row, location.row)+1; row<MAX(chess.relativeLocation.row, location.row); row++) {
                    NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,location.column];
                    if ([self isExistChessInCoordinateString:key]) {
                        return NO;
                    }
                }
                return YES;
            }
        }else if ([chess isKindOfClass:[GunFireChess class]])//如果是炮;中间要么没有子;要么只能为1
        {
            //判断目的地是否有子
            
            int coutBetweenToLocation = 0;
            if (chess.relativeLocation.row==location.row)//如果是同行,则判断列
            {
                for (int colom = MIN(chess.relativeLocation.column, location.column)+1; colom<MAX(chess.relativeLocation.column, location.column); colom++) {
                    NSString *key = [NSString stringWithFormat:@"(%d,%d)",location.row,colom];
                    if ([self isExistChessInCoordinateString:key]) {
                        coutBetweenToLocation++;
                    }
                }
                BaseChess *enamyChess = [_chessMap objectForKey:location.locationString];
                if (coutBetweenToLocation==0)//中间没有子,则炮吃子得隔一个子才能吃;
                {
                    if (enamyChess)//去路上有子,不能走
                    {
                        return NO;
                    }else{
                        return YES;
                    }
                    
                }else if(coutBetweenToLocation==1)
                {
                    if (enamyChess==nil) {
                        return NO;
                    }
                    if (enamyChess.campType==chess.campType) {
                        return NO;
                    }
                    return YES;
                }else
                {
                    return NO;
                }
    
            }else
            {
                for (int row = MIN(chess.relativeLocation.row, location.row)+1; row<MAX(chess.relativeLocation.row, location.row); row++) {
                    NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,location.column];
                    if ([self isExistChessInCoordinateString:key]) {
                        coutBetweenToLocation++;
                    }
                }
                BaseChess *enamyChess = [_chessMap objectForKey:location.locationString];
                if (coutBetweenToLocation==0) {
                    if (enamyChess) {
                        return NO;
                    }else{
                        return YES;
                    }
                    
                }else if(coutBetweenToLocation==1)
                {
                    if (enamyChess==nil) {
                        return NO;
                    }
                    if (enamyChess.campType==chess.campType) {
                        return NO;
                    }
                    return YES;
                }else
                {
                    return NO;
                }
            }
        }else if([chess isKindOfClass:[PrimeMinisterChess class]])//象,判断是否象眼有子
        {
            int row = (chess.relativeLocation.row+location.row)/2;
            int colom = (chess.relativeLocation.column+location.column)/2;
            NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,colom];
            if ([self isExistChessInCoordinateString:key]) {
                return NO;
            }else{
                return YES;
            }
        }else if ([chess isKindOfClass:[HorseChess class]])//马,查看是否被憋马腿
        {
            int orient = 0;
            //马行走共有八面,其中方向为4个;前后左右各一个;分别设置上坐下右;1,2,3,4,
            //1:往前走;row减小2;
            if(chess.relativeLocation.row-2==location.row)
            {
                orient = 1;
            }else if (chess.relativeLocation.column-2 == location.column)//2:往左跳;column减小2
            {
                orient = 2;
            }else if (chess.relativeLocation.row+2==location.row)//3:往下跳;row增加2
            {
                orient = 3;
            }else if (chess.relativeLocation.column+2==location.column)//4:往右跳,column增加2
            {
                orient = 4;
            }else//马必须符合以上几种;否则在马的行动判断就不能通过
            {
                return NO;
            }
            NSString *key = nil;
            switch (orient) {
                case 1://则看正前方有没有子;行减一列不变
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row-1,chess.relativeLocation.column];
                    return ![self isExistChessInCoordinateString:key];
                }
                case 2://正左面.列减一;行不变
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row,chess.relativeLocation.column-1];
                    return ![self isExistChessInCoordinateString:key];

                }
                case 3://正下方;行加1;列不变
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row+1,chess.relativeLocation.column];
                    return ![self isExistChessInCoordinateString:key];

                }
                case 4://正右方;行不变,列加1
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row,chess.relativeLocation.column+1];
                    return ![self isExistChessInCoordinateString:key];

                }
                default:
                    return NO;
            }
        }else
        {
            return YES;
        }
    }
    return NO;
}
-(void)createChessText:(BaseChess*)chess location:(ChessLocationModel*)location
{
    //判断该子所在列，有没有跟自己一样并且一个阵营的子；
    int brotherCount = 0;
    NSInteger index = 0;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int row=1; row<=ChessBoardRows; row++)//从顶部开始扫描。扫描到；数组索引越靠后的越在棋盘下
    {
        NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,chess.relativeLocation.column];
        BaseChess *brotherChess = (BaseChess*)[_chessMap objectForKey:key];
        if (brotherChess.campType==chess.campType&&brotherChess.functionType==chess.functionType){
            brotherCount++;
            if (row==chess.relativeLocation.row) {
                index = arr.count;//找到在数组中的下标，这是从下到上的位置索引，
            }
            [arr addObject:brotherChess];
        }
    
    }
    ChesstextAmbiguous ambiogus = ChessTextAmbiguousNone;
    switch (arr.count) {
        case 1:
        {
            ambiogus = ChessTextAmbiguousNone;
            break;
        }
        case 2:
        {
            //索引越大，越在棋盘下面；
            if(index==0)//自己在前面；说明自己是在棋盘上方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousFront;
                }else
                {
                    ambiogus = ChessTextAmbiguousBehind;
                }
            }else{
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousBehind;
                }else
                {
                    ambiogus = ChessTextAmbiguousFront;
                }
            }
        }
            break;
        case 3:
        {
            //查看棋子是棋盘的上方还是下方
            if(index==0)//自己在前面；说明自己是在棋盘上方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousFront;
                }else
                {
                    ambiogus = ChessTextAmbiguousBehind;
                }
            }else if (index==1)
            {
                ambiogus = ChessTextAmbiguousMiddle;
            }else //最后一个。说明自己在最下方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousBehind;
                }else
                {
                    ambiogus = ChessTextAmbiguousFront;
                }
            }
        }
            break;
        case 4:
        {
            //查看棋子是棋盘的上方还是下方
            if(index==0)//自己在前面；说明自己是在棋盘上方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousOne;
                }else
                {
                    ambiogus = ChesstextAmbiguousFour;
                }
            }else if (index==1)
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousTwo;
                }else
                {
                    ambiogus = ChesstextAmbiguousThree;
                }
            }else if(index==2)//最后一个。说明自己在最下方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChesstextAmbiguousThree;
                }else
                {
                    ambiogus = ChessTextAmbiguousTwo;
                }
            }else{
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChesstextAmbiguousFour;
                }else
                {
                    ambiogus = ChessTextAmbiguousOne;
                }
            }
            
        }
            break;
        case 5:
        {
            //查看棋子是棋盘的上方还是下方
            if(index==0)//自己在前面；说明自己是在棋盘上方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousOne;
                }else
                {
                    ambiogus = ChesstextAmbiguousFive;
                }
            }else if (index==1)
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChessTextAmbiguousTwo;
                }else
                {
                    ambiogus = ChesstextAmbiguousFour;
                }
            }else if(index==2)//最后一个。说明自己在最下方；
            {
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChesstextAmbiguousThree;
                }else
                {
                    ambiogus = ChesstextAmbiguousThree;
                }
            }else if(index==3){
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChesstextAmbiguousFour;
                }else
                {
                    ambiogus = ChessTextAmbiguousTwo;
                }
            }else{
                if (chess.campType==campTypeRed)//如果是红棋；则自己这个棋子是 前
                {
                    ambiogus  = ChesstextAmbiguousFive;
                }else
                {
                    ambiogus = ChessTextAmbiguousOne;
                }
            }
            
        }
        default:
            break;
    }
    ChessTextRecord *record = [[ChessTextRecord alloc]initWithOrder:gameOrder chess:_currentChess targetLocation:location containAmgious:ambiogus];
    NSLog(@"%@",[NSString stringWithFormat:@"%@\n",record.chessTextString]);
    [chessTextArr addObject:record];
    
}
-(void)play
{
    
}
@end
