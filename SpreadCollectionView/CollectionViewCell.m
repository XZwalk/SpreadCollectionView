//
//  CollectionViewCell.m
//  test
//
//  Created by 张祥 on 15/7/4.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIViewAdditions.h"

@interface CollectionViewCell ()

@property (nonatomic, retain) UIView *myView;
@property (nonatomic, retain) UIView *myView1;

@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLabel];
        
        //self.backgroundColor = [UIColor redColor];
        [self addAllViews];
        [self addPointingView];
    }
    
    return self;
    
}



- (void)addAllViews
{
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30)];
     self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom, self.frame.size.width, 30)];
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor greenColor];
    
    self.imgView.alpha = .95;
    
}


- (void)addPointingView
{
    
        self.myView = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 9, self.titleLabel.bottom - 4, 15, 15)];
        
        self.myView1 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2  + 0.5 - 9, self.titleLabel.bottom - 4, 13, 15)];
        
        //self.myView.backgroundColor = [UIColor darkGrayColor];
        
        
        self.myView.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.myView1.transform = CGAffineTransformMakeRotation(M_PI_4);
        
        self.myView1.backgroundColor = [UIColor colorWithRed:0.774 green:0.768 blue:0.931 alpha:1.000];
    
    

}


- (void)setIsHiddened:(BOOL)isHiddened
{
    _isHiddened = isHiddened;
    if (!_isHiddened) {
        [self addSubview:self.myView];
        [self addSubview:self.myView1];

    }else{
        
        
        [self.myView removeFromSuperview];
        [self.myView1 removeFromSuperview];

    }
}





@end
