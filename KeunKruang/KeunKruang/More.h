//
//  More.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/15/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "About.h"
#import "Currency.h"
#import "Weather.h"
#import "VisaMain.h"
#import "DocumentMain.h"
#import "LuggageMain.h"
@interface More : UITableViewController{
    IBOutlet UITableView *menu;
    NSArray *arryData;
    About *aboutvc;
    Currency *currvc;
    Weather *weavc;
    VisaMain *vvc;
    DocumentMain *dvc;
    LuggageMain *lvc;
}
@property(nonatomic,retain) NSArray *arryData;
@property(nonatomic,retain) About *aboutvc;
@property(nonatomic,retain) Currency *currvc;
@property(nonatomic,retain) Weather *weavc;
@property(nonatomic,retain) VisaMain *vvc;
@property(nonatomic,retain) DocumentMain *dvc;
@property(nonatomic,retain) LuggageMain *lvc;
@end