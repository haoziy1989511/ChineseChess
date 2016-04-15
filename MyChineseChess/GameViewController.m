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
        _chessMapCopy = [[NSMutableDictionary alloc]init];
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
    gameOrder = 1;
    for (BaseChess *chess in [_chessMap allValues]) {
        [chess.uiExhition removeFromSuperview];
    }
    [_chessMap removeAllObjects];
    for (BaseChess *chess in _orginChess) {
        [chess resetToOrigin];
        [_gameChessBoard addSubview:chess.uiExhition];
        if ([chess isKindOfClass:[KingChess class]]) {
            if (chess.campType == campTypeRed) {
                _redKing = (KingChess*)chess;
            }else{
                _blackKing = (KingChess*)chess;
            }
        }
        [_chessMap setObject:chess forKey:chess.relativeLocation.locationString];
        [_chessMapCopy setObject:chess forKey:chess.relativeLocation.locationString];
    }
    _currentChess = nil;
}
-(void)prepareForPlay
{
    currentMoveCamp = campTypeRed;
    gameOrder = 1;
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
                            _blackKing = (KingChess*)chess;
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
                            _redKing = (KingChess*)chess;
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
                    
                    [_chessMapCopy setObject:[chess copy] forKey:chess.relativeLocation.locationString];
//                    [_chessMapCopy setObject:chess forKey:chess.relativeLocation.locationString];
                }
            }
        }
    }
}
#pragma mark -- 判断当前下棋人老将是被将军
-(BOOL)kingIsBeAttacking
{
    BOOL kingIsBeAttacking = NO;
    for (BaseChess *chess in [_chessMapCopy allValues]){
        if(chess.campType!=currentMoveCamp)//当前下下棋人的子不予考虑
        {
            if ([self kingIsBeThreatnInChess:chess]) {
                return YES;
            }
        }
        
    }
    return kingIsBeAttacking;
}




-(BOOL)kingIsBeThreatnInChess:(BaseChess*)chess
{
    if (chess.attackType!=attacktiveType)//所有非进攻型均不能直接威胁老将
    {
        return NO;
    }
    if (chess.campType==campTypeRed)//如果是红棋,则判断是否能吃到黑将
    {
        return [self chess:chess isCanLocationTo:_blackKing.relativeLocation withChessMap:_chessMapCopy];
    }
    else{
        return [self chess:chess isCanLocationTo:_redKing.relativeLocation withChessMap:_chessMapCopy];
    }
    return NO;
}

#pragma mark --chessBoadDelegate
-(void)chessBoard:(ChessBoard*)chessBoard TouchCoordinationString:(NSString*)coordinate;
{
    if (_currentChess.campType!=currentMoveCamp)//没有轮到自己行棋,均视为不合法;
    {
        return;
    }
    if ([self isExistChessInCoordinateString:coordinate inChessMap:_chessMap]) {
        return;
    }
    //先模拟走子能否通过
    if ([self preMoveChess:_currentChess.relativeLocation.locationString moveToLocation:[_gameChessBoard.coordinateDictionay objectForKey:coordinate]]) {
        [self moveCurrentChesstoTargetLocation:[_gameChessBoard.coordinateDictionay objectForKey:coordinate]];
         
    }else
    {
        _currentChess.uiExhition.selected = NO;
        _currentChess = nil;
    }
}
#pragma  mark --准备
-(void)chessBoardPrepareForPlay:(ChessBoard *)chessBoard
{
    [self prepareForPlay];
}
#pragma  mark --重置
-(void)chessBoardResetChesses:(ChessBoard *)chessBoard
{
    [self restChess];
}


#pragma mark --chessDelegate
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
        if ([self preEaeChess:_currentChess.relativeLocation.locationString eatChess:chess.relativeLocation.locationString])//预演吃子是否合法;
        {
            //吃子
            [self eatChess:_currentChess beEatedChess:chess];
        }
        else
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
#pragma --mark 判断某个棋盘某个位置是否有子
-(BOOL)isExistChessInCoordinateString:(NSString*)coordinateString inChessMap:(NSDictionary<NSString*,BaseChess*>*)map
{
    return [map objectForKey:coordinateString]!=nil;
}


#pragma --mark 判断某个棋盘是否可以走子;
-(BOOL)chess:(BaseChess*)chess isCanLocationTo:(ChessLocationModel*)location withChessMap:(NSDictionary<NSString*,BaseChess*>*)map
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
                    if ([self isExistChessInCoordinateString:key inChessMap:map]) {
                        return NO;
                    }
                }
                return YES;
            }else
            {
                for (int row = MIN(chess.relativeLocation.row, location.row)+1; row<MAX(chess.relativeLocation.row, location.row); row++) {
                    NSString *key = [NSString stringWithFormat:@"(%d,%d)",row,location.column];
                    if ([self isExistChessInCoordinateString:key inChessMap:map]) {
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
                    if ([self isExistChessInCoordinateString:key inChessMap:map]) {
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
                    if ([self isExistChessInCoordinateString:key inChessMap:map]) {
                        coutBetweenToLocation++;
                    }
                }
                BaseChess *enamyChess = [map objectForKey:location.locationString];
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
            if ([self isExistChessInCoordinateString:key inChessMap:map]) {
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
                    return ![self isExistChessInCoordinateString:key inChessMap:map];
                }
                case 2://正左面.列减一;行不变
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row,chess.relativeLocation.column-1];
                    return ![self isExistChessInCoordinateString:key inChessMap:map];

                }
                case 3://正下方;行加1;列不变
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row+1,chess.relativeLocation.column];
                    return ![self isExistChessInCoordinateString:key inChessMap:map];

                }
                case 4://正右方;行不变,列加1
                {
                    key = [NSString stringWithFormat:@"(%d,%d)",chess.relativeLocation.row,chess.relativeLocation.column+1];
                    return ![self isExistChessInCoordinateString:key inChessMap:map];

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
#pragma  mark --棋谱生成
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

#pragma mark --模拟吃子
void  eat(BaseChess *eatChess,BaseChess *beEatedChess,NSMutableDictionary<NSString*,BaseChess*> *chessMap)
{
    //从map中移除即将吃子的子;
    [chessMap removeObjectForKey:eatChess.relativeLocation.locationString];
    //吃子的子位置更新到死亡子位置
    eatChess.relativeLocation = beEatedChess.relativeLocation;
    //更新map
    [chessMap setObject:eatChess forKey:eatChess.relativeLocation.locationString];
    
}
#pragma mark -- 模拟走子
void  moveChessToLocation(BaseChess *chess,ChessLocationModel*location ,NSMutableDictionary<NSString*,BaseChess*> *chessMap)
{
    
    [chessMap removeObjectForKey:chess.relativeLocation.locationString];//先移除旧位置;
    chess.relativeLocation  = location;
    [chessMap setObject:chess forKey:chess.relativeLocation.locationString];//放在新位置了
}

#pragma mark --在某棋盘内吃子
-(void)eatChess:(BaseChess*)eatChess beEatedChess:(BaseChess*)beEatedChess
{
    [self createChessText:_currentChess location:beEatedChess.relativeLocation];
    //吃子过程
    
    beEatedChess.isDeath = YES;//杀死目标棋子
    [beEatedChess.uiExhition removeFromSuperview];//从棋盘上移除

    
    [_chessMap removeObjectForKey:eatChess.relativeLocation.locationString];//移出map
//    //子落到位置
    _currentChess.relativeLocation = beEatedChess.relativeLocation;
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
}
#pragma mark --某棋盘内移动子
-(void)moveCurrentChesstoTargetLocation:(ChessLocationModel*)location{
    [self createChessText:_currentChess location:location];
    [_chessMap removeObjectForKey:_currentChess.relativeLocation.locationString];
    [_currentChess chess_move:location];
    [_chessMap setObject:_currentChess forKey:location.locationString];
    _currentChess.uiExhition.selected = NO;
    
    if (currentMoveCamp == campTypeRed) {
        currentMoveCamp = campTypeBlack;
    }else
    {
        currentMoveCamp = campTypeRed;
    }
    gameOrder++;
    _currentChess = nil;
    
}







/**
 *  预演某个点的子能否吃掉某个点的字
 *
 *  @param eatChessCoordinateString   要吃子的坐标
 *  @param eatedChessCoordinateString 要被吃掉的子的坐标
 *
 *  @return bool
 */
#pragma mark --预演吃子能否合法
-(BOOL)preEaeChess:(NSString*)eatChessCoordinateString eatChess:(NSString*)eatedChessCoordinateString
//能否吃子;
{
    //模拟一个棋盘的副本;多推演一步;
    BaseChess *eatChess = [_chessMapCopy objectForKey:eatChessCoordinateString];
    BaseChess *eatedChess = [_chessMapCopy objectForKey:eatedChessCoordinateString];
    
    if (![self chess:eatChess isCanLocationTo:eatedChess.relativeLocation withChessMap:_chessMapCopy])
    {
        return NO;
    }else if([self kingIsBeAttacking])//判断当前老将是否正在被将军
    {
        return NO;
        
    }else //模拟行棋后看看老将是否被将军;
    {
        //先模拟行棋
        eat([eatChess copy], [eatedChess copy], _chessMapCopy);
        BOOL isBeAttacking = [self kingIsBeAttacking];
        if (isBeAttacking)//不能预演通过,还原现场
        {
            [_chessMapCopy setObject:eatedChess forKey:eatedChess.relativeLocation.locationString];
            [_chessMapCopy setObject:eatChess forKey:eatChess.relativeLocation.locationString];
        }
        return !isBeAttacking;
    }
    
    return NO;
}
/**
 *  用于判断移动是否合法;也是用于预演后自己的老王会不会被将死
 *
 *  @return
 */
#pragma mark --预演移动能否合法
-(BOOL)preMoveChess:(NSString*)chessLocation moveToLocation:(ChessLocationModel*)targetLocation//能否移动;
{
    BaseChess *chess = [_chessMapCopy objectForKey:chessLocation];
    
    ChessLocationModel *originLocation = [chess.relativeLocation copy];//保留现场
    if (![self chess:chess isCanLocationTo:targetLocation withChessMap:_chessMapCopy]) {
        return NO;
    }else if([self kingIsBeAttacking])//判断当前老将是否正在被将军
    {
        return YES;
        
    }else //模拟行棋后看看老将是否被将军;
    {
        //先模拟行棋子
        moveChessToLocation(chess, targetLocation, _chessMapCopy);
        //此时chess的relativeLocation已经发生改变;
        if([self kingIsBeAttacking])//说明不能通过,还原现场
        {
            //还原现场
            [_chessMapCopy removeObjectForKey:chess.relativeLocation.locationString];//移除新位置
            chess.relativeLocation = originLocation;//还原
            [_chessMapCopy setObject:chess forKey:chess.relativeLocation.locationString];
            return NO;
        }else
        {
            return YES;
        }
        
        
    }
    return NO;
}
-(void)play
{
    
}
@end
