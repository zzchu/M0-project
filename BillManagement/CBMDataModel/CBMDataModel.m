//
//  CBMDataModel.m
//  BillManagement
//
//  Created by zhaozhengchu on 6/1/14.
//  Copyright (c) 2014 zhaozheng chu. All rights reserved.
//

#import "CBMDataModel.h"

@implementation CBMDataModel

+ (CBMDataModel *)instance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedInstance = nil;
    dispatch_once(&pred, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}

- (void)initDataModel
{
    self.localSave = [[CBMDataModelLocalSave alloc] init];
}

- (BOOL)saveGroupMember:(CBMDataModelGroupMember*)groupMember
{
    return YES;
}

- (BOOL)saveBillMember:(CBMDataModelBillMember*)billMember
{
    return YES;
}
@end
