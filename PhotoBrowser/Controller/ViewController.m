//
//  ViewController.m
//  PhotoBrowser
//
//  Created by LOLITA on 2017/9/5.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import "ViewController.h"
#import "NormalViewViewController.h"
#import "ListViewController.h"
#import "FlowViewViewController.h"

#import "TESTDATA.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) UITableView *table;
@property (strong ,nonatomic) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.table];
}


-(UITableView *)table{
    if (_table==nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = [UIView new];
    }
    return _table;
}


-(NSArray *)data{
    if (_data==nil) {
        _data = @[
                  @[@"普通的图片",[NormalViewViewController class]],
                  @[@"列表cell里的图片",[ListViewController class]],
                  @[@"瀑布流里的图片",[FlowViewViewController class]]
                  ];
    }
    return _data;
}


// !!!: 列表的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"LOLITA";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray *items = self.data[indexPath.row];
    NSString *title = items.firstObject;
    cell.textLabel.text = title;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *items = self.data[indexPath.row];
    NSString *title = items.firstObject;
    Class class = items.lastObject;
    UIViewController *ctrl = [class new];
    ctrl.title = title;
    [self.navigationController pushViewController:ctrl animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
