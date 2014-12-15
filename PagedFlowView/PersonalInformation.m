//
//  PersonalInformation.m
//  PagedFlowView
//
//  Created by Leppard on 14/11/30.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "PersonalInformation.h"

@implementation PersonalInformation

-(id)init
{
    if ((self = [super init])) {
        
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.company forKey:@"company"];
    [aCoder encodeObject:self.position forKey:@"position"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.company = [aDecoder decodeObjectForKey:@"company"];
    self.position = [aDecoder decodeObjectForKey:@"position"];
    self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.photo = [aDecoder decodeObjectForKey:@"photo"];
    }
    return self;
    
}

@end
