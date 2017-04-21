//
//  KSSelectTitleView.m
//  Kosun
//
//  Created by zhaoke.hzk on 2017/4/21.
//  Copyright © 2017年 刘松坡. All rights reserved.
//

#import "KSSelectTitleView.h"
#import "UIView+Common.h"

@interface KSSelectTitleView ()

@property (nonatomic , strong)UIButton* lastBtn;
@property (nonatomic , strong)NSArray* titleBtnArr;

@property (nonatomic , strong)UIView* sliderView;

@end

@implementation KSSelectTitleView

@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize normalTitleColor = _normalTitleColor;
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.sliderView];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}



-(void)updateTitles:(NSArray* )titleArr{
    if (titleArr.count == 0) {
        return;
    }
    
    NSInteger count = titleArr.count;
    NSInteger currentIndex = 0;
    if (self.titleBtnArr&&self.titleBtnArr.count>0) {
        currentIndex = [self.titleBtnArr indexOfObject:self.lastBtn];
    }
    [self removeAllSubviews];
    NSMutableArray* btnArr = [NSMutableArray array];
    for (NSInteger index = 0; index<count; index++) {
        NSString* title = titleArr[index];
        CGFloat width = [self widthForText:title height:self.height];
        
        UIButton* tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.lastBtn.right, 0, width, self.height)];
        [tempBtn setTitle:title forState:UIControlStateNormal];
        [tempBtn addTarget:self action:@selector(onTapBtn:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        tempBtn.tag = index;
        [tempBtn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [self addSubview:tempBtn];
        [btnArr addObject:tempBtn];
        _lastBtn = tempBtn;
    }
    self.contentSize = CGSizeMake(_lastBtn.right, self.height);
    self.titleBtnArr = [btnArr copy];
    if (currentIndex>=self.titleBtnArr.count) {
        currentIndex = 0;
    }
    _lastBtn = self.titleBtnArr[currentIndex];
    [_lastBtn setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(_lastBtn.left, _lastBtn.bottom - 2, _lastBtn.width, 2);
    [self addSubview:self.sliderView];
}

-(void)onTapBtn:(id)sender{
    
    UIButton* btn = (UIButton* )sender;
    if (btn == self.lastBtn) {
        return;
    }
    
    if (btn.right - self.contentOffset.x>=self.width) {
        self.contentOffset = CGPointMake(btn.right - self.width, 0);
    }
    if (btn.left <= self.contentOffset.x) {
        self.contentOffset = CGPointMake(btn.left, 0);
    }
    
    
    NSInteger index  = btn.tag;
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.width = btn.width;
        self.sliderView.left = btn.left;
    }];
    
    NSInteger currentIndex = [self.titleBtnArr indexOfObject:self.lastBtn];
    [self.lastBtn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
    self.lastBtn = btn;
    [self.lastBtn setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
    if ([self.selectViewdelegate respondsToSelector:@selector(selectTitleView:fromIndex:toIndex:)]) {
        [self.selectViewdelegate selectTitleView:self fromIndex:currentIndex toIndex:index];
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    NSInteger count = self.titleBtnArr.count;
    if (selectedIndex>=count) {
        return;
    }
    UIButton* tempBtn = self.titleBtnArr[selectedIndex];
    [self onTapBtn:tempBtn];
    
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    [_lastBtn setTitleColor:selectedTitleColor forState:UIControlStateNormal];
    [self.sliderView setBackgroundColor:_selectedTitleColor];
    
}
-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    
    _normalTitleColor = normalTitleColor;
    __weak typeof(self) weakSelf = self;
    [self.titleBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* btn = (UIButton* )obj;
        if (obj != weakSelf.lastBtn) {
            [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
        }
    }];
}
-(UIColor *)selectedTitleColor{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor blackColor];
    }
    return _selectedTitleColor;
}
-(UIColor* )normalTitleColor{
    if (!_normalTitleColor) {
        
        _normalTitleColor = [UIColor grayColor];
    }
    return _normalTitleColor;
}

-(CGFloat )widthForText:(NSString* )text height:(CGFloat)height{
    
        CGFloat padding = 15;
        NSDictionary *fontAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CGSize fontSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:fontAttribute context:nil].size;
        return fontSize.width+padding;
}

-(UIView* )sliderView{
    if (!_sliderView) {
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 2)];
        _sliderView.backgroundColor = self.selectedTitleColor;
        
    }
    return _sliderView;
}

@end
