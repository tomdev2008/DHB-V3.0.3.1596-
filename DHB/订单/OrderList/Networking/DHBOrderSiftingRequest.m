//
//  DHBOrderSiftingRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/31.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderSiftingRequest.h"

@implementation DHBOrderSiftingRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"ordersScreening";
}

-(id)value{
    return @{};
}
@end
