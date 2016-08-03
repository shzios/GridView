//
//  ItemView.h
//  拖拽移动排序
//
//  Created by 申克 on 16/3/30.
//  Copyright © 2016年 lixiya. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ItemView : UIView
@property (nonatomic,strong)UILabel * label;
@property (nonatomic,assign)NSInteger * index;
@property (nonatomic,strong)NSString * markButton;
@property (nonatomic,assign)int itemID;
@property (nonatomic,strong)UIImageView * imageView;
-(instancetype)initWithFrame:(CGRect)frame Image:(NSString *)image Title:(NSString *)title atIndex:(int)atIndex;
@end
