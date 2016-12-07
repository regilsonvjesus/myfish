//
//  Pedido+CoreDataProperties.m
//  myFish
//
//  Created by MACBOOK PRO on 29/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Pedido+CoreDataProperties.h"

@implementation Pedido (CoreDataProperties)

+ (NSFetchRequest<Pedido *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Pedido"];
}

@dynamic codigo;
@dynamic qtde;
@dynamic data;
@dynamic valor;
@dynamic comprador;
@dynamic itens;

@end
