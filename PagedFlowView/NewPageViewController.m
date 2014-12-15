
//
//  NewPageViewController.m
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "NewPageViewController.h"

@interface NewPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *pageViewControllers;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation NewPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configContentViewControllers];
    [self configPageControl];
    
    self.dataSource = self;
    
    DataModel *dataModel = [[DataModel alloc]init];
    
    [dataModel initializeCardsList];
    [dataModel addCard];
    [dataModel saveCards];
    
    

}

#pragma mark - UI Config

- (void)configPageControl{
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.pageViewControllers.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];

}

#pragma mark - Data Config

- (void)configContentViewControllers{
    for (int i = 0; i<4; i++) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%d",i]];
        
        [self.pageViewControllers addObject:viewController];
    }
    [self setViewControllers:@[self.pageViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - PageViewController Datasource

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    if ([viewController.restorationIdentifier intValue] == 3) {
        self.pageControl.currentPage = 3;
        return nil;
    }
    self.pageControl.currentPage = self.pageControl.currentPage+1;
    return self.pageViewControllers[[viewController.restorationIdentifier intValue]+1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    if ([viewController.restorationIdentifier intValue] == 0) {
        self.pageControl.currentPage = 0;
        return nil;
    }
    self.pageControl.currentPage = self.pageControl.currentPage - 1;
    return self.pageViewControllers[[viewController.restorationIdentifier intValue]-1];
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return [self.viewControllers count];
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}


#pragma mark - Getter

- (NSMutableArray *)pageViewControllers{
    if (!_pageViewControllers) {
        _pageViewControllers = [[NSMutableArray alloc]init];
    }
    return _pageViewControllers;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(151,480, 20, 10)];
    }
    return _pageControl;
}

@end
