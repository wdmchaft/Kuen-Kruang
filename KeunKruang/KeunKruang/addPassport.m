//
//  addPassport.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 11/23/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "addPassport.h"
#import "AppDelegate.h"

@implementation addPassport

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
    UIBarButtonItem *done = [[[UIBarButtonItem alloc] initWithTitle:@"เสร็จ" style:UIBarButtonItemStyleDone target:self action:nil] autorelease];
    UIBarButtonItem *cancel = [[[UIBarButtonItem alloc] initWithTitle:@"ยกเลิก" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_Clicked:)] autorelease];
    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.rightBarButtonItem = done;
    self.navigationItem.title=@"เพิ่มหนังสือเดินทาง";
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    cell.accessoryType=UITableViewCellAccessoryNone;
    if ([indexPath section] == 0) {
        UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        playerTextField.adjustsFontSizeToFitWidth = YES;
        playerTextField.textColor = [UIColor blackColor];
        if ([indexPath row] == 0) {
            playerTextField.placeholder = @"เช่น J123456";
            playerTextField.keyboardType = UIKeyboardTypeDefault;
            playerTextField.returnKeyType = UIReturnKeyDone;
        }
        if ([indexPath row] == 1) {
            playerTextField.placeholder = @"ธรรมดา/ราชการ";
            playerTextField.keyboardType = UIKeyboardTypeDefault;
            playerTextField.returnKeyType = UIReturnKeyDone;
        }
        if ([indexPath row] == 2) {
            playerTextField.placeholder = @"เช่น 28/10/2015";
            playerTextField.keyboardType = UIKeyboardTypeDefault;
            playerTextField.returnKeyType = UIReturnKeyDone;
        }
        playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        playerTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; 
        playerTextField.textAlignment = UITextAlignmentLeft;
        playerTextField.tag = 0;
        //playerTextField.delegate = self;
        
        playerTextField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        [playerTextField setEnabled: YES];
        
        [cell addSubview:playerTextField];

        [playerTextField release];
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //Create Object.
    Passport *pp1 = [[Passport alloc] initWithPrimaryKey:0];
    
    
    //Add the object
    [appDelegate addPassport:pp1];
    
    //Dismiss the controller.
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
@end
