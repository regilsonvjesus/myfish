//
//  Produto+CoreDataProperties.m
//  myFish
//
//  Created by MACBOOK PRO on 29/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Produto+CoreDataProperties.h"

@implementation Produto (CoreDataProperties)

+ (NSFetchRequest<Produto *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Produto"];
}

@dynamic codigo;
@dynamic descricao;
@dynamic valor;
@dynamic qtdeDisponivel;
@dynamic imagem;

@end
