//
//  ViewControllerFinalizar.m
//  myFish
//
//  Created by MACBOOK PRO on 31/10/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "ViewControllerFinalizar.h"
#import "AppDelegate.h"
#import "entidades/Pedido+CoreDataClass.h"
#import "entidades/Produto+CoreDataClass.h"
#import "TableViewCellItens.h"
#import "ViewControllerUpdateItem.h"


@interface ViewControllerFinalizar () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabela;

@property (strong) NSMutableArray *pedidos;

@property (strong, nonatomic) Pedido *valor;

@end

@implementation ViewControllerFinalizar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabela setDataSource:self];
    [self.tabela setDelegate:self];

    UINib *nib = [UINib nibWithNibName:@"TableViewCellItens" bundle:[NSBundle mainBundle]];
    [self.tabela registerNib:nib forCellReuseIdentifier:@"TableViewCellItens"];
    
    UIBarButtonItem *btEditar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editarTabela:)];
    
    [self.navigationItem setRightBarButtonItem:btEditar];
}

- (void) editarTabela: (UIBarButtonItem *) sender {
    [self.tabela setEditing:!self.tabela.isEditing animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Pedido"];
    self.pedidos = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tabela reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pedidos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celula" forIndexPath:indexPath];
    
     TableViewCellItens *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellItens" forIndexPath:indexPath];
    
    //NSManagedObjectContext *pedido = [self.pedidos objectAtIndex:indexPath.row];
    Pedido *pedido = [self.pedidos objectAtIndex:indexPath.row];
    Produto *produto = [pedido valueForKey:@"Itens"];
    
    
    cell.labelCodigo.text = [NSString stringWithFormat:@"%@", [pedido valueForKey:@"codigo"]];
    cell.labelQuantidade.text = [NSString stringWithFormat:@"%@", [pedido valueForKey:@"qtde"]];
    
    cell.labelName.text = [NSString stringWithFormat:@"%@", [produto valueForKey:@"descricao"]];
    cell.labelPreco.text = [NSString stringWithFormat:@"%@", [produto valueForKey:@"valor"]];
    
    //[cell setBackgroundColor:[UIColor blackColor]];
    //NSManagedObjectContext *pedido = [self.pedidos objectAtIndex:indexPath.row];
    //[cell.textLabel setText: [NSString stringWithFormat:@"%@ %@", [pedido valueForKey:@"codigo"], [pedido valueForKey:@"qtde"]]];
    //[cell.textLabel setTextColor:[UIColor whiteColor]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100; //retornar aqui a altura estimada da célula... olhe no XIB a altura.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension; //isso faz a tableView aceitar células com alturas dinâmicas    
    return 100;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.pedidos objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove record from table view
        [self.pedidos removeObjectAtIndex:indexPath.row];
        [self.tabela deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    self.valor = [self.pedidos objectAtIndex:indexPath.row];
    NSLog(@"descricao valor: %@", self.valor);
    [self performSegueWithIdentifier:@"editCompra" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"editCompra"]) {
        
        ViewControllerUpdateItem *destino = segue.destinationViewController;
        
        NSLog(@"description value: %@", _valor);
        
        destino.item = _valor;
        
    }
    
}



@end
