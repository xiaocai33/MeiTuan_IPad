//
//  MTDistrictViewController.h
//  美团IPad
//
//  Created by 小蔡 on 16/5/2.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTRegionViewController : UIViewController
@property (nonatomic, weak) UIPopoverController *regionPopover;

@property (nonatomic, strong) NSArray *regions;
@end
