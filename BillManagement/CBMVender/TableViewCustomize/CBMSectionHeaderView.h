//
//  CBMSectionHeaderView.h
//  BillManagement
//
//  Created by zhaozheng chu on 15/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SectionHeaderViewDelegate;

@interface CBMSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *disclosureButton;
@property (nonatomic, weak) IBOutlet id <SectionHeaderViewDelegate> delegate;

@property (nonatomic) NSInteger section;

- (void)toggleOpenWithUserAction:(BOOL)userAction;

@end

#pragma mark -

/*
 Protocol to be adopted by the section header's delegate; the section header tells its delegate when the section should be opened and closed.
 */
@protocol SectionHeaderViewDelegate <NSObject>

@optional
- (void)sectionHeaderView:(CBMSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
- (void)sectionHeaderView:(CBMSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;

@end

