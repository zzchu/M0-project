//
//  CBMDataModelLocalSave.h
//  BillManagement
//
//  Created by zhaozhengchu on 6/8/14.
//  Copyright (c) 2014 zhaozheng chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBMDataModelLocalSave : NSObject
{
    NSManagedObjectContext *__managedObjectContext;
    NSManagedObjectModel *__managedObjectModel;
    NSPersistentStoreCoordinator *__persistentStoreCoordinator;
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
