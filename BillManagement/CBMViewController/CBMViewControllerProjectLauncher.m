//
//  CBMViewControllerProjectLauncher.m
//  BillManagement
//
//  Created by zhaozheng on 13-12-30.
//  Copyright (c) 2013年 zhaozheng chu. All rights reserved.
//

#import "CBMViewControllerProjectLauncher.h"
#import "MyLauncherItem.h"
#import "CustomBadge.h"
#import "CBMDataModel.h"

@interface MyLauncherView (AddNewItemCategory)
-(void)launcherViewAddNewItem:(MyLauncherItem*)item;
@end

@implementation MyLauncherView (AddNewItemCategory)

-(void)launcherViewAddNewItem:(MyLauncherItem*)newItem
{
    BOOL isFlag = NO;
    
    //Add to exist page
    for (NSMutableArray* page in self.pages) {
        if ([page count] < [self maxItemsPerPage]) {
            [page addObject:newItem];
            isFlag = YES;
            break;
        }
    }
    
    if (isFlag != YES) {
        //Add the new page
        if ([self.pages count] < [self maxPages]) {
            NSMutableArray* page = [NSMutableArray arrayWithObject:newItem];
            [self.pages addObject:page];
        }
    }
    

	CGFloat pageWidth = self.pagesScrollView.frame.size.width;
    
	for (NSMutableArray *page in self.pages)
	{
        CGFloat x = minX;
        CGFloat y = minY;
		int itemsCount = 1;
		for (MyLauncherItem *item in page)
		{

			if (newItem == item) 
			{
				item.frame = CGRectMake(x, y, itemWidth, itemHeight);
				item.delegate = self;
				[item layoutItem];
				[item addTarget:self action:@selector(itemTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
				[item addTarget:self action:@selector(itemTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
				[item addTarget:self action:@selector(itemTouchedDown:) forControlEvents:UIControlEventTouchDown];
                [item addTarget:self action:@selector(itemTouchCancelled:) forControlEvents:UIControlEventTouchCancel];
				[self.pagesScrollView addSubview:item];
                item.closeButton.hidden = editing ? NO : YES;
			}

			x += itemWidth + paddingX;
			
			if ( itemsCount % columnCount == 0)
			{
				y += itemHeight + paddingY;
				x = minX;
			}
			
			itemsCount++;
		}
		
		minX += pageWidth;
	}
	
	self.pageControl.numberOfPages = self.pages.count;
	self.pagesScrollView.contentSize = CGSizeMake(self.pagesScrollView.frame.size.width * self.pages.count,
                                                  rowCount * itemHeight);
    
}
@end

@interface CBMViewControllerProjectLauncher ()

@property (retain, nonatomic)NSMutableArray* arrayPages;

@end

@implementation CBMViewControllerProjectLauncher
-(void)loadView
{
	[super loadView];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                target:self action:@selector(endEditing)] animated:YES];
    self.title = @"My project";
    
    [[self appControllers] setObject:[NSNumber numberWithInteger:0] forKey:@"ItemViewController"];
    
    //Add your view controllers here to be picked up by the launcher; remember to import them above
	//[[self appControllers] setObject:[MyCustomViewController class] forKey:@"MyCustomViewController"];
	//[[self appControllers] setObject:[MyOtherCustomViewController class] forKey:@"MyOtherCustomViewController"];

    
	if(![self hasSavedLauncherItems])
	{
        self.arrayPages = [NSMutableArray arrayWithObjects:
                           [NSMutableArray arrayWithObjects:
                            [[MyLauncherItem alloc] initWithTitle:@"Item 1"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 1 View"
                                                        deletable:NO],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 2"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 2 View"
                                                        deletable:NO],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 3"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 3 View"
                                                        deletable:YES],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 4"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 4 View"
                                                        deletable:NO],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 5"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 5 View"
                                                        deletable:YES],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 6"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 6 View"
                                                        deletable:NO],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 7"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 7 View"
                                                        deletable:NO],
                            nil],
                           [NSMutableArray arrayWithObjects:
                            [[MyLauncherItem alloc] initWithTitle:@"Item 8"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 8 View"
                                                        deletable:NO],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 9"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 9 View"
                                                        deletable:YES],
                            [[MyLauncherItem alloc] initWithTitle:@"Item 10"
                                                      iPhoneImage:@"itemImage"
                                                        iPadImage:@"itemImage-iPad"
                                                           target:@"ItemViewController"
                                                      targetTitle:@"Item 10 View"
                                                        deletable:NO],
                            nil],
                           nil];
        
		[self.launcherView setPages:self.arrayPages numberOfImmovableItems:1];
        
        // Set number of immovable items below; only set it when you are setting the pages as the
        // user may still be able to delete these items and setting this then will cause movable
        // items to become immovable.
        // [self.launcherView setNumberOfImmovableItems:1];
        
        // Or uncomment the line below to disable editing (moving/deleting) completely!
        // [self.launcherView setEditingAllowed:NO];
	}
    
    // Set badge text for a MyLauncherItem using it's setBadgeText: method
    [(MyLauncherItem *)[[[self.launcherView pages] objectAtIndex:0] objectAtIndex:0] setBadgeText:@"4"];
    
    // Alternatively, you can import CustomBadge.h as above and setCustomBadge: as below.
    // This will allow you to change colors, set scale, and remove the shine and/or frame.
    [(MyLauncherItem *)[[[self.launcherView pages] objectAtIndex:0] objectAtIndex:1] setCustomBadge:[CustomBadge customBadgeWithString:@"2" withStringColor:[UIColor blackColor] withInsetColor:[UIColor whiteColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor blackColor] withScale:0.8 withShining:NO]];
}

#pragma mark - MyLauncherItem management

-(void)launcherViewDidBeginEditing:(id)sender {
    [self.navigationItem setRightBarButtonItem:nil];
    [super launcherViewDidBeginEditing:sender];
}
-(void)launcherViewDidEndEditing:(id)sender {
    [super launcherViewDidEndEditing:sender];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                target:self action:@selector(endEditing)] animated:YES];
}

- (void)endEditing
{
    [self performSegueWithIdentifier:@"SegueProjectListToChildAdd" sender:self];
}

-(void)launcherViewItemSelected:(MyLauncherItem*)item {
    if (![self appControllers]) {
        return;
    }
    NSNumber* targetID = [[self appControllers] objectForKey:[item controllerStr]];
	
    
    [self performSegueWithIdentifier:@"SegueProjectTab" sender:self];
     
}

#pragma mark - unwind
- (IBAction)backProjectList:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:@"UnwindSegueCancelToProjectList"] == YES) {
        
    }
    else if ([segue.identifier isEqualToString:@"UnwindSegueChildAddToProjectList"] == YES)
    {
        CBMDataModelGroupMember* groupMember = (CBMDataModelGroupMember*)[segue.sourceViewController valueForKey:@"dataModelGroupMember"];
        
        //Generate the new item
        MyLauncherItem* newItem = [[MyLauncherItem alloc] initWithTitle:groupMember.sGroupName
                                                            iPhoneImage:@"itemImage"
                                                              iPadImage:@"itemImage-iPad"
                                                                 target:@"ItemViewController"
                                                            targetTitle:@"Item 10 View"
                                                              deletable:YES];

        [self.launcherView launcherViewAddNewItem:newItem];
    }
    
}

@end
