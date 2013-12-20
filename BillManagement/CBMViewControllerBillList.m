//
//  CBMViewControllerBillList.m
//  BillManagement
//
//  Created by zhaozheng chu on 14/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import "CBMViewControllerBillList.h"
#import "CBMBillListSectionInfo.h"
static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@interface CBMViewControllerBillList ()

@property (nonatomic) NSMutableArray *sectionInfoArray;
@property (nonatomic) NSIndexPath *pinchedIndexPath;
@property (nonatomic) NSInteger openSectionIndex;
@property (nonatomic) CGFloat initialPinchHeight;
@property (nonatomic) IBOutlet CBMSectionHeaderView *sectionHeaderView;

// use the uniformRowHeight property if the pinch gesture should change all row heights simultaneously
@property (nonatomic) NSInteger uniformRowHeight;

@end

#define DEFAULT_ROW_HEIGHT 88
#define HEADER_HEIGHT 48

@implementation CBMViewControllerBillList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Set up the default values
    self.tableView.sectionHeaderHeight = HEADER_HEIGHT;
    self.uniformRowHeight = DEFAULT_ROW_HEIGHT;
    self.openSectionIndex = NSNotFound;
    
    UINib *sectionHeaderNib = [UINib nibWithNibName:@"SectionHeaderView" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:SectionHeaderViewIdentifier];
    //selectedBillRow = NSNotFound;
    [self initSectionInfoArray];

    //self.arryBillList = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sectionInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	CBMBillListSectionInfo *sectionInfo = (self.sectionInfoArray)[section];
	NSInteger numStoriesInSection = [sectionInfo.billArray count];
    
    return sectionInfo.open ? numStoriesInSection : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BillListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    CBMDataModelBillMember *bill = (CBMDataModelBillMember *)[[(self.sectionInfoArray)[indexPath.section] billArray] objectAtIndex:indexPath.row];
    cell.textLabel.text = bill.sBillName;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CBMSectionHeaderView *sectionHeaderView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    
    CBMBillListSectionInfo *sectionInfo = (self.sectionInfoArray)[section];
    sectionInfo.headerView = sectionHeaderView;
    
    sectionHeaderView.titleLabel.text = sectionInfo.sSectionName;
    sectionHeaderView.section = section;
    sectionHeaderView.delegate = self;
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	CBMBillListSectionInfo *sectionInfo = (self.sectionInfoArray)[indexPath.section];
    return [[sectionInfo objectInRowHeightsAtIndex:indexPath.row] floatValue];
    // Alternatively, return rowHeight.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
}

#pragma mark - SectionHeaderViewDelegate

- (void)sectionHeaderView:(CBMSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
    
	CBMBillListSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionOpened];
    
	sectionInfo.open = YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [sectionInfo.billArray count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
        
		CBMBillListSectionInfo *previousOpenSection = (self.sectionInfoArray)[previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.billArray count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // style the animation so that there's a smooth flow in either direction
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // apply the updates
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    
    self.openSectionIndex = sectionOpened;
}

- (void)sectionHeaderView:(CBMSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	CBMBillListSectionInfo *sectionInfo = (self.sectionInfoArray)[sectionClosed];
    
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}


#pragma mark - unwind
- (IBAction)backBillList:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:@"UnwindSegueCancelToBillList"] == YES) {
        
    }
    else if ([segue.identifier isEqualToString:@"UnwindSegueChildAddToBillList"] == YES)
    {
        //[self.arryBillList addObject:[segue.sourceViewController valueForKey:@"dataModelBillMember"]];
        //[self.tableView reloadData];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueShowBillDetail"] == YES) {
        
    }
    
}

#pragma mark - TBD
- (void)initSectionInfoArray
{
	if ((self.sectionInfoArray == nil) ||
        ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tableView])) {

#if 1 //For UI testing  TBD...
        CBMDataModelBillMember *sec0Bill0 = [[CBMDataModelBillMember alloc] init];
        sec0Bill0.sBillName = @"section0-bill0";
        CBMDataModelBillMember *sec0Bill1 = [[CBMDataModelBillMember alloc] init];
        sec0Bill1.sBillName = @"section0-bill1";
        CBMDataModelBillMember *sec0Bill2 = [[CBMDataModelBillMember alloc] init];
        sec0Bill2.sBillName = @"section0-bill2";
        CBMDataModelBillMember *sec0Bill3 = [[CBMDataModelBillMember alloc] init];
        sec0Bill3.sBillName = @"section0-bill3";
        CBMDataModelBillMember *sec1Bill0 = [[CBMDataModelBillMember alloc] init];
        sec1Bill0.sBillName = @"section1-bill0";
        CBMDataModelBillMember *sec1Bill1 = [[CBMDataModelBillMember alloc] init];
        sec1Bill1.sBillName = @"section1-bill1";
        CBMDataModelBillMember *sec1Bill2 = [[CBMDataModelBillMember alloc] init];
        sec1Bill2.sBillName = @"section1-bill2";
        CBMDataModelBillMember *sec1Bill3 = [[CBMDataModelBillMember alloc] init];
        sec1Bill3.sBillName = @"section1-bill3";
        CBMDataModelBillMember *sec1Bill4 = [[CBMDataModelBillMember alloc] init];
        sec1Bill4.sBillName = @"section1-bill4";
        CBMDataModelBillMember *sec2Bill0 = [[CBMDataModelBillMember alloc] init];
        sec2Bill0.sBillName = @"section2-bill0";
        CBMDataModelBillMember *sec2Bill1 = [[CBMDataModelBillMember alloc] init];
        sec2Bill1.sBillName = @"section2-bill1";
        CBMDataModelBillMember *sec2Bill2 = [[CBMDataModelBillMember alloc] init];
        sec2Bill2.sBillName = @"section2-bill2";
        CBMDataModelBillMember *sec2Bill3 = [[CBMDataModelBillMember alloc] init];
        sec2Bill3.sBillName = @"section2-bill3";
        CBMDataModelBillMember *sec2Bill4 = [[CBMDataModelBillMember alloc] init];
        sec2Bill4.sBillName = @"section2-bill4";
        CBMDataModelBillMember *sec2Bill5 = [[CBMDataModelBillMember alloc] init];
        sec2Bill5.sBillName = @"section2-bill5";
        
        
        NSMutableArray* section0 = [NSMutableArray arrayWithObjects:sec0Bill0, sec0Bill1, sec0Bill2, sec0Bill3, nil];
        NSMutableArray* section1 = [NSMutableArray arrayWithObjects:sec1Bill0, sec1Bill1, sec1Bill2, sec1Bill3, sec1Bill4, nil];
        NSMutableArray* section2 = [NSMutableArray arrayWithObjects:sec2Bill0, sec2Bill1, sec2Bill2, sec2Bill3, sec2Bill4, sec2Bill5, nil];
        
        self.arrayBillList = [[NSMutableArray alloc] init];
        
        [self.arrayBillList addObject:section0];
        [self.arrayBillList addObject:section1];
        [self.arrayBillList addObject:section2];
        
        NSMutableArray *infoArray = [[NSMutableArray alloc] init];
        
		for (NSMutableArray *billArray in self.arrayBillList) {
            
			CBMBillListSectionInfo *billListSectionInfo = [[CBMBillListSectionInfo alloc] init];
			billListSectionInfo.billArray = billArray;
			billListSectionInfo.open = NO;
            billListSectionInfo.sSectionName = @"section name";
            
            NSNumber *defaultRowHeight = @(DEFAULT_ROW_HEIGHT);
			NSInteger countOfRows = [billListSectionInfo.billArray count];
			for (NSInteger i = 0; i < countOfRows; i++) {
				[billListSectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
			}
            
			[infoArray addObject:billListSectionInfo];
		}
        
		self.sectionInfoArray = infoArray;
#else
        NSMutableArray *infoArray = [[NSMutableArray alloc] init];
        
		for (NSMutableArray *billArray in self.arrayBillList) {
            
			CBMBillListSectionInfo *billListSectionInfo = [[CBMBillListSectionInfo alloc] init];
			billListSectionInfo.billArray = billArray;
			billListSectionInfo.open = NO;
            
            NSNumber *defaultRowHeight = @(DEFAULT_ROW_HEIGHT);
			NSInteger countOfRows = [billListSectionInfo.billArray count];
			for (NSInteger i = 0; i < countOfRows; i++) {
				[billListSectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
			}
            
			[infoArray addObject:billListSectionInfo];
		}
        
		self.sectionInfoArray = infoArray;
#endif
	}
}

@end
