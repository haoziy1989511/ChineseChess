//
//  ChessLocationModel.m
//  MyChineseChess
//
//  Created by laomi on 16/4/13.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ChessLocationModel.h"

@implementation ChessLocationModel

-(instancetype)initWithRow:(int)row colum:(int)column absoluteLocation:(CGPoint)absolutPosition;
{
    self = [super init];
    if (self) {
        _row = row;
        _column = column;
        _absolutPoint = absolutPosition;
    }
    return self;
}
- (id)copyWithZone:(nullable NSZone *)zone;
{
    ChessLocationModel *model = [[ChessLocationModel allocWithZone:zone]initWithRow:self.row colum:self.column absoluteLocation:self.absolutPoint];
    return model;
}
-(instancetype)init
{
    assert(@"You Should Use initWithRow:(int)row colum:(int)column absoluteLocation:(CGPoint)absolutPosition init an instance");
    return nil;
}

-(NSString*)locationString
{
    return [NSString stringWithFormat:@"(%d,%d)",self.row,self.column];
}
@end
