//
//  TableViewCellItens.h
//  myFish
//
//  Created by MACBOOK PRO on 08/11/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellItens : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelCodigo;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantidade;
@property (weak, nonatomic) IBOutlet UILabel *labelPreco;

@end
