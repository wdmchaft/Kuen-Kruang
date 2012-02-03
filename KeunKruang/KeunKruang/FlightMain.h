//
//  FlightMain.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/14/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addFlight.h"
#import "Flight.h"
#import "editFlight.h"

@interface FlightMain : UITableViewController{
    addFlight *avController;
    UINavigationController *addNavigationController;
}
@end
