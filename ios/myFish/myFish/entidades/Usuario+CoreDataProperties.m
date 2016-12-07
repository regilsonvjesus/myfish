//
//  Usuario+CoreDataProperties.m
//  myFish
//
//  Created by MACBOOK PRO on 29/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Usuario+CoreDataProperties.h"

@implementation Usuario (CoreDataProperties)

+ (NSFetchRequest<Usuario *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Usuario"];
}

@dynamic emailLogin;
@dynamic senha;

@end
