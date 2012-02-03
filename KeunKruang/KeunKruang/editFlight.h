//
//  editFlight.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 2/1/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"
@interface editFlight : UITableViewController<UIAlertViewDelegate,UITextFieldDelegate>{
    UITextField *flightno_field;
    UITextField *flightdest_field;
    UITextField *flightpp_field;
    UITextField *flightvisa_field;
    Flight *currentFlight;
}
@property(assign) Flight *currentFlight;
@property(assign) NSIndexPath *selectedIndexPath;
@property(assign) UITextField *flightno_field;
@property(assign) UITextField *flightdest_field;
@property(assign) UITextField *flightpp_field;
@property(assign) UITextField *flightvisa_field;
@end
