//
//  FlightMain.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/14/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "FlightMain.h"
#import "addFlight.h"
#import "editFlight.h"
#import "AppDelegate.h"
#import "Reachability.h"
@implementation FlightMain
AppDelegate *appDelegate;

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
    self.navigationItem.title = @"เที่ยวบิน";
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(add_Clicked:)];
    [[self navigationItem] setRightBarButtonItem:add];
    [add release];
    self.editButtonItem.title = @"ลบ";
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [avController release];
    [addNavigationController release];
    avController=nil;
    addNavigationController=nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [avController release];
    [addNavigationController release];
    avController=nil;
    addNavigationController=nil;
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
    return [appDelegate.f count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    Flight *f1 = [appDelegate.f objectAtIndex:indexPath.row];
    
    // Set up the cell
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    NSString *strdatetime=[NSString alloc];
    NSString *strVisa = [NSString alloc];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", f1.no,f1.dest];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:f1.datetime];
    [dateFormatter release];
    strdatetime = [NSString stringWithFormat:@"ออกเดินทาง %@ ",strDate];
    
    UIColor *ok=[UIColor colorWithRed:42.0/255.0 green:86.0/255.0 blue:42.0/255.0 alpha:1];
    UIColor *warn=[UIColor colorWithRed:158.0/255.0 green:136.0/255.0 blue:56.0/255.0 alpha:1];
    UIColor *nook=[UIColor colorWithRed:159.0/255.0 green:12.0/255.0 blue:10.0/255.0 alpha:1];
    
    if(f1.visa==0){
        strVisa = [NSString stringWithFormat:@"ขาดวีซ่า"];
        [cell.detailTextLabel setTextColor:nook];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        strVisa = [NSString stringWithFormat:@"พร้อมเดินทาง"];
        [cell.detailTextLabel setTextColor:ok];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.detailTextLabel.text = [strdatetime stringByAppendingString:strVisa];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //Get the object to delete from the array.
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        Flight *f1 = [appDelegate.f objectAtIndex:indexPath.row];
        [appDelegate removeFlight:f1];
        
        //Delete the object from the table.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (self.tableView.editing) {
 self.editButtonItem.title =  @"เสร็จ";
 }
 else
 self.editButtonItem.title = @"ลบ";
 return YES;
 }
 */
- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    //Do super before, it will change the name of the editing button
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.navigationItem.leftBarButtonItem.title = @"เสร็จ";
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else {
        self.navigationItem.leftBarButtonItem.title = @"ลบ";
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleBordered;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"ลบ";
}


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
    Flight *f1 = [appDelegate.f objectAtIndex:indexPath.row];
    Reachability *r = [Reachability reachabilityWithHostName:@"www.lingoomtang.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(f1.visa==1){
        //do nothing
    }
    else{
        //navigation for visa edit
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            editFlight *v =
            [[editFlight alloc] initWithNibName:@"editFlight" bundle:[NSBundle mainBundle]];
            v.currentFlight=f1;
            [self.navigationController pushViewController:v animated:YES];
        }
    }
}
- (void) add_Clicked:(id)sender {
    Reachability *r = [Reachability reachabilityWithHostName:@"www.lingoomtang.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if([appDelegate.pp count]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"ท่านยังไม่มีหนังสือเดินทาง กรุณาเพิ่มหนังสือเดินทาง" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
        [alert show];
        [alert release];
    }
    else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            if(avController == nil)
                avController = [[addFlight alloc] initWithNibName:@"addFlight" bundle:nil];
            
            if(addNavigationController == nil)
                addNavigationController = [[UINavigationController alloc] initWithRootViewController:avController];
            UIColor *newcolor=[UIColor colorWithRed:0.0/255.0 green:74.0/255.0 blue:184.0/255.0 alpha:1];
            addNavigationController.navigationBar.tintColor=newcolor;
            avController=nil;
            [self.navigationController presentModalViewController:addNavigationController animated:YES];
            
        }   
    }
}
@end
