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
#import "Weather.h"
@interface More : UIViewController{
    IBOutlet UITableView *menu;
    NSArray *arryData;
    About *aboutvc;
    Currency *currvc;
    Weather *weavc;
}
@property(nonatomic,retain) NSArray *arryData;
@property(nonatomic,retain) About *aboutvc;
@property(nonatomic,retain) Currency *currvc;
@property(nonatomic,retain) Weather *weavc;
@end