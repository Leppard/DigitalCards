//
//  NewInfoViewController_3.h
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInformation.h"

@interface NewInfoViewController_3 : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
- (IBAction)backToSelect:(id)sender;
- (IBAction)choosePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *addPhoto;

@end
