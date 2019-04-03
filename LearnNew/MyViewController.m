//
//  MyViewController.m
//  LearnNew
//
//  Created by jysd on 2018/12/24.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "MyViewController.h"
#import <Masonry.h>

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * myTableView;
@property (nonatomic, strong)UIImageView * headerView;
@property (nonatomic, strong)UIImageView * headImage;
@property (nonatomic, strong)UIView * tableHeader;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    [self changeNavigationTitle];
    // Do any additional setup after loading the view.
}

- (void)changeNavigationTitle{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 0, 0)];
    _headImage.layer.masksToBounds = YES;
    _headImage.backgroundColor = [UIColor orangeColor];
    _headImage.layer.cornerRadius = 20;
    self.navigationItem.titleView = _headImage;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - tableView delegate and datasouce
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     _tableHeader= [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    _tableHeader.backgroundColor = [UIColor cyanColor];
    if (!_headerView) {
        _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 40, 40)];
        _headerView.layer.masksToBounds = YES;
        _headerView.layer.cornerRadius = 20;
        _headerView.backgroundColor = [UIColor orangeColor];
    }
    [_tableHeader addSubview:_headerView];
    return _tableHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"我来了%f",scrollView.contentOffset.y);
    
    __weak typeof(self)weakSelf = self;
    
    if (scrollView.contentOffset.y >= -40 ) {
        [UIView animateWithDuration:.5 animations:^{
            weakSelf.headImage.frame = CGRectMake(0, 0, 40, 40);
            weakSelf.headerView.frame = CGRectMake(50, 50, 0, 0);
        }];
    }

    if (scrollView.contentOffset.y < -40) {
        [UIView animateWithDuration:.5 animations:^{
            weakSelf.headImage.frame = CGRectMake(20, 20, 0, 0);
            weakSelf.headerView.frame = CGRectMake(30, 30, 40, 40);
        }];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y >= -40 && scrollView.contentOffset.y <= 12) {
        [UIView animateWithDuration:.5 animations:^{
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 12);
        }];
        
    }
    
    if (scrollView.contentOffset.y < -40) {
        [UIView animateWithDuration:.5 animations:^{
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -88);
        }];
    }
}

#pragma mark - lazy load
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
       
    }
    return _myTableView;
}



@end
