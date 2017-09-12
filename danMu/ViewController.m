//
//  ViewController.m
//  danMu
//
//  Created by Shaoting Zhou on 2017/9/11.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"
@interface ViewController ()
@property (nonatomic,strong) BulletManager * manager;
@property (nonatomic,strong) UITextField * text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[BulletManager alloc]init];
    __weak typeof(self) weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView *view) {
        [weakSelf addBulletView:view];
    };
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UIButton * startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, width/3, 40)];
    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton * endBtn = [[UIButton alloc]initWithFrame:CGRectMake(width/3, 100, width/3, 40)];
    [endBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    
    UIButton * addDanmu = [[UIButton alloc]initWithFrame:CGRectMake(width * 2/3, 100, width/3, 40)];
    [addDanmu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addDanmu setTitle:@"增加" forState:UIControlStateNormal];
    [addDanmu addTarget:self action:@selector(addDanmuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addDanmu];
    
    self.text = [[UITextField alloc]initWithFrame:CGRectMake(0, 150, width, 40)];
    [self.text setBorderStyle:UITextBorderStyleLine];
    self.text.placeholder = @"增加一条弹幕";
    [self.view addSubview:self.text];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)startAction{
    [self.manager start];
}

-(void)endAction{
    [self.manager stop];
}

-(void)addDanmuAction{
    
    NSDictionary * dic =  @{@"userPhoto":@"https://ws1.sinaimg.cn/large/610dc034ly1fiz4ar9pq8j20u010xtbk.jpg",@"danmu":self.text.text};
    [self.manager createBulletView:dic trajectory:0];

}

-(void)addBulletView:(BulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 60, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
