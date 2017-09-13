//
//  ViewController.m
//  KNHeadTensile
//
//  Created by 刘凡 on 2017/9/12.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ViewController.h"


#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


//表格
@property(nonatomic, strong)UITableView *tableView;

//可拉伸头部试图
@property(nonatomic, strong)UIImageView *headImageView;

@property(nonatomic, strong)UIView *TableheadView;

@property(nonatomic, assign)CGRect originalRect;

@end

static CGFloat ration = 0.6f;

static CGFloat headHeight = 230.f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.tableView];
 
    
}

#pragma 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}

#pragma mark -指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark - 设置总共的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset > 0) {
        
        self.headImageView.frame  = ({
            CGRect frame = _originalRect;
            frame.origin.y = _originalRect.origin.y - yOffset;
            frame;
        });
    }else{
        
        self.headImageView.frame = ({
            CGRect frame = _originalRect;
            frame.size.height = _originalRect.size.height - yOffset;
            frame.size.width = frame.size.height/ration;
            frame.origin.x = _originalRect.origin.x  - (frame.size.width - _originalRect.size.width)/2;
            frame;
        });
    }
}

#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}



-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, ration * kScreenWidth)];
        _headImageView.image = [UIImage imageNamed:@"headView"];
        self.originalRect = _headImageView.frame;
    }
    return _headImageView;
}

-(UIView *)TableheadView{
    if (!_TableheadView) {
        _TableheadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, headHeight)];
        _TableheadView.backgroundColor = [UIColor clearColor];
    }
    return _TableheadView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.TableheadView;
       
    }
    return _tableView;
}
@end
