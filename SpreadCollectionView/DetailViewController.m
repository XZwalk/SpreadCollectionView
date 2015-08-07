//
//  SecondViewController.m
//  SpreadCollectionView
//
//  Created by 张祥 on 15/7/24.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "DetailModel.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.minView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.minView];
    self.minView.delegate = self;
    self.minView.dataSource = self;
    self.minView.backgroundColor = [UIColor whiteColor];
    
    [self.minView  registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataAry.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    DetailModel *detail = self.dataAry[indexPath.row];
    cell.titleLabel.text = detail.name;
    return cell;
}




#pragma mark - UICollectionViewDelegate 选中执行

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //选中执行的方法
    
    
    
    
}





#pragma mark - UICollectionViewDelegateFlowLayout - 动态布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth  / kDetail_Item_Number - 0.5, kItem_Height);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

@end
