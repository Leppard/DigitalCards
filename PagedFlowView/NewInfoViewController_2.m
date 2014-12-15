//
//  NewInfoViewController_2.m
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "NewInfoViewController_2.h"

@interface NewInfoViewController_2 ()

@end

@implementation NewInfoViewController_2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    DataModel *dataModel = [[DataModel alloc]init];
    [dataModel initializeCardsList];
    PersonalInformation *p = dataModel.cardsList[[dataModel.cardsList count]-1];

    if ([textField.restorationIdentifier isEqual: @"Telephone"]) {
        p.telephone = (NSNumber*)self.telephone.text;
    }
    else if([textField.restorationIdentifier isEqual: @"Email"]){
        p.email = self.email.text;
    }
    else if([textField.restorationIdentifier isEqual: @"Address"]){
        p.address = self.address.text;
    }
    
    [dataModel saveCards];


}
- (IBAction)backToSelect:(id)sender {
   
    UIViewController* controller = self.navigationController.viewControllers[0];
    [controller.navigationController popViewControllerAnimated:YES];
}
@end
