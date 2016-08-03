//
//  GridButtonView.m
//  聚金所
//
//  Created by 申克 on 16/7/25.
//  Copyright © 2016年 申克. All rights reserved.
//

#import "GridButtonView.h"
#import "ItemView.h"

@interface GridButtonView()

@property(nonatomic,assign)CGFloat buttonWidth;
@property(nonatomic,assign)CGFloat buttonHight;
@property(nonatomic,strong)ItemView * myItemView;

@property (nonatomic,strong)NSString * titleKey;


@property (nonatomic,assign)CGPoint valuePoint;
@property (nonatomic,assign)CGPoint nextPoint;

@property(nonatomic,strong)NSArray * myTitles;


@end

@implementation GridButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titls Images:(NSArray *)images WidthButtonCont:(int)WidthCont HightButtonCont:(int)hightCont DefKey:(NSString *)defKey{
    self = [super initWithFrame:frame];
    if (self) {
        _titleKey = defKey;
        _listArray = [NSMutableArray array];
        _myTitles = titls;
        _buttonWidth = frame.size.width/WidthCont;
        _buttonHight = 75;
        for (int i = 0; i<titls.count; i++) {
            _myItemView = [[ItemView alloc]initWithFrame:CGRectMake((_buttonWidth)*(i % WidthCont), 5+(i/WidthCont)*(_buttonHight), _buttonWidth, _buttonHight) Image:images[i] Title:titls[i] atIndex:i];
            _myItemView.tag = 100+i;
            _myItemView.markButton = [NSString stringWithFormat:@"%@",titls[i]];
            _myItemView.userInteractionEnabled = YES;
            [self addSubview:_myItemView];
            [_listArray addObject:_myItemView];
            // 长按手势
            UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            if (i != titls.count-1) {
                [_myItemView addGestureRecognizer:longPress];
            }
            
            UITapGestureRecognizer * tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemButtonClikc:)];
            [_myItemView addGestureRecognizer:tapPress];
        }
//        
//        CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, +_buttonHight * hightCont);
//        self.frame = newFrame;
    }
    return self;
}


-(void)itemButtonClikc:(UITapGestureRecognizer *)tap{
    ItemView * tapView  = (ItemView *)tap.view;
    NSLog(@"%@ === %ld",tapView.markButton,(long)tapView.tag);
   [self.delegate itemClickWithMark:tapView.markButton tag:tapView.tag];
}

//排序
-(void)longPress:(UIGestureRecognizer*)recognizer {
    ItemView *recognizerView = (ItemView *)recognizer.view;
    for (ItemView * item in self.subviews) {
        if (item!=recognizerView) {
            item.userInteractionEnabled = NO;
        }
    }
    // 长按视图在父视图中的位置（触摸点的位置）
    CGPoint recognizerPoint = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 开始的时候改变拖动view的外观（放大，改变颜色等）
        [UIView animateWithDuration:0.2 animations:^{
            recognizerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            recognizerView.alpha = 0.7;
        }];
        // 把拖动view放到最上层
        [self bringSubviewToFront:recognizerView];
        // valuePoint保存最新的移动位置
        _valuePoint = recognizerView.center;
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        // 更新pan.view的center
        recognizerView.center = recognizerPoint;
        for (ItemView * item in self.subviews) {
            if (CGRectContainsPoint(item.frame, recognizerView.center)&&item!=recognizerView)
            {
                // 开始位置
                NSInteger fromIndex = recognizerView.tag - 100;
                // 需要移动到的位置
                NSInteger toIndex = item.tag - 100;
                if (toIndex == _myTitles.count-1) {
                    return;
                }
                // 往后移动
                if ((toIndex-fromIndex)>0) {
                    // 从开始位置移动到结束位置
                    // 把移动view的下一个view移动到记录的view的位置(valuePoint)，并把下一view的位置记为新的nextPoint，并把view的tag值-1,依次类推
                    [UIView animateWithDuration:0.2 animations:^{
                        for (NSInteger i = fromIndex+1; i<=toIndex; i++) {
                            ItemView * nextBt = (ItemView*)[self viewWithTag:100+i];
                            _nextPoint = nextBt.center;
                            nextBt.center = _valuePoint;
                            _valuePoint = _nextPoint;
                            nextBt.tag--;
                            
                        }
                        recognizerView.tag = 100 + toIndex;
                    }];
                }else{
                    // 往前移动
                    // 从开始位置移动到结束位置
                    // 把移动view的上一个view移动到记录的view的位置(valuePoint)，并把上一view的位置记为新的nextPoint，并把view的tag值+1,依次类推
                    [UIView animateWithDuration:0.2 animations:^{
                        for (NSInteger i = fromIndex-1; i>=toIndex; i--) {
                            ItemView * nextBt = (ItemView*)[self viewWithTag:100+i];
                            _nextPoint = nextBt.center;
                            nextBt.center = _valuePoint;
                            _valuePoint = _nextPoint;
                            nextBt.tag++;
                        }
                        recognizerView.tag = 100 + toIndex;
                    }];
                }
            }
            
        }
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        // 恢复其他按钮的拖拽手势
        for (ItemView * item in self.subviews) {
            if (item!=recognizerView) {
                item.userInteractionEnabled = YES;
            }
        }
        // 结束时候恢复view的外观（放大，改变颜色等）
        [UIView animateWithDuration:0.2 animations:^{
            recognizerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            recognizerView.alpha = 1;
            recognizerView.center = _valuePoint;
            
        }];
        [self reloadSubViews];
    }
}
-(void)reloadSubViews{
    [_listArray removeAllObjects];
    NSMutableArray * array = (NSMutableArray *)self.subviews;
    [array sortUsingComparator:^NSComparisonResult(ItemView * obj1, ItemView * obj2) {
        return  obj1.tag > obj2.tag;
    }];
    for (NSInteger i = 0; i < array.count; i++) {
        ItemView *gridItem = array[i];
        [_listArray addObject:[NSString stringWithFormat:@"%@",gridItem.label.text]];
    }
    NSUserDefaults * useDef = [NSUserDefaults standardUserDefaults];
    [useDef setObject:_listArray forKey:_titleKey];
    [useDef synchronize];
}


@end
