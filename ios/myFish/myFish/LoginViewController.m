//
//  LoginViewController.m
//  myFish
//
//  Created by MACBOOK PRO on 01/09/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logar:(UIButton *)sender {
    
    
     NSString *valorValido = @"login";
     
     
    if ((![[self.login text] isEqualToString:valorValido]) || (![[self.senha text] isEqualToString:valorValido]))
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Falhou"
                                                                       message:@"Usuário ou senha inválida, favor tentar novamente"
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
    
  

@end
