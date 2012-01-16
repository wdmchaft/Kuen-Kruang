//
//  addPassport.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 11/23/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Passport;
@interface addPassport : UITableViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    UITextField *ppno_field;
    UITextField *pptype_field;
    UITextField *ppexpire_field;
    UIPickerView *selecttype;
    UIDatePicker *datePicker;
}
@property (assign) UITextField *ppno_field;
@property (assign) UITextField *pptype_field;
@property (assign) UITextField *ppexpire_field;
@property (assign) UIPickerView *selecttype;
@property (assign) UIDatePicker *datePicker;
@end
