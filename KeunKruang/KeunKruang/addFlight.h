//
//  addFlight.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/19/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestParser.h"
#import "VisaParser.h"
@interface addFlight : UITableViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    UITextField *flightno_field;
    UITextField *flightdepart_field;
    UITextField *flightdest_field;
    UITextField *flightpp_field;
    UITextField *flightvisa_field;
    UIDatePicker *departpicker;
    UIPickerView *selectdest;
    UIPickerView *selectpp;
    UIPickerView *visapicker;
    DestParser *pars;
    VisaParser *v_pars;
    NSString *d_ppno;
    NSString *d_code;
    NSString *d_country;
    NSInteger d_pptype;
    NSInteger sectionno;
}
@property(assign) UITextField *flightno_field;
@property(assign) UITextField *flightdepart_field;
@property(assign) UITextField *flightdest_field;
@property(assign) UITextField *flightpp_field;
@property(assign) UITextField *flightvisa_field;
@property(assign) UIPickerView *selectdest;
@property(assign) UIPickerView *selectpp;
@property(assign) UIPickerView *visapicker;
@property (assign) UIDatePicker *departpicker;
@property(nonatomic,retain) NSString *d_ppno;
@property(nonatomic,retain) NSString *d_code;
@property(nonatomic,retain) NSString *d_country;
@end
