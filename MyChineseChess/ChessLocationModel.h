//
//  ChessLocationModel.h
//  MyChineseChess
//
//  Created by laomi on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChessLocationModel : NSObject

@property(nonatomic,copy)NSString* locationString;//拼接好的key
@property(nonatomic,assign)int row;//棋盘中的行
@property(nonatomic,assign)int column;//棋盘中的列）//是相对位置
@property(nonatomic,assign)CGPoint absolutPoint;//棋盘绝对位置
-(instancetype)initWithRow:(int)row colum:(int)column absoluteLocation:(CGPoint)absolutPosition;
@end
