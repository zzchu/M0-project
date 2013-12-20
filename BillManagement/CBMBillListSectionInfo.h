
//
//  CBMBillListSectionInfo.h
//  BillManagement
//
//  Created by zhaozheng chu on 15/12/13.
//  Copyright (c) 2013 zhaozheng chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBMSectionHeaderView;
@class CBMDataModelBillMember;

@interface CBMBillListSectionInfo : NSObject 

@property (retain) NSString *sSectionName;
@property (nonatomic)BOOL open;
@property (retain, nonatomic)NSMutableArray *billArray;
@property (nonatomic)CBMSectionHeaderView *headerView;
@property (nonatomic) NSMutableArray *rowHeights;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

@end
