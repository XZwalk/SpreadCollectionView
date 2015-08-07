//
//  CollectionViewCell.h
//  test
//
//  Created by 张祥 on 15/7/4.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, assign) BOOL isHiddened;

@end
