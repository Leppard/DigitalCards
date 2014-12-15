//
//  DataModel.h
//  PagedFlowView
//
//  Created by Leppard on 14/12/5.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalInformation.h"

@interface DataModel : NSObject

-(void)saveCards;
-(void)initializeCardsList;
-(void)addCard;

@property (strong, nonatomic) NSMutableArray *cardsList;

@end
