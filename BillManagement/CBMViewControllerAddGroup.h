//
//  CBMViewControllerAddGroup.h
//  BillManagement
//
//  Created by zhaozheng chu on 15/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBMDataModelGroupMember.h"

@interface CBMViewControllerAddGroup : UITableViewController
@property (retain, nonatomic) CBMDataModelGroupMember *dataModelGroupMember;
@property (weak, nonatomic) IBOutlet UITextField *tfGroupName;
- (IBAction)btSaveGroupMember:(id)sender;

@end
