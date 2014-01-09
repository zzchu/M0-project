//
//  CBMViewControllerActionlist.h
//  BillManagement
//
//  Created by zhaozheng chu on 22/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBMSectionHeaderView.h"

@interface CBMViewControllerActionlist : UITableViewController <SectionHeaderViewDelegate>

@property (retain) NSMutableArray *arrayBillList;

@end
