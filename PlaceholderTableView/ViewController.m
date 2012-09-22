//
//  ViewController.m
//  PlaceholderTableView
//
//  Created by Fábio Bernardo on 9/21/12.
//  Copyright (c) 2012 Fábio Bernardo. All rights reserved.
//

#import "ViewController.h"
#import "PlaceholderTableView.h"

@implementation ViewController {
    PlaceholderTableView *_tableView;
    NSMutableArray *cells;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Create the placeholder view
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text = @"Placeholder text";
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0, 1);
    [label sizeToFit];
    
    
    //Create the placeholder tableview
    _tableView = [[PlaceholderTableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.placeholderView = label;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //Position the placeholder
    label.frame = (CGRect) {
        .origin.x = roundf((CGRectGetWidth(_tableView.bounds) - CGRectGetWidth(label.frame)) / 2),
        .origin.y = roundf((CGRectGetHeight(_tableView.bounds) - CGRectGetHeight(label.frame)) / 2),
        .size = label.frame.size
    };
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCell:)];
    
    cells = [NSMutableArray array];
    
    //Add an example backgroundview to our tableview
    
    UIView *bgView = [[UIView alloc] initWithFrame:_tableView.bounds];
    bgView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    _tableView.backgroundView = bgView;

}

- (void)viewWillDisappear:(BOOL)animated {
    [_tableView removeFromSuperview];
    _tableView = nil;
    
    cells = nil;
}

- (void)addCell:(id)sender {
    [_tableView beginUpdates];
    [cells insertObject:@"hello" atIndex:0];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = nil;
    if ((cell = [tableView dequeueReusableCellWithIdentifier:identifier]) == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_tableView beginUpdates];
    [cells removeObjectAtIndex:(NSUInteger) indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
}

@end
