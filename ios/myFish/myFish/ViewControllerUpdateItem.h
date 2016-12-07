//
//  ViewControllerUpdateItem.h
//  myFish
//
//  Created by MACBOOK PRO on 01/12/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "ViewController.h"
#import "entidades/Pedido+CoreDataClass.h"
#import "entidades/Produto+CoreDataClass.h"

@interface ViewControllerUpdateItem : ViewController

@property (strong, nonatomic) Pedido *item;

@end
