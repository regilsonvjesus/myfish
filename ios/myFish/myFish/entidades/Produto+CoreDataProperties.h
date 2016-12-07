//
//  Produto+CoreDataProperties.h
//  myFish
//
//  Created by MACBOOK PRO on 29/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Produto+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Produto (CoreDataProperties)

+ (NSFetchRequest<Produto *> *)fetchRequest;

@property (nonatomic) int16_t codigo;
@property (nullable, nonatomic, copy) NSString *descricao;
@property (nonatomic) double valor;
@property (nonatomic) int16_t qtdeDisponivel;
@property (nullable, nonatomic, copy) NSString *imagem;

@end

NS_ASSUME_NONNULL_END
