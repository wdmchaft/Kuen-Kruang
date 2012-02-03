//
//  editFlight.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 2/1/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "editFlight.h"
#import "AppDelegate.h"
@implementation editFlight
@synthesize currentFlight;

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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"ยืนยันการขอวีซ่า" style:UIBarButtonItemStyleDone target:self action:@selector(verify_Clicked:)] autorelease];
    self.navigationItem.title=currentFlight.no;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [flightno_field release];
    [flightdest_field release];
    [flightpp_field release];
    [flightvisa_field release];
    [currentFlight release];
    flightno_field=nil;
    flightdest_field=nil;
    flightpp_field=nil;
    flightvisa_field=nil;
    currentFlight=nil;
}
-(void)dealloc{
    [super dealloc];
    [flightno_field release];
    [flightdest_field release];
    [flightpp_field release];
    [currentFlight release];
    flightno_field=nil;
    flightdest_field=nil;
    flightpp_field=nil;
    currentFlight=nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
- (void) hideKeyboard {
    [flightvisa_field resignFirstResponder];
}
-(void)pickerDoneClicked:(id)sender{
    [flightno_field resignFirstResponder];
    [flightdest_field resignFirstResponder];
    [flightpp_field resignFirstResponder];
    [flightvisa_field resignFirstResponder];
}
- (void) verify_Clicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ระวัง" message:@"เมื่อท่านยืนยันการขอวีซ่าแล้ว\nระบบจะไม่ให้ท่านแก้ไขข้อมูลอีก\nท่านต้องการยืนยันการขอวีซ่าหรือไม่" delegate:self cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ตกลง", nil];
    [alert show];
    [alert release];
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate updateFlight:currentFlight];
        [self.navigationController popToRootViewControllerAnimated:true];
    }
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if ([indexPath row] == 0) { 
            cell.textLabel.text = @"เลขที่เที่ยวบิน";
            flightno_field = [[UITextField alloc] initWithFrame:CGRectMake(110, 12, 200, 22)];
            
            flightno_field.adjustsFontSizeToFitWidth = YES;
            flightno_field.textColor = [UIColor grayColor];
            flightno_field.text = currentFlight.no;
            flightno_field.textAlignment = UITextAlignmentLeft;
            flightno_field.tag = 0;
            //playerTextField.delegate = self;
            
            [flightno_field setEnabled: NO];
            [cell addSubview:flightno_field];
            [flightno_field release];
        }
        else if([indexPath row] == 1){
            cell.textLabel.text = @"ปลายทาง";
            flightdest_field = [[UITextField alloc] initWithFrame:CGRectMake(110, 11, 200, 22)];
            
            flightdest_field.adjustsFontSizeToFitWidth = YES;
            flightdest_field.textColor = [UIColor grayColor];
            flightdest_field.text = currentFlight.dest;
            flightdest_field.textAlignment = UITextAlignmentLeft;
            flightdest_field.tag = 0;
            //playerTextField.delegate = self;
            
            [flightdest_field setEnabled: NO];
            [cell addSubview:flightdest_field];
            [flightdest_field release];
            
        }
        else if([indexPath row] == 2){
            cell.textLabel.text = @"ประเภทหนังสือเดินทาง";
            flightpp_field = [[UITextField alloc] initWithFrame:CGRectMake(160, 11, 200, 22)];
            
            flightpp_field.adjustsFontSizeToFitWidth = YES;
            flightpp_field.textColor = [UIColor grayColor];
            if(currentFlight.PPtype==1){
                flightpp_field.text=@"ประเภททั่วไป";
            }
            else{
                flightpp_field.text=@"ประเภทราชการ";
            }
            flightpp_field.textAlignment = UITextAlignmentLeft;
            flightpp_field.tag = 0;
            //playerTextField.delegate = self;
            
            [flightpp_field setEnabled: NO];
            [cell addSubview:flightpp_field];
            [flightpp_field release];
            
        }
        else if([indexPath row] == 3){
            flightvisa_field = [[UITextField alloc] initWithFrame:CGRectMake(130, 11, 180, 22)];
            
            flightvisa_field.adjustsFontSizeToFitWidth = YES;
            flightvisa_field.textColor = [UIColor grayColor];
            flightvisa_field.text = @"ไม่ใช่";
            flightvisa_field.textAlignment = UITextAlignmentLeft;
            flightvisa_field.tag = 0;
            //playerTextField.delegate = self;
            
            [flightvisa_field setEnabled: NO];
            
            [cell addSubview:flightvisa_field];
            
            [flightvisa_field release];
            cell.textLabel.text = @"ทำการขอวีซ่าแล้ว";
        }
    }
    
    // Configure the cell...
    
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

@end
