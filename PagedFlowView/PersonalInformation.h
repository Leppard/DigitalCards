//
//  PersonalInformation.h
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface PersonalInformation : NSObject<NSCoding>

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *company;
@property(nonatomic,strong)NSString *position;
@property(nonatomic,strong)NSNumber *telephone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)UIImage *photo;


@end
