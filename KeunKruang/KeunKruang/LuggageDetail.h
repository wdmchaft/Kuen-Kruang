//
//  LuggageDetail.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/11/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuggageParser.h"

@interface LuggageDetail : UITableViewController{
    NSString *selectedCountry;
    NSString *fullnameCountry;
    LuggageParser *pars;
}
@property (nonatomic, retain) NSString *selectedCountry;
@property (nonatomic, retain) NSString *fullnameCountry;

@end
