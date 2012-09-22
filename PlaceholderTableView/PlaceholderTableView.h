//
//  PlaceholderTableView.h
//  PlaceholderTableView
//
//  Created by Fábio Bernardo on 9/21/12.
//  Copyright (c) 2012 Fábio Bernardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTableView : UITableView

@property (nonatomic, strong) UIView *placeholderView;

- (BOOL)shouldShowPlaceholder; //you can override this method to add custom logic

@end
