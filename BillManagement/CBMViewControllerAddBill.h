//
//  CBMViewControllerAddBill.h
//  BillManagement
//
//  Created by zhaozheng chu on 15/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBMDataModelBillMember.h"
@interface CBMViewControllerAddBill : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *tfBillName;

@property (retain) CBMDataModelBillMember *dataModelBillMember;
- (IBAction)btSaveBillMember:(id)sender;

@end
