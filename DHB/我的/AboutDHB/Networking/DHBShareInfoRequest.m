//
//  DHBShareInfoRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/23/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShareInfoRequest.h"

@implementation DHBShareInfoRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"shareContent";
}

-(id)value{
    return @{};
}
@end
