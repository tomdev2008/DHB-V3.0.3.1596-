//
//  DHBReturnedOrderStatusRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBReturnedOrderStatusRequest : DHBBaseNetworkRequest
@property(nonatomic , retain)NSString *returns_id; // 退货单ID
@end
