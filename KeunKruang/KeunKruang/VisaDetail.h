//
//  DetailView.h
//  ThaiVisaGuru
//
//  Created by Napawan Srisuksawad on 12/25/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisaParser.h"

@interface VisaDetail : UITableViewController{
    NSString *selectedCountry;
    NSString *fullnameCountry;
    VisaParser *pars;
}
@property (nonatomic, retain) NSString *selectedCountry;
@property (nonatomic, retain) NSString *fullnameCountry;

@end
