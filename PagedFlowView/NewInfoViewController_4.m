//
//  NewInfoViewController_4.m
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "NewInfoViewController_4.h"

@interface NewInfoViewController_4 ()

@end

@implementation NewInfoViewController_4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backToSelect:(id)sender {
    
    UIViewController* controller = self.navigationController.viewControllers[0];
    [controller.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveNewInfo:(id)sender {
    
    FrontPageViewController *vc = [[FrontPageViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
