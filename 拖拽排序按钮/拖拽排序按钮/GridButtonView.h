//
//  GridButtonView.h
//  聚金所
//
//  Created by 申克 on 16/7/25.
//  Copyright © 2016年 申克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"


#define  IphoneWidth [UIScreen mainScreen].bounds.size.width
#define  IphoneHight [UIScreen mainScreen].bounds.size.hight

@class GridButtonView;
@protocol GridButtonViewDelegate <NSObject>

-(void)itemClickWithMark:(NSString *)mark tag:(NSInteger )tag;

@end


@interface GridButtonView : UIView

@property(nonatomic,strong)ItemView * HZitemView;
@property (nonatomic,assign)id <GridButtonViewDelegate> delegate;
@property (nonatomic,strong)NSMutableArray * listArray;

-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titls Images:(NSArray *)images WidthButtonCont:(int)WidthCont HightButtonCont:(int)hightCont DefKey:(NSString *)defKey;


@end
