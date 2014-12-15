//
//  DataModel.m
//  PagedFlowView
//
//  Created by Leppard on 14/12/5.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel


-(void)initializeCardsList
{
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:@"AllCards"];
        if(data == nil)
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            self.cardsList = array;
        }
        else{
            self.cardsList = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
}



-(void)saveCards
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cardsList];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:@"AllCards"];
}

-(void)addCard{
    
    PersonalInformation *p = [[PersonalInformation alloc]init];
    [self.cardsList addObject:p];
    
}



@end
