//
//  ViewControllerAddItem.m
//  myFish
//
//  Created by MACBOOK PRO on 30/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "ViewControllerAddItem.h"
#import "AppDelegate.h"
#import "entidades/Pedido+CoreDataClass.h"
#import "entidades/Produto+CoreDataClass.h"
#import "stdlib.h"

@interface ViewControllerAddItem ()

@property (weak, nonatomic) IBOutlet UILabel *labelDescricao;
@property (weak, nonatomic) IBOutlet UITextField *quantidade;
@property (weak, nonatomic) IBOutlet UILabel *labelPreco;
@property (weak, nonatomic) IBOutlet UIImageView *imagePeixe;

@end

@implementation ViewControllerAddItem

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.descricao != nil) {
        [self.labelDescricao setText: self.descricao];
    } else {
        [self.labelDescricao setText: @"naoColou"];
    }
    
    [self.labelPreco setText: [NSString stringWithFormat:@"%d", arc4random_uniform(50)]];
    //Aqui pegar a image pra depois salvar no produto

    NSLog(@"viewDidLoad");
}


- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)incluir:(id)sender {
    
    if ([self.quantidade text] != nil && [self.quantidade.text intValue] > 0)
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        Pedido *pedido = [NSEntityDescription insertNewObjectForEntityForName:@"Pedido"
                                                       inManagedObjectContext:context];
        Produto *produto = [NSEntityDescription insertNewObjectForEntityForName:@"Produto"
                                                         inManagedObjectContext:context];
        
        //produto setCodigo:;
        [produto setDescricao:self.descricao];
        [produto setValor:(double)40.99];
        
        [pedido setCodigo:arc4random_uniform(9999)];
        [pedido setItens:produto];
        [pedido setValor:(double)40.99];
        [pedido setQtde:[self.quantidade.text intValue]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
        NSDate *data = [formatter dateFromString:@"20/02/2025"];
        [pedido setData:data];
        
        NSError *erroCoreData;
        if (![context save:&erroCoreData]) {
            NSLog(@"Deu erro! %@", erroCoreData);
        }else {
            NSLog(@"Pedido incluido com suesso!");
        }        
        
    } else {
    
     
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Informar a quantidade"
                                                                       message:@"Informar uma quantidade para compra !!!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok]; // add action to uialertcontroller
        
        [self presentViewController:alert animated:YES completion:nil];
    }
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
