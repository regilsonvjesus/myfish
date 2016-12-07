//
//  Pedido+CoreDataProperties.h
//  myFish
//
//  Created by MACBOOK PRO on 29/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Pedido+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Pedido (CoreDataProperties)

+ (NSFetchRequest<Pedido *> *)fetchRequest;

@property (nonatomic) int16_t codigo;
@property (nonatomic) int16_t qtde;
@property (nullable, nonatomic, copy) NSDate *data;
@property (nonatomic) double valor;
@property (nullable, nonatomic, retain) Usuario *comprador;
@property (nullable, nonatomic, retain) Produto *itens;

@end

NS_ASSUME_NONNULL_END
