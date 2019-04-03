//
//  IGTestViewController.m
//  LearnNew
//
//  Created by jysd on 2018/12/24.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "IGTestViewController.h"
#import <IGListKit/IGListKit.h>

@interface IGTestViewController ()<IGListAdapterDelegate,IGListAdapterDataSource>

@property (nonatomic, strong)UICollectionView * myCollectionView;

@property (nonatomic, strong)IGListAdapter * adapter;

@property (nonatomic, strong)NSArray * dataArray;

@end

@implementation IGTestViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"1",@"2",@"3",@"4",@5];
    // Do any additional setup after loading the view.
}

- (void)creatCollectionView{
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewLayout alloc]init]];
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    IGListAdapterUpdater * updater = [[IGListAdapterUpdater alloc]init];
    _adapter = [[IGListAdapter alloc]initWithUpdater:updater viewController:self workingRangeSize:0];
    _adapter.collectionView = self.myCollectionView;
    _adapter.delegate = self;
    [self.view addSubview:self.myCollectionView];
}

#pragma mark - adapterDelegate and datasource
- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    UILabel *label=[UILabel new];
    label.text=@"没有数据";
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    IGListSectionController * vc = [[IGListSectionController alloc]init];
    return vc;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return  self.dataArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
