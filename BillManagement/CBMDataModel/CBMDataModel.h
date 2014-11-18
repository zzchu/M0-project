//
//  CBMDataModel.h
//  BillManagement
//
//  Created by zhaozhengchu on 6/1/14.
//  Copyright (c) 2014 zhaozheng chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBMDataModelBillMember.h"
#import "CBMDataModelGroupMember.h"
#import "CBMDataModelLocalSave.h"
@interface CBMDataModel : NSObject
{
}
//property
@property (strong, nonatomic) CBMDataModelLocalSave *localSave;

//Class method
+ (id)instance;

//instance method
- (BOOL)saveGroupMember:(CBMDataModelGroupMember*)groupMember;
- (BOOL)saveBillMember:(CBMDataModelBillMember*)billMember;
@end
