//
//  CBMViewController.m
//  BillManagement
//
//  Created by zhaozheng chu on 14/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import "CBMViewControllerEntry.h"

@interface CBMViewControllerEntry ()

@end

@implementation CBMViewControllerEntry

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
#if 0
    UITapGestureRecognizer *tapLoginImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLogInView)];
    tapLoginImage.numberOfTapsRequired = 1;
    tapLoginImage.numberOfTouchesRequired = 1;
    
    [self.ivShowLogIn addGestureRecognizer:tapLoginImage];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - unwind method
//Unwind
- (IBAction)backMainEntry:(UIStoryboardSegue *)segue
{
    
}
@end
