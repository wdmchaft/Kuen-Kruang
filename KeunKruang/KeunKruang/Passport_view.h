//
//  Passport_view.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addPassport.h"
#import "Passport.h"

@interface Passport_view : UITableViewController{
    addPassport *avController;
    UINavigationController *addNavigationController;
}
@end
