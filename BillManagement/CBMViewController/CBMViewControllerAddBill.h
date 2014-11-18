//
//  CBMViewControllerAddBill.h
//  BillManagement
//
//  Created by zhaozheng chu on 15/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBMDataModelBillMember.h"
@interface CBMViewControllerAddBill : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate >
@property (weak, nonatomic) IBOutlet UITextField *tfBillName;
@property (retain) UIImagePickerController *imagePickerController;
@property (retain) CBMDataModelBillMember *dataModelBillMember;
- (IBAction)btSaveBillMember:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *ivBillImage;
- (IBAction)btCaptureImage:(id)sender;


@end
