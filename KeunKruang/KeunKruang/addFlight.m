//
//  addFlight.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/19/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "addFlight.h"
#import "AppDelegate.h"
#import "Passport.h"
#import "Destination.h"
#import "Flight.h"
AppDelegate *ad;
@implementation addFlight
@synthesize flightno_field,flightpp_field,flightdest_field,flightdepart_field,departpicker,selectpp,selectdest,d_ppno,d_code,d_country,visapicker,flightvisa_field;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    sectionno=1;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"ตรวจสอบ" style:UIBarButtonItemStyleDone target:self action:@selector(verify_Clicked:)] autorelease];
    UIBarButtonItem *cancel = [[[UIBarButtonItem alloc] initWithTitle:@"ยกเลิก" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_Clicked:)] autorelease];
    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.title=@"เพิ่มเที่ยวบิน";
    pars = [[DestParser alloc] loadXMLByURL:@"http://app.lingoomtang.com/boarding/destination/getListDestination"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [selectpp selectRow:0 inComponent:0 animated:YES];
    [selectpp reloadAllComponents];
    ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [flightno_field release];
    [flightdepart_field release];
    [flightdest_field release];
    [flightpp_field release];
    [flightvisa_field release];
    [departpicker release];
    [visapicker release];
    [selectpp release];
    [selectdest release];
    [d_code release];
    [d_country release];
    [d_ppno release];
    [pars release];
    flightno_field=nil;
    flightdepart_field=nil;
    flightdest_field=nil;
    flightpp_field=nil;
    flightvisa_field=nil;
    d_code=nil;
    d_country=nil;
    d_ppno=nil;
    departpicker=nil;
    selectdest=nil;
    selectpp=nil;
    visapicker=nil;
    pars=nil;
}
-(void)dealloc{
    [super dealloc];
    [flightno_field release];
    [flightdepart_field release];
    [flightdest_field release];
    [flightpp_field release];
    [departpicker release];
    [selectpp release];
    [selectdest release];
    [visapicker release];
    [d_code release];
    [d_country release];
    [d_ppno release];
    [pars release];
    flightno_field=nil;
    flightdepart_field=nil;
    flightdest_field=nil;
    flightpp_field=nil;
    d_code=nil;
    d_country=nil;
    departpicker=nil;
    selectdest=nil;
    selectpp=nil;
    pars=nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [flightno_field becomeFirstResponder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void) hideKeyboard {
    [flightno_field resignFirstResponder];
    [flightdepart_field resignFirstResponder];
    [flightdest_field resignFirstResponder];
    [flightpp_field resignFirstResponder];
    [flightvisa_field resignFirstResponder];
}
- (void) cancel_Clicked:(id)sender {
    //Dismiss the controller.
    flightno_field=nil;
    flightdepart_field=nil;
    flightdest_field=nil;
    flightpp_field=nil;
    d_code=nil;
    d_country=nil;
    d_ppno=nil;
    departpicker=nil;
    visapicker=nil;
    selectdest=nil;
    selectpp=nil;
    pars=nil;
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void) verify_Clicked:(id)sender {
    if(![flightno_field.text length]||![flightdepart_field.text length]||![flightdest_field.text length]||![flightpp_field.text length]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณากรอกข้อมูลให้ครบ" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
        [alert show];
        [alert release];
    }
    else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *v_str = [NSString stringWithFormat:@"http://app.lingoomtang.com/boarding/visa/getVisa/%@",d_country];
        v_pars = [[VisaParser alloc] loadXMLByURL:v_str];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ" style:UIBarButtonItemStyleDone target:self action:@selector(add_Clicked:)] autorelease];
        NSIndexPath *visa_status = [NSIndexPath indexPathForRow:0 inSection:1];
        sectionno++;
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
        Visa *currentCountry = [[v_pars Visa_l] objectAtIndex:0];
        if(d_pptype==1){
            if([currentCountry or_visa]==0){
                [self.tableView cellForRowAtIndexPath:visa_status].textLabel.text=[NSString stringWithFormat:@"ไม่ต้องขอวีซ่า อยู่ได้ %d วัน",[currentCountry or_day]];
                flightvisa_field.text=@"ใช่";
                flightvisa_field.textColor=[UIColor grayColor];
                flightvisa_field.enabled=false;
            }
            else{
                [self.tableView cellForRowAtIndexPath:visa_status].textLabel.text=@"ต้องขอวีซ่า";
                flightvisa_field.text=@"ไม่ใช่";
            }
        }
        else if(d_pptype==2){
            if([currentCountry of_visa]==0){
                [self.tableView cellForRowAtIndexPath:visa_status].textLabel.text=[NSString stringWithFormat:@"ไม่ต้องขอวีซ่า อยู่ได้ %d วัน",[currentCountry of_day]];
                flightvisa_field.text=@"ใช่";
                flightvisa_field.textColor=[UIColor grayColor];
                flightvisa_field.enabled=false;
            }
            else{
                [self.tableView cellForRowAtIndexPath:visa_status].textLabel.text=@"ต้องขอวีซ่า";
                flightvisa_field.text=@"ไม่ใช่";
            }
        }
        flightno_field.enabled=false;
        flightdepart_field.enabled=false;
        flightdest_field.enabled=false;
        flightpp_field.enabled=false;
        flightno_field.textColor=[UIColor grayColor];
        flightdepart_field.textColor=[UIColor grayColor];
        flightdest_field.textColor=[UIColor grayColor];
        flightpp_field.textColor=[UIColor grayColor];
        [self.tableView reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}
#pragma mark - Date Picker
- (void)changeDateInLabel:(id)sender{
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd-MM-yyyy HH:mm"];
	flightdepart_field.text = [NSString stringWithFormat:@"%@",
                           [df stringFromDate:departpicker.date]];
	[df release];
}
#pragma mark - UIPicker
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if(pickerView==selectpp){
        Passport *pp1 = [ad.pp objectAtIndex:row];
        if(pp1.type==1){
            flightpp_field.text = [NSString stringWithFormat:@"%@ - ทั่วไป",pp1.no];
        }
        else{
            flightpp_field.text = [NSString stringWithFormat:@"%@ - ราชการ",pp1.no];
        }
        d_ppno=pp1.no;
        d_pptype=pp1.type;
    }
    else if(pickerView==selectdest){
        Destination *dest = [[pars dest_l] objectAtIndex:row];
        flightdest_field.text = [NSString stringWithFormat:@"%@ - %@",dest.code,dest.fullname];
        d_code = dest.code;
        d_country = dest.country;
    }
    else if(pickerView==visapicker){
        if(row==0){
            flightvisa_field.text=@"ใช่";
        }
        else if(row==1){
            flightvisa_field.text=@"ไม่ใช่";
        }
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView==selectpp){
        return [ad.pp count];
    }
    else if(pickerView==selectdest){
        return [[pars dest_l] count];
    }
    else if(pickerView==visapicker){
        return 2;
    }
    else{
        return 0;
    }
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView==selectpp){
        Passport *pp1 = [ad.pp objectAtIndex:row];
        if(pp1.type==1){
            return [NSString stringWithFormat:@"%@ - ทั่วไป",pp1.no];
        }
        else{
            return [NSString stringWithFormat:@"%@ - ราชการ",pp1.no];
        }
    }
    else if(pickerView==selectdest){
        Destination *dest = [[pars dest_l] objectAtIndex:row];
        return [NSString stringWithFormat:@"%@ - %@",dest.code,dest.fullname];
    }
    else if(pickerView==visapicker){
        if(row==0){
            return @"ใช่";
        }
        else{
            return @"ไม่ใช่";
        }
    }
    else{
        return nil;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return sectionno;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section==0){
        return 4;
    }
    else if(section==1){
        return 2;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSMutableArray *tmp=[[NSMutableArray alloc]initWithObjects:@"เช่น TG795",@"28-10-2012 20:00",@"KUL - กัวลาลัมเปอร์",@"J342871 - ทั่วไป", nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if ([indexPath section] == 0) {
            if ([indexPath row] == 0) {
                flightno_field = [[UITextField alloc] initWithFrame:CGRectMake(130, 11, 180, 22)];
                flightno_field.delegate=self;
                flightno_field.adjustsFontSizeToFitWidth = YES;
                flightno_field.textColor = [UIColor colorWithRed:81.0/256 green:102.0/265 blue:145.0/256 alpha:1.0];
                [flightno_field setPlaceholder:[tmp objectAtIndex:[indexPath row]]];
                flightno_field.keyboardType = UIKeyboardTypeDefault;
                flightno_field.returnKeyType = UIReturnKeyDone;
                flightno_field.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
                flightno_field.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; 
                flightno_field.textAlignment = UITextAlignmentLeft;
                flightno_field.tag = 0;
                //playerTextField.delegate = self;
                
                [flightno_field setEnabled: YES];
                
                [cell addSubview:flightno_field];
                
                [flightno_field release];
            }
            if ([indexPath row] == 1) {
                departpicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 250)];
                departpicker.datePickerMode = UIDatePickerModeDateAndTime;
                departpicker.date = [NSDate date];
                departpicker.minimumDate = [NSDate date];
                [departpicker addTarget:self
                                 action:@selector(changeDateInLabel:)
                       forControlEvents:UIControlEventValueChanged];
                
                flightdepart_field = [[UITextField alloc] initWithFrame:CGRectMake(130, 11, 180, 22)];
                
                flightdepart_field.adjustsFontSizeToFitWidth = YES;
                flightdepart_field.textColor = [UIColor colorWithRed:81.0/256 green:102.0/265 blue:145.0/256 alpha:1.0];
                [flightdepart_field setPlaceholder:[tmp objectAtIndex:[indexPath row]]];
                flightdepart_field.inputView=departpicker;
                
                UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
                keyboardDoneButtonView.barStyle = UIBarStyleBlack;
                keyboardDoneButtonView.translucent = YES;
                keyboardDoneButtonView.tintColor = nil;
                [keyboardDoneButtonView sizeToFit];
                
                UIBarButtonItem* doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ"
                                                                                style:UIBarButtonItemStyleDone target:self
                                                                               action:@selector(pickerDoneClicked:)] autorelease];
                
                [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
                
                flightdepart_field.inputAccessoryView = keyboardDoneButtonView;  
                
                flightdepart_field.textAlignment = UITextAlignmentLeft;
                flightdepart_field.tag = 0;
                //playerTextField.delegate = self;
                
                [flightdepart_field setEnabled: YES];
                
                [cell addSubview:flightdepart_field];
                
                [flightdepart_field release];
                [departpicker release];
                
            }
            if ([indexPath row] == 2) {
                selectdest = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 250, 325, 250)];
                selectdest.showsSelectionIndicator = YES;    // note this is default to NO
                
                [selectdest setDelegate:self];
                
                flightdest_field = [[UITextField alloc] initWithFrame:CGRectMake(130, 11, 180, 22)];
                
                flightdest_field.adjustsFontSizeToFitWidth = YES;
                flightdest_field.textColor = [UIColor colorWithRed:81.0/256 green:102.0/265 blue:145.0/256 alpha:1.0];
                [flightdest_field setPlaceholder:[tmp objectAtIndex:[indexPath row]]];
                flightdest_field.inputView=selectdest;
                
                UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
                keyboardDoneButtonView.barStyle = UIBarStyleBlack;
                keyboardDoneButtonView.translucent = YES;
                keyboardDoneButtonView.tintColor = nil;
                [keyboardDoneButtonView sizeToFit];
                
                UIBarButtonItem* doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ"
                                                                                style:UIBarButtonItemStyleDone target:self
                                                                               action:@selector(pickerDoneClicked:)] autorelease];
                
                [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
                
                flightdest_field.inputAccessoryView = keyboardDoneButtonView;  
                
                
                flightdest_field.textAlignment = UITextAlignmentLeft;
                flightdest_field.tag = 0;
                //playerTextField.delegate = self;
                
                [flightdest_field setEnabled: YES];
                
                [cell addSubview:flightdest_field];
                
                [flightdest_field release];
                [selectdest release];
                [keyboardDoneButtonView release];
            }
            if ([indexPath row] == 3) {
                selectpp = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 250, 325, 250)];
                selectpp.showsSelectionIndicator = YES;    // note this is default to NO
                
                [selectpp setDelegate:self];
                
                flightpp_field = [[UITextField alloc] initWithFrame:CGRectMake(130, 11, 180, 22)];
                
                flightpp_field.adjustsFontSizeToFitWidth = YES;
                flightpp_field.textColor = [UIColor colorWithRed:81.0/256 green:102.0/265 blue:145.0/256 alpha:1.0];
    
                [flightpp_field setPlaceholder:[tmp objectAtIndex:[indexPath row]]];
                flightpp_field.inputView=selectpp;
                
                UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
                keyboardDoneButtonView.barStyle = UIBarStyleBlack;
                keyboardDoneButtonView.translucent = YES;
                keyboardDoneButtonView.tintColor = nil;
                [keyboardDoneButtonView sizeToFit];
                
                UIBarButtonItem* doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ"
                                                                                style:UIBarButtonItemStyleDone target:self
                                                                               action:@selector(pickerDoneClicked:)] autorelease];
                
                [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
                
                flightpp_field.inputAccessoryView = keyboardDoneButtonView;  
                
                
                flightpp_field.textAlignment = UITextAlignmentLeft;
                flightpp_field.tag = 0;
                //playerTextField.delegate = self;
                
                [flightpp_field setEnabled: YES];
                
                [cell addSubview:flightpp_field];
                
                [flightpp_field release];
                [selectpp release];
                [keyboardDoneButtonView release];
            }
            if ([indexPath row] == 0) { 
                cell.textLabel.text = @"เลขที่เที่ยวบิน";
            }
            else if([indexPath row] == 1){
                cell.textLabel.text = @"วันเวลาเดินทาง";
            }
            else if([indexPath row] == 2){
                cell.textLabel.text = @"ปลายทาง";
            }
            else{
                cell.textLabel.text = @"หนังสือเดินทาง";
            }
        }
        else if ([indexPath section] == 1) {
            if([indexPath row]==1){
                visapicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 250, 325, 250)];
                visapicker.showsSelectionIndicator = YES;    // note this is default to NO
                
                [visapicker setDelegate:self];
                
                cell.textLabel.textAlignment=UITextAlignmentLeft;
                cell.textLabel.text=@"ทำการขอวีซ่าแล้ว";
                
                flightvisa_field = [[UITextField alloc] initWithFrame:CGRectMake(130, 11, 180, 22)];
                
                flightvisa_field.adjustsFontSizeToFitWidth = YES;
                flightvisa_field.textColor = [UIColor colorWithRed:81.0/256 green:102.0/265 blue:145.0/256 alpha:1.0];
                
                flightvisa_field.inputView=visapicker;
                
                UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
                keyboardDoneButtonView.barStyle = UIBarStyleBlack;
                keyboardDoneButtonView.translucent = YES;
                keyboardDoneButtonView.tintColor = nil;
                [keyboardDoneButtonView sizeToFit];
                
                UIBarButtonItem* doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ"
                                                                                style:UIBarButtonItemStyleDone target:self
                                                                               action:@selector(pickerDoneClicked:)] autorelease];
                
                [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
                
                flightvisa_field.inputAccessoryView = keyboardDoneButtonView;  
                
                
                flightvisa_field.textAlignment = UITextAlignmentLeft;
                flightvisa_field.tag = 0;
                //playerTextField.delegate = self;
                
                [flightvisa_field setEnabled: YES];
                
                [cell addSubview:flightvisa_field];
                
                [flightvisa_field release];
                [visapicker release];
                [keyboardDoneButtonView release];
            }
        }
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;

    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return @"ข้อมูลเที่ยวบิน";
    }
    if (section == 1){
        return @"ข้อมูลวีซ่า";
    }
    return 0;
}
-(void)pickerDoneClicked:(id)sender{
    [flightno_field resignFirstResponder];
    [flightdest_field resignFirstResponder];
    [flightdepart_field resignFirstResponder];
    [flightpp_field resignFirstResponder];
    [flightvisa_field resignFirstResponder];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
- (void) add_Clicked:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //Create Object.
    Flight *f1 = [[Flight alloc] initWithPrimaryKey:0];
    f1.no = flightno_field.text;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate *date = [dateFormat dateFromString:flightdepart_field.text]; 
    [dateFormat release];
    f1.datetime = date;
    f1.dest = flightdest_field.text;
    f1.PPtype = d_pptype;
    f1.PPno = d_ppno;
    if(flightvisa_field.text==@"ใช่"){
        f1.visa=1;
    }
    else{
        f1.visa=0;
    }
    //
    //Add the object
    [appDelegate addFlight:f1];
        
    //
    //Dismiss the controller.
    [f1 release];
    [flightno_field release];
    [flightdepart_field release];
    [flightdest_field release];
    [flightpp_field release];
    [flightvisa_field release];
    [departpicker release];
    [visapicker release];
    [selectpp release];
    [selectdest release];
    [d_code release];
    [d_country release];
    [d_ppno release];
    [pars release];
    flightno_field=nil;
    flightdepart_field=nil;
    flightdest_field=nil;
    flightpp_field=nil;
    flightvisa_field=nil;
    d_code=nil;
    d_country=nil;
    d_ppno=nil;
    departpicker=nil;
    selectdest=nil;
    selectpp=nil;
    visapicker=nil;
    pars=nil;
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
@end
