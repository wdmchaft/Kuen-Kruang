//
//  addPassport.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 11/23/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "addPassport.h"
#import "AppDelegate.h"
#import "Passport.h"

@implementation addPassport
@synthesize ppno_field,pptype_field,ppexpire_field,selecttype;
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *done = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ" style:UIBarButtonItemStyleDone target:self action:@selector(add_Clicked:)] autorelease];
    UIBarButtonItem *cancel = [[[UIBarButtonItem alloc] initWithTitle:@"ยกเลิก" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_Clicked:)] autorelease];
    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.rightBarButtonItem = done;
    self.navigationItem.title=@"เพิ่มหนังสือเดินทาง";
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [pptype_field release];
    [ppno_field release];
    [ppexpire_field release];
    [selecttype release];
    pptype_field=nil;
    ppexpire_field=nil;
    ppno_field=nil;
    selecttype=nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [ppno_field becomeFirstResponder];
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
- (void) dealloc{
    [pptype_field release];
    [ppno_field release];
    [ppexpire_field release];
    [selecttype release];
    pptype_field=nil;
    ppexpire_field=nil;
    ppno_field=nil;
    selecttype=nil;
}
#pragma mark - Picker View
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if(row==0){
        pptype_field.text=@"ประเภททั่วไป";
    }
    else if(row==1){
        pptype_field.text=@"ประเภทราชการ";
    }
    else{
        //do nothing
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(row==0){
        return @"ประเภททั่วไป";
    }
    if(row==1){
        return @"ประเภทราชการ";
    }
    else{
        return nil;
    }
}

#pragma mark - Date Picker
- (void)changeDateInLabel:(id)sender{
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd-MM-yyyy"];
	ppexpire_field.text = [NSString stringWithFormat:@"%@",
                  [df stringFromDate:datePicker.date]];
	[df release];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            ppno_field = [[UITextField alloc] initWithFrame:CGRectMake(110, 11, 180, 22)];
            
            ppno_field.adjustsFontSizeToFitWidth = YES;
         
            ppno_field.placeholder = @"เช่น J123456";
            ppno_field.keyboardType = UIKeyboardTypeDefault;
            ppno_field.returnKeyType = UIReturnKeyDone;
            ppno_field.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            ppno_field.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; 
            ppno_field.textAlignment = UITextAlignmentLeft;
            ppno_field.tag = 0;
            //playerTextField.delegate = self;
            
            ppno_field.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
            [ppno_field setEnabled: YES];
            
            [cell addSubview:ppno_field];
            
            [ppno_field release];
            
        }
        if ([indexPath row] == 1) {
            selecttype = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 250, 325, 250)];
            selecttype.showsSelectionIndicator = YES;    // note this is default to NO
            [selecttype setDelegate:self];
            
            pptype_field = [[UITextField alloc] initWithFrame:CGRectMake(110, 11, 180, 22)];
            
            pptype_field.adjustsFontSizeToFitWidth = YES;
            pptype_field.placeholder = @"ทั่วไป/ราชการ";
            
            pptype_field.inputView = selecttype;
            
            pptype_field.textAlignment = UITextAlignmentLeft;
            pptype_field.tag = 0;
            //playerTextField.delegate = self;
            
            [pptype_field setEnabled: YES];
            
            [cell addSubview:pptype_field];
            
            [pptype_field release];
            [selecttype release];
            
        }
        if ([indexPath row] == 2) {
            datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 250)];
            datePicker.datePickerMode = UIDatePickerModeDate;
            datePicker.date = [NSDate date];
            datePicker.minimumDate = [NSDate date];
            [datePicker addTarget:self
                           action:@selector(changeDateInLabel:)
                 forControlEvents:UIControlEventValueChanged];
            ppexpire_field = [[UITextField alloc] initWithFrame:CGRectMake(110, 11, 180, 22)];
            
            ppexpire_field.adjustsFontSizeToFitWidth = YES;
            ppexpire_field.placeholder = @"เช่น 28-10-2015";
            
            ppexpire_field.inputView=datePicker;
            
            ppexpire_field.textAlignment = UITextAlignmentLeft;
            ppexpire_field.tag = 0;
            //playerTextField.delegate = self;
            
            [ppexpire_field setEnabled: YES];
            
            [cell addSubview:ppexpire_field];
            
            [ppexpire_field release];
            [datePicker release];
        }
    }
    if ([indexPath row] == 0) { 
        cell.textLabel.text = @"เลขที่";
    }
    else if([indexPath row] == 1){
        cell.textLabel.text = @"ประเภท";
    }
    else{
        cell.textLabel.text = @"วันหมดอายุ";
    }
    return cell;
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
- (void) cancel_Clicked:(id)sender {
    //Dismiss the controller.
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void) add_Clicked:(id)sender {
    if(![ppno_field.text length]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณากรอกข้อมูลให้ครบ" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
        [alert show];
        [alert release];
    }
    else if(![pptype_field.text length]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณากรอกข้อมูลให้ครบ" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
        [alert show];
        [alert release];
    }
    else if(![ppexpire_field.text length]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณากรอกข้อมูลให้ครบ" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
        [alert show];
        [alert release];
    }
    else{
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //Create Object.
        Passport *pp1 = [[Passport alloc] initWithPrimaryKey:0];
        pp1.no = ppno_field.text;
        if(pptype_field.text == @"ประเภททั่วไป"){
            pp1.type=1;
        }
        else{
            pp1.type=2;
        }
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSDate *date = [dateFormat dateFromString:ppexpire_field.text]; 
        [dateFormat release];
        pp1.expire = date;
    
        //Add the object
        [appDelegate addPassport:pp1];
    
        //
        //Set up notification
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
        // Get the current date
        NSDate *pickerDate = date;
    
        // Break the date up into components
        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
												   fromDate:pickerDate];
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    
        //BELOW SOON
        // Seven month(28 Week)
        // Six month(24 Week)
        // Three month(12 Week)
        // One month(4 Week)
        // Fifteen ( a week)
        //ABOVE SOON
    
        // This day fire
        [dateComps setDay:[dateComponents day]];
        [dateComps setMonth:[dateComponents month]];
        [dateComps setYear:[dateComponents year]];
        [dateComps setHour:0];
        [dateComps setMinute:0];
        [dateComps setSecond:0];
        NSDate *itemDate = [calendar dateFromComponents:dateComps];
        [dateComps release];
    
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = itemDate;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
        // Notification details
        localNotif.alertBody = [NSString stringWithFormat:@"หนังสือเดินทางเลขที่ %@ หมดอายุวันนี้", ppno_field.text];
        // Set the action button
        localNotif.alertAction = @"View";
    
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 1;
    
        // Specify custom data for the notification
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        localNotif.userInfo = infoDict;
    
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        [localNotif release];
    
        //
        //Dismiss the controller.
        [pp1 release];
        [self.navigationController dismissModalViewControllerAnimated:YES];

        }
}
@end
