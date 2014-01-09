//
//  CBMNormalSectionHeaderView.h
//  BillManagement
//
//  Created by zhaozheng on 14-1-8.
//  Copyright (c) 2014年 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBMNormalSectionHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbRightDetail;


@property (nonatomic) NSInteger intSection;
@end
