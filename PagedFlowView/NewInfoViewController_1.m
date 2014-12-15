//
//  NewInfoViewController_1.m
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "NewInfoViewController_1.h"

@interface NewInfoViewController_1 ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;

@end

@implementation NewInfoViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
   
    DataModel *dataModel = [[DataModel alloc]init];
    [dataModel initializeCardsList];
    PersonalInformation *p = dataModel.cardsList[[dataModel.cardsList count]-1];
    
    if ([textField.restorationIdentifier  isEqual: @"Name"]) {
        p.name = self.nameTextField.text;
    }
    else if([textField.restorationIdentifier  isEqual: @"Company"]){
        p.company = self.companyTextField.text;
    }
    else if([textField.restorationIdentifier  isEqual: @"Position"]){
        p.position = self.positionTextField.text;
    }
    
    [dataModel saveCards];
    
}

- (IBAction)backToSelect:(id)sender {
    
    UIViewController* controller = self.navigationController.viewControllers[0];
    [controller.navigationController popViewControllerAnimated:YES];

}
@end
