//
//  ViewController.m
//  PagedFlowView
//
//  Created by Lu Kejin on 3/5/12.
//  Copyright (c) 2012 geeklu.com. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController
@synthesize hFlowView;
//@synthesize vFlowView;
//@synthesize hPageControl;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageArray = [[NSArray alloc] initWithObjects:@"8",@"9",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    
    hFlowView.delegate = self;
    hFlowView.dataSource = self;
//    hFlowView.pageControl = hPageControl;
    hFlowView.minimumPageAlpha = 0.3;
    hFlowView.minimumPageScale = 0.9;
    
//    vFlowView.delegate = self;
//    vFlowView.dataSource = self;
//    vFlowView.minimumPageAlpha = 0.4;
//    vFlowView.minimumPageScale = 0.8;
//    vFlowView.orientation = PagedFlowViewOrientationVertical;
//    UIViewController *ViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"123"];
    
    
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(135,213);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    NSLog(@"Scrolled to page # %d", index);
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{

    //    NSLog(@"Tapped on page # %d", index);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    
    FrontPageViewController *frontPageViewController = [storyboard instantiateViewControllerWithIdentifier:@"FrontPage"];
    
    [self.navigationController pushViewController:frontPageViewController animated:YES];

}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [imageArray count];

}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
    }
    imageView.image = [UIImage imageNamed:@"HomeSelectItem"];
    return imageView;
}


- (IBAction)addNewCard:(id)sender {
    NewPageViewController *pageViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PageViewController"];
    [self.navigationController pushViewController:pageViewController animated:YES];
    

    
}



@end
