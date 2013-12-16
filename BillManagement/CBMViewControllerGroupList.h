//
//  CBMViewControllerGroupList.h
//  BillManagement
//
//  Created by zhaozheng chu on 14/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBMDataModelGroupMember.h"
@interface CBMViewControllerGroupList : UITableViewController

@property (retain, nonatomic) NSMutableArray *arryGroupList;

- (IBAction)backGroupList:(UIStoryboardSegue *)segue;
@end
