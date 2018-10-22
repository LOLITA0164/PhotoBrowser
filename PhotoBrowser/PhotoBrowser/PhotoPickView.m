//
//  PhotoPickView.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/10/22.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "PhotoPickView.h"
@interface PhotoPickView ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (strong ,nonatomic) UITableView *table;
@property (strong ,nonatomic) NSArray<PhotoPickItem *> *options;

@property (assign ,nonatomic) CGFloat fontSize;
@property (assign ,nonatomic) CGFloat cellHeight;
@property (assign ,nonatomic) CGFloat footerHeight;
@property (assign ,nonatomic) CGFloat tableHeight;

@end

@implementation PhotoPickView

+(void)showOnView:(UIView*)baseView Options:(NSArray<PhotoPickItem *> *)ops{
    if (ops.count==0) {
        return;
    }
    PhotoPickView* pickView = [[PhotoPickView alloc] initWithFrame:baseView.bounds];
    pickView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
    pickView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        pickView.alpha = 1;
    }];
    [baseView addSubview:pickView];
    
    pickView.options = ops;

    [pickView addSubview:pickView.table];
    
    [pickView showOrHiddenTable];
}



#pragma mark - <************************** 初始化 **************************>
-(UITableView *)table{
    if (_table==nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        _table.showsVerticalScrollIndicator = NO;
        _table.showsHorizontalScrollIndicator = NO;
        _table.delegate = self;
        _table.dataSource = self;
        _table.bounces = NO;
        _table.tableFooterView = UIView.new;
        _table.backgroundColor = UIColor.clearColor;
    }
    return _table;
}
-(CGFloat)fontSize{
    return 17;
}
-(CGFloat)cellHeight{
    return 50;
}
-(CGFloat)footerHeight{
    return 60;
}
-(CGFloat)tableHeight{
    CGFloat height = self.options.count * 50 + self.footerHeight;
    self.table.bounces = height>self.bounds.size.height;
    height = MIN(height, self.bounds.size.height);
    return height;
}

#pragma mark - <************************** 代理 **************************>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.options.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"itemCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:self.fontSize];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    PhotoPickItem* option = self.options[indexPath.row];
    cell.textLabel.text = option.title.length?option.title:@"";
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.footerHeight)];
    bgView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    UILabel* cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width, self.footerHeight - 10)];
    cancelLabel.text = @"取消";
    cancelLabel.textColor = UIColor.redColor;
    cancelLabel.font = [UIFont systemFontOfSize:17];
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.backgroundColor = UIColor.whiteColor;
    [bgView addSubview:cancelLabel];
    UIControl* control = [[UIControl alloc] initWithFrame:bgView.bounds];
    [control addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:control];
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.footerHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    PhotoPickItem* option = self.options[indexPath.row];
    if (option.picked) {
        option.picked();
    }
    [self showOrHiddenTable];
}


#pragma mark - <************************** 私有 **************************>
-(void)cancelAction{
    [self showOrHiddenTable];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self showOrHiddenTable];
}

-(void)showOrHiddenTable{
    if (CGAffineTransformIsIdentity(self.table.transform)) {
        [UIView animateWithDuration:0.25 animations:^{
            self.table.transform = CGAffineTransformTranslate(self.table.transform, 0, -self.tableHeight);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.table.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.alpha = 0;
            }];
            // 从父视图上移除，以主动断开强引用。
            [self removeFromSuperview];
        }];
    }
}


//-(void)dealloc{
//    NSLog(@"%@释放了。",self.class);
//}

@end









#pragma mark - <************************** 选项 **************************>
@implementation PhotoPickItem
+(PhotoPickItem *)itemWithTitle:(NSString *)title picked:(pickBlock)picked{
    PhotoPickItem* item = PhotoPickItem.new;
    item.title = title;
    item.picked = picked;
    return item;
}
//-(void)dealloc{
//    NSLog(@"%@释放了。",self.class);
//}
@end
