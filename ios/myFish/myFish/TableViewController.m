//
//  TableViewController.m
//  myFish
//
//  Created by MACBOOK PRO on 05/09/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "TableViewController.h"
#import "ViewControllerAddItem.h"

@interface TableViewController () <NSURLSessionDataDelegate>

//@property (strong, nonatomic) NSArray<NSString *> *peixes;

@property (strong, nonatomic) NSString *valor;

@property (strong, nonatomic) NSMutableData *bytesResposta;

@property (strong, nonatomic) NSArray<NSDictionary *> *photos;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.peixes = @[@"filhote", @"tucunare", @"tambaqui", @"pescada", @"dourada", @"pirarucu"];
    
    [self.tabela setDataSource:self];
    
    _bytesResposta = [NSMutableData new];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURLSessionConfiguration *sc =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sc
                                                          delegate:self
                                                     delegateQueue:nil];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:
     [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/photos"]];
    
    [task resume];
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    [_bytesResposta appendData:data];
}


- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    
    if (error) {
        NSLog(@"Erro de conexão: %@", error);
    }else {
        NSError *erroJSON;
        
        //NSArray<NSDictionary *> *photos =
        self.photos = [NSJSONSerialization JSONObjectWithData:_bytesResposta
                                        options:kNilOptions
                                          error:&erroJSON];
        
        if (erroJSON) {
            NSLog(@"JSON recebido é inválido: %@", erroJSON);
        }else {
            NSLog(@"Dados recebidos: %@", self.photos);
            
            /*
            for (NSDictionary *photo in self.photos) {
                NSLog(@"Post: %@", [photo objectForKey:@"title"]);
            }
             */
            
            [self.tabela reloadData];
            // Show the table view.
            self.tabela.hidden = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.peixes.count;
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celula" forIndexPath:indexPath];
    
    if (indexPath.row % 2) {
        [cell setBackgroundColor:[UIColor blackColor]];
        
    }else {
        [cell setBackgroundColor:[UIColor blueColor]];
    }
    
    //NSString *nome = [self.peixes objectAtIndex:indexPath.row];
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    NSString *nome = [photo objectForKey:@"title"];
    [cell.textLabel setText:nome];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    //self.valor = [self.peixes objectAtIndex:(long)indexPath.row];
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    self.valor = [photo objectForKey:@"title"];
    NSLog(@"descricao valor: %@", self.valor);
    [self performSegueWithIdentifier:@"segueAddItem" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueAddItem"]) {
        
        ViewControllerAddItem *destino = segue.destinationViewController;
        
        NSLog(@"description value: %@", _valor);
        
        destino.descricao = _valor;
        
    }
    
}

@end
