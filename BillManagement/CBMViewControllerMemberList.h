//
//  CBMViewControllerMemberList.h
//  BillManagement
//
//  Created by zhaozheng on 13-12-30.
//  Copyright (c) 2013年 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBMViewControllerMemberList : UITableViewController

//Get from server, include section info and bill info
@property (retain) NSMutableArray *arrayBillList;

@end
