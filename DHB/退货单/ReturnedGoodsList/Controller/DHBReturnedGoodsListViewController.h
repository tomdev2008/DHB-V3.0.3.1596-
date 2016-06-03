//
//  DHBReturnedGoodsListViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBReturnedGoodsListService.h"
#import "DHBGoodsViewCell_2.h"
#import "DHBReturnedGoodsFooterView.h"
#import "DHBOrderDetailsViewController.h"

@interface DHBReturnedGoodsListViewController : DHBTableViewController<DHBReturnedGoodsListService_Delegate, DHBReturnedGoodsFooterView_Delegate>
@property(nonatomic, retain) DHBReturnedGoodsListService *mainService;
@property(nonatomic, retain) NSMutableArray *dataKeysArray;
@end
