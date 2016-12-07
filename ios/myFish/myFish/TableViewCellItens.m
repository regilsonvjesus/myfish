//
//  TableViewCellItens.m
//  myFish
//
//  Created by MACBOOK PRO on 08/11/16.
//  Copyright © 2016 MACBOOK PRO. All rights reserved.
//

#import "TableViewCellItens.h"

@implementation TableViewCellItens

@synthesize labelCodigo = _labelCodigo;
@synthesize labelName = _labelName;
@synthesize labelQuantidade = _labelQuantidade;
@synthesize labelPreco = _labelPreco;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
