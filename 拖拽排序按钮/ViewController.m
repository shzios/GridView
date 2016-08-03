//
//  ViewController.m
//  拖拽排序按钮
//
//  Created by 申克 on 16/8/2.
//  Copyright © 2016年 shanghz. All rights reserved.
//

#import "ViewController.h"
#import "GridButtonView.h"

#define  ScreenWidth [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<GridButtonViewDelegate>

@property (nonatomic,strong)NSMutableArray * titles;
@property (nonatomic,strong)NSMutableArray * images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults * useDef = [NSUserDefaults standardUserDefaults];
    NSArray * myTitles = [useDef arrayForKey:@"anywords"];
    NSDictionary * dict = [useDef dictionaryForKey:@"youwords"];
    if (myTitles != nil) {
        NSMutableArray * array = [NSMutableArray array];
        _titles = [NSMutableArray arrayWithArray:myTitles];
        for (int i; i< _titles.count; i++) {
            [array addObject:[dict objectForKey:myTitles[i]]];
        }
       _images = [NSMutableArray arrayWithArray:array];
    }else{
        _titles = [NSMutableArray arrayWithObjects:@"第一",@"第二",@"第三",@"第四",@"第五",@"第六",@"第七",@"第八", nil];
        _images = [NSMutableArray arrayWithObjects:@"btn_activity_h",@"btn_activity_h",@"btn_activity_h",@"btn_activity_h",@"btn_activity_h",@"btn_activity_h",@"btn_activity_h",@"btn_activity_h", nil];
        NSDictionary * titleDict = [NSMutableDictionary dictionaryWithObjects:_images forKeys:_titles];
        [useDef setObject:titleDict forKey:@"youwords"];
    }

    GridButtonView * gridView = [[GridButtonView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight) Titles:_titles Images:_images WidthButtonCont:4 HightButtonCont:2 DefKey:@"anywords"];
    [self.view addSubview:gridView];
    gridView.delegate = self;
}


-(void)itemClickWithMark:(NSString *)mark tag:(NSInteger)tag{
    if ([mark isEqualToString:@"第一"]) {
        NSLog(@"第一被点击了");
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
