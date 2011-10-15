//
//  More.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/15/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "About.h"
#import "Currency.h"
@interface More : UIViewController{
    IBOutlet UITableView *menu;
    NSArray *arryData;
    About *aboutvc;
    Currency *currvc;
}
@property(nonatomic,retain) NSArray *arryData;
@property(nonatomic,retain) About *aboutvc;
@property(nonatomic,retain) Currency *currvc;
@end