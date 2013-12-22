//
//  CBMViewControllerBillList.h
//  BillManagement
//
//  Created by zhaozheng chu on 14/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBMDataModelBillMember.h"
#import "CBMSectionHeaderView.h"
@interface CBMViewControllerBillList : UITableViewController <SectionHeaderViewDelegate>

//Get from server, include section info and bill info
@property (retain) NSMutableArray *arrayBillList;

//unwind segue
- (IBAction)backBillList:(UIStoryboardSegue *)segue;
@end
