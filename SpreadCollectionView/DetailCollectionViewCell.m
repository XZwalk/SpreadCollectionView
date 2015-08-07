//
//  NBCollectionViewCell.m
//  Lesson_collectionView
//
//  Created by 张祥 on 15/7/1.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell





- (id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.titleLabel];

        self.backgroundColor = [UIColor colorWithRed:0.774 green:0.768 blue:0.931 alpha:1.000];
    }

    return self;
    
}


- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}


@end
