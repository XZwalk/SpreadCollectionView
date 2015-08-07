//
//  SecondViewController.h
//  SpreadCollectionView
//
//  Created by 张祥 on 15/7/24.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSMutableArray *dataAry;
@property (nonatomic, retain)UICollectionView *minView;

@end
