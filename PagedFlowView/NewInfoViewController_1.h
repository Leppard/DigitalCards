//
//  NewInfoViewController_1.h
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInformation.h"

@interface NewInfoViewController_1 : UIViewController<UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *position;

- (IBAction)backToSelect:(id)sender;

@end
