//
//  RootViewController.m
//  Lesson_collectionView
//
//  Created by 张祥 on 15/7/1.
//  Copyright (c) 2015年 张祥. All rights reserved.
//




#import "RootViewController.h"
#import "FooterView.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
#import "UIViewAdditions.h"
#import "MainModel.h"
#import "DetailModel.h"
#import "UIImageView+WebCache.h"


@interface RootViewController ()

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *indexPathAry;
@property (nonatomic, retain) NSMutableArray *sectionAry;
@property (nonatomic, retain) NSMutableArray *listAry;
@property (nonatomic, retain) NSMutableArray *detailAry;
@property (nonatomic, retain) DetailViewController *secondVC;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, retain) NSIndexPath *index;
@property (nonatomic, retain) NSMutableIndexSet *indexSet;

@end


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50) collectionViewLayout:layout];
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self getDataFromServe];
    
    [self.collectionView  registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [self.collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    self.secondVC = [DetailViewController new];
    [self addChildViewController:self.secondVC];
    
}



#pragma mark - 懒加载

- (NSMutableArray *)indexPathAry
{
    if (!_indexPathAry) {
        self.indexPathAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _indexPathAry;
}

- (NSMutableArray *)sectionAry
{
    
    if (!_sectionAry) {
        self.sectionAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _sectionAry;
}

- (NSMutableArray *)listAry
{
    if (!_listAry) {
        self.listAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _listAry;
}


- (NSMutableArray *)detailAry
{
    if (!_detailAry) {
        self.detailAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _detailAry;
}

- (NSMutableIndexSet *)indexSet
{
    if (!_indexSet) {
        self.indexSet = [NSMutableIndexSet indexSet];
    }
    
    return _indexSet;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (self.listAry.count > 0) {
        
        if (section == self.listAry.count / kItem_Number) {
            
            if (self.listAry.count % kItem_Number == 0) {
                return kItem_Number;
            }
            return self.listAry.count % kItem_Number;
        }
        
        return kItem_Number;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.listAry.count % kItem_Number == 0) {
        return self.listAry.count / kItem_Number;
    }
    return self.listAry.count / kItem_Number + 1;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.isHiddened = YES;
    
    
    if (indexPath == self.index)
    {
        if (self.isSelected) {
            cell.isHiddened = NO;
        }
    }
    
    
        if (self.listAry.count > 0) {
            
            MainModel *main = self.listAry[indexPath.row + indexPath.section * kItem_Number];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:main.imagePath]];
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%@", main.name];
        }

   
    return cell;
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    [footerView addSubview:self.secondVC.view];
    
    footerView.clipsToBounds = YES;
    
    return footerView;
}






#pragma mark - GetData

- (void)getDataFromServe
{
    
    NSString *urlStr = @"http://121.41.88.194:80/HandheldKitchen/api/home/tblAssort!getFirstgrade.do";
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
        
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSArray *dataAry = dic[@"data"];
            
            
            for (NSDictionary *dic1 in dataAry) {
                
                MainModel *main = [[MainModel alloc] init];
                
                [main setValuesForKeysWithDictionary:dic1];
                
                
                [self.listAry addObject:main];
                
            }
            
        }
        
        [self.collectionView reloadData];

        
    }];
   
}







#pragma mark - UICollectionViewDelegate 选中执行

- (void)JudgeSelected:(NSIndexPath *)indexPath
{
    
    if (self.sectionAry.count > 1)
    {
        [self.sectionAry removeObjectAtIndex:0];
    }
    
    if ([self.sectionAry containsObject:indexPath])
    {
        self.isSelected = NO;
        [self.sectionAry removeObject:indexPath];
    }else{
        self.isSelected = YES;
        [self.sectionAry addObject:indexPath];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath;
    [self JudgeSelected:indexPath];
    [self.indexSet addIndex:indexPath.section];
    [self.detailAry removeAllObjects];
    MainModel *main = self.listAry[indexPath.row + indexPath.section * kItem_Number];
    for (NSDictionary *dic in main.secondgrade) {
        DetailModel *detail = [[DetailModel alloc] init];
        [detail setValuesForKeysWithDictionary:dic];
        [self.detailAry addObject:detail];
    }
    
    self.secondVC.dataAry = self.detailAry;
    [self.collectionView reloadData];
    [self.secondVC.minView reloadData];
}



#pragma mark - UICollectionViewDelegateFlowLayout - 动态布局

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth  / kItem_Number - 0.5, 120);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
        return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (self.sectionAry.count == 0 || self.isSelected == NO) {
        [self.secondVC.view removeFromSuperview];
        return CGSizeMake(0, 0);
    }
    
    if (section == [[self.sectionAry lastObject] section]) {
        if (self.detailAry.count % kDetail_Item_Number == 0) {
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, (self.detailAry.count / kDetail_Item_Number) * kItem_Height);
        }else{
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, (self.detailAry.count / kDetail_Item_Number + 1) * kItem_Height);
        }
    }else{
        return CGSizeMake(0, 0);
    }
    
}


@end
