//
//  CBMViewController.h
//  BillManagement
//
//  Created by zhaozheng chu on 14/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBlurIntroductionView.h"

@interface CBMViewControllerEntry : UIViewController <MYIntroductionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ivShowLogIn;
@property (weak, nonatomic) IBOutlet UIImageView *ivShowOffLineTask;

//Unwind 
- (IBAction)backMainEntry:(UIStoryboardSegue *)segue;
@end
