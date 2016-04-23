//
//  YKPhotoCell.m
//  01-UICollectionView基本使用
//
//  Created by yk on 16/4/22.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "YKPhotoCell.h"

@interface YKPhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YKPhotoCell

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    _imageView.image = image;
}

@end
