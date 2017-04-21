//
//  KSSelectTitleView.h
//  Kosun
//
//  Created by zhaoke.hzk on 2017/4/21.
//  Copyright © 2017年 刘松坡. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KSSelectTitleView;

@protocol KSSelectTitleViewDelegate <NSObject>


-(void)selectTitleView:(KSSelectTitleView* )selectTitleView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger )toIndex;

@end

@interface KSSelectTitleView : UIScrollView

@property (nonatomic , strong)UIColor* selectedTitleColor;
@property (nonatomic , strong)UIColor* normalTitleColor;
@property (nonatomic , assign)NSInteger selectedIndex;

@property (nonatomic , weak)id<KSSelectTitleViewDelegate> selectViewdelegate;


-(void)updateTitles:(NSArray* )titleArr;

@end
