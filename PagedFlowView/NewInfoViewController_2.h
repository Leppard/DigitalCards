//
//  NewInfoViewController_2.h
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInformation.h"


@interface NewInfoViewController_2 : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *address;

- (IBAction)backToSelect:(id)sender;

@end
