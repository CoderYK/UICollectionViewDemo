//
//  YKFlowLayout.m
//  01-UICollectionView基本使用
//
//  Created by yk on 16/4/22.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "YKFlowLayout.h"

/*
 自定义UICollectionView布局:了解5个方法
 
 - (void)prepareLayout;
 
 - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
 
 - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds; // return YES to cause the collection view to requery the layout for geometry information
 
 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity; // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior
 
 - (CGSize)collectionViewContentSize;
 
 */
#define YKScreenW [UIScreen mainScreen].bounds.size.width
@implementation YKFlowLayout

//设置 cell 布局
//返回一定范围内的 cell 的布局
//可以一次性返回全部的 cell
//返回的数组是 cell 的布局信息
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /*
     实现思路:在指定 rect 中,距离中心点越近的 cell 缩放比例越大,越远的,缩放比例越小
     实时距离  ->  缩放比例
     */
    NSArray *attrs = [super layoutAttributesForElementsInRect: self.collectionView.bounds];
    
    CGFloat distance;
    CGFloat scale;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
       
       distance = attr.center.x - (self.collectionView.contentOffset.x + YKScreenW * 0.5);
        
        scale = 1 - fabs(distance) / YKScreenW * 0.5;
        
//        NSLog(@"%f",scale);
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrs;
}


//作用:决定UICollectionView最终偏移量
//什么时候调用:只要当用户停止拖动时才调用
//可以在这个方法中定位 cell
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //获得最终的显示区域
    CGRect targetR = CGRectMake(proposedContentOffset.x, 0, YKScreenW, MAXFLOAT);
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetR];
    
    //对距离中心点最近的 cell平移
    CGFloat minDistance = MAXFLOAT;
    CGFloat distance;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        distance = attr.center.x - (proposedContentOffset.x + YKScreenW * 0.5);
        if (fabs(distance) < fabs(minDistance)) {
            minDistance = distance;
        }
    }

    proposedContentOffset.x += minDistance;
    
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    
    //NSLog(@"%f",proposedContentOffset.x);
    
    /*
        快速拖动: 最终偏移量 != 手指离开时的偏移量
     */
   // NSLog(@"%@ %@",NSStringFromCGPoint(proposedContentOffset),NSStringFromCGPoint(self.collectionView.contentOffset));
    
    return proposedContentOffset;
}


//Invalidate:刷新
//是否允许刷新布局,当内容改变的时候
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
