//
//  ViewControllerUpdateItem.m
//  myFish
//
//  Created by MACBOOK PRO on 01/12/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "ViewControllerUpdateItem.h"

@interface ViewControllerUpdateItem ()

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPreco;
@property (weak, nonatomic) IBOutlet UITextField *textFieldQuantidade;
@property (weak, nonatomic) Pedido *pedido;
@property (weak, nonatomic) Produto *produto;

@end

@implementation ViewControllerUpdateItem


- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.item != nil) {
        self.pedido = _item;
        self.produto = [_pedido valueForKey:@"Itens"];
        
        self.labelName.text = [NSString stringWithFormat:@"%@", [self.produto valueForKey:@"descricao"]];
        self.labelPreco.text = [NSString stringWithFormat:@"%@", [self.produto valueForKey:@"valor"]];
        self.textFieldQuantidade.text = [NSString stringWithFormat:@"%@", [self.pedido valueForKey:@"qtde"]];
    }

}


- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)alterar:(id)sender {
    
    if ([self.textFieldQuantidade text] != nil && [self.textFieldQuantidade.text intValue] > 0)
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        [self.pedido setValue: [NSNumber numberWithInt:[self.textFieldQuantidade.text intValue]] forKey:@"qtde"];
  
        NSError *erroCoreData;
        if (![context save:&erroCoreData]) {
            NSLog(@"Deu erro! %@", erroCoreData);
        }else {
            NSLog(@"Pedido alterado com suesso!");
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
