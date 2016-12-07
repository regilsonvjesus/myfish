//
//  Usuario+CoreDataProperties.h
//  myFish
//
//  Created by MACBOOK PRO on 29/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Usuario+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Usuario (CoreDataProperties)

+ (NSFetchRequest<Usuario *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *emailLogin;
@property (nullable, nonatomic, copy) NSString *senha;

@end

NS_ASSUME_NONNULL_END
