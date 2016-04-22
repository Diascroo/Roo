//
//  Model.m
//  0112Test
//
//  Created by Mac on 16/1/12.
//  Copyright © 2016年 泛舟水上. All rights reserved.
//

#import "Model.h"

@implementation Model
- (NSString *)description {
    return  [NSString stringWithFormat:@"%ld,%@,%@",_contact_ID,_name,_phone];
}
- (void)dealloc
{
    self.name = nil;
    self.phone =nil;
    [super dealloc];
}
@end
