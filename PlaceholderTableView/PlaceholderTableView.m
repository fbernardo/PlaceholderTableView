//
//  PlaceholderTableView.m
//  PlaceholderTableView
//
//  Created by Fábio Bernardo on 9/21/12.
//  Copyright (c) 2012 Fábio Bernardo. All rights reserved.
//

#import "PlaceholderTableView.h"

@interface PlaceholderTableView ()
@property (assign) UIView *aBackgroundView;
@end

@implementation PlaceholderTableView {
    UITableViewCellSeparatorStyle _previousSeparatorStyle;
}
@synthesize placeholderView = _placeholderView;

#pragma mark - Properties

- (void)setPlaceholderView:(UIView *)placeholderView {
    if (_placeholderView != placeholderView) {        
        [_placeholderView removeFromSuperview];
        
        _placeholderView = placeholderView;
        
        if (_placeholderView && [self shouldShowPlaceholder]) {
            [self addPlaceholder:NO];
        }
    }
}

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgView.backgroundColor = self.backgroundColor;
    
    super.backgroundView = bgView;
}

#pragma mark - UITableView

- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView != self.aBackgroundView) {
        [self.aBackgroundView removeFromSuperview];
        
        UIView *superBackgroundView = super.backgroundView;
        
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        backgroundView.frame = superBackgroundView.bounds;
        
        [superBackgroundView addSubview:backgroundView];
        [superBackgroundView sendSubviewToBack:backgroundView];
        
        self.aBackgroundView = backgroundView;        
    }
}

- (UIView *)backgroundView {
    return self.aBackgroundView;
}

- (void)reloadData {
    [super reloadData];
    
    if ([self shouldShowPlaceholder]) {
        [self addPlaceholder:NO];
    } else {
        [self removePlaceholder:NO];
    }
}

- (void)endUpdates {
    [super endUpdates];
    
    if ([self shouldShowPlaceholder]) {
        [self addPlaceholder:YES];
    } else {
        [self removePlaceholder:YES];
    }
}

#pragma mark - Public Methods

- (BOOL)shouldShowPlaceholder {
    NSInteger sections = [self numberOfSections];
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger rows = [self numberOfRowsInSection:i];
        if (rows > 0) return NO;
    }
    return YES;
}

#pragma mark - Private Methods

- (void)addPlaceholder:(BOOL)animated {
    if (!self.placeholderView || self.placeholderView.superview) return;

    _previousSeparatorStyle = self.separatorStyle;
    self.placeholderView.alpha = 0;
    [super.backgroundView addSubview:self.placeholderView];
    [super.backgroundView bringSubviewToFront:self.placeholderView];

    if (animated) {
        [UIView beginAnimations:@"fade in the placeholder" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.1];
    }
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.placeholderView.alpha = 1;
    if (animated) {
        [UIView commitAnimations];
    }
}

- (void)removePlaceholder:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(){
            self.placeholderView.alpha = 0;
            self.separatorStyle = _previousSeparatorStyle;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.placeholderView removeFromSuperview];
            }
        }];
    } else {
        self.separatorStyle = _previousSeparatorStyle;
        [self.placeholderView removeFromSuperview];
    }
}

@end
