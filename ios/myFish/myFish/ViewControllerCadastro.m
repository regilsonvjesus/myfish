//
//  ViewControllerCadastro.m
//  myFish
//
//  Created by MACBOOK PRO on 22/11/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "ViewControllerCadastro.h"

@interface ViewControllerCadastro () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usuarioTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *senhaTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmaSenhaTextField;
@property (weak, nonatomic) IBOutlet UITextField *cepTextField;
@property (weak, nonatomic) IBOutlet UITextField *complementoTextField;
@property (weak, nonatomic) IBOutlet UIImageView *fotoImageView;


@end

@implementation ViewControllerCadastro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.fotoImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tirarFoto:)];
    
    [self.fotoImageView addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tirarFoto:(id)sender {
    
    UIImagePickerController *picker = [UIImagePickerController new];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *imagem = info[UIImagePickerControllerOriginalImage];
    [self.fotoImageView setImage:imagem];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)salvar:(id)sender {
    if ((self.usuarioTextField.text == nil || self.usuarioTextField.text.length == 0) || (self.emailTextField.text == nil || self.emailTextField.text.length == 0) || (self.senhaTextField.text == nil || self.senhaTextField.text.length == 0) || (self.cepTextField.text == nil || self.cepTextField.text.length == 0) || (self.complementoTextField.text == nil || self.complementoTextField.text.length == 0))  {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Informar os campos"
                                                                       message:@"Informar todos os campos, somente a foto é opicional !!!"
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
        
    } else if ([self.senhaTextField text] != [self.confirmaSenhaTextField text]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Valores diferentes"
                                                                       message:@"Os campos senha e confirma senham não conferem !!!"
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
        
    } else {
        [self realizarCadastro];
    }
}

- (void) realizarCadastro {
    /*
     code to encapsular in a json and foward base64 in the image
     */
    
    dispatch_queue_t fila = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(fila, ^{
        /*
        if (self.fotoImageView.image != nil && self.fotoImageView.image.size.width != 0) {
            
            UIImage *img = _fotoImageView.image;
            NSData *bytes = UIImageJPEGRepresentation(img, 0); //veja o comentário desta função
            NSString *stringBase64 = [bytes base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            //NSDictionary *json = @{@"tituloImagem":@"fotoTeste", @"img":stringBase64};
            
            NSDictionary *json = @{@"tituloImagem":@"fotoTeste", @"img":stringBase64, @"usuario": self.usuarioTextField.text, @"email": self.emailTextField.text, @"senha": self.senhaTextField.text, @"cep": self.cepTextField.text, @"complemento": self.complementoTextField.text};
        } else {
            
            NSDictionary *json = @{@"usuario": self.usuarioTextField.text, @"email": self.emailTextField.text, @"senha": self.senhaTextField.text, @"cep": self.cepTextField.text, @"complemento": self.complementoTextField.text};

        }
        */

        //UIImage *img = [UIImage imageNamed:@"iesb"];
        UIImage *img = _fotoImageView.image;
        NSData *bytes = UIImageJPEGRepresentation(img, 0); //veja o comentário desta função
        NSString *stringBase64 = [bytes base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        //NSDictionary *json = @{@"tituloImagem":@"fotoTeste", @"img":stringBase64};
        
        NSDictionary *json = @{@"tituloImagem":@"fotoTeste", @"img":stringBase64, @"usuario": self.usuarioTextField.text, @"email": self.emailTextField.text, @"senha": self.senhaTextField.text, @"cep": self.cepTextField.text, @"complemento": self.complementoTextField.text};
        
        NSError *erroJSON;
        NSData *jsonBytes = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&erroJSON];
        if (jsonBytes) {
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts/1"]];
            
            NSURLSessionUploadTask *uploadTask =
            [session uploadTaskWithRequest:request
                                  fromData:jsonBytes
                         completionHandler:^(NSData * _Nullable data,
                                             NSURLResponse * _Nullable response,
                                             NSError * _Nullable error) {
                             if (error) {
                                 NSLog(@"Erro na chamada de upload: %@", error);
                             }else {
                                 if (data) {
                                     //Aqui você trata os dados retornados, se houver.
                                     NSLog(@"Resposta recebida com dados.");
                                 }else {
                                     if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                         NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
                                         NSLog(@"Resposta sem erro, com status: %ld", (long)resp.statusCode);
                                     }
                                 }
                             }
                         }];
            
            [uploadTask resume];
            
        }else {
            NSLog(@"Erro ao converter para JSON: %@", erroJSON);
        }
        
        
    });
    
}

@end
