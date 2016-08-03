//
//  ItemView.m
//  拖拽移动排序
//
//  Created by 申克 on 16/3/30.
//  Copyright © 2016年 lixiya. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame Image:(NSString *)image Title:(NSString *)title atIndex:(int)atIndex{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-50)/2, 0, 50, 50)];
        self.imageView.image = [UIImage imageNamed:image];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height-25,frame.size.width, 25)];
        self.label.text = title;
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        self.itemID = atIndex;
    }
    return self;
}


@end
