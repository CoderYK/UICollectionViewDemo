//
//  ViewController.m
//  01-UICollectionView基本使用
//
//  Created by yk on 16/4/22.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ViewController.h"
#import "YKPhotoCell.h"
#import "YKFlowLayout.h"

/*
    UICollectionView基本使用
        1.创建时必须指定一种布局方式
        2.cell 必须通过注册方式获取
        3.cell中默认什么都没有,需自定义 cell
 */

#define YKScreenW [UIScreen mainScreen].bounds.size.width
static NSString * const ID = @"cell";

@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //布局方式
    UICollectionViewFlowLayout *flowLayout = ({
    
        flowLayout = [[YKFlowLayout alloc] init];
        
        //设置 cell 的大小
        flowLayout.itemSize = CGSizeMake(180, 180);
        
        //设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //设置间距
        flowLayout.minimumLineSpacing = 50;
        
        //设置默认的滚动范围
        flowLayout.sectionInset = UIEdgeInsetsMake(0, (YKScreenW - 180) * 0.5, 0, (YKScreenW - 180) * 0.5);
        
        flowLayout;

    });
    
    //创建collectionView
    UICollectionView *collectionView = ({
    
        collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor brownColor];
        collectionView.bounds = CGRectMake(0, 0, YKScreenW, 200);
        collectionView.center = self.view.center;
        [self.view addSubview:collectionView];
        
        //设置数据源代理
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册 cell
        //    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        [collectionView registerNib:[UINib nibWithNibName:@"YKPhotoCell" bundle:nil] forCellWithReuseIdentifier:ID];
        collectionView;
    });
}

#pragma mark -------------------
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //先从缓冲池中取
    YKPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
