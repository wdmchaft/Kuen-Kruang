//
//  Passport_view.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "Passport_view.h"
#import "AppDelegate.h"

@implementation Passport_view
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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:nil];
    [[self navigationItem] setRightBarButtonItem:add];
    [add release];
    self.editButtonItem.title = @"ลบ";
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    return appDelegate.pp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = 
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Passport *pp1 = [appDelegate.pp objectAtIndex:indexPath.row];
    
	// Set up the cell
    NSString *strtype=[NSString alloc];
    NSString *strexpire=[NSString alloc];
    cell.textLabel.text = [NSString stringWithFormat:@"หนังสือเดินทาง %@", pp1.no];
    if(pp1.type==1){
        strtype = [NSString stringWithFormat:@"ประเภททั่วไป    "];
    }
    else{
        strtype = [NSString stringWithFormat:@"ประเภทราชการ "];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:pp1.expire];
    [dateFormatter release];
    strexpire = [NSString stringWithFormat:@"หมดอายุ %@",strDate];
    UIColor *ok=[UIColor colorWithRed:42.0/255.0 green:86.0/255.0 blue:42.0/255.0 alpha:1];
    UIColor *warn=[UIColor colorWithRed:158.0/255.0 green:136.0/255.0 blue:56.0/255.0 alpha:1];
    UIColor *nook=[UIColor colorWithRed:159.0/255.0 green:12.0/255.0 blue:10.0/255.0 alpha:1];
    NSComparisonResult cmpdate=[pp1.expire compare:[NSDate date]];
    NSLog(@"%@",[NSDate date]);
    if(cmpdate==NSOrderedDescending){
        [cell.detailTextLabel setTextColor:ok];
    }
    else{
        [cell.detailTextLabel setTextColor:nook];
    }
    cell.detailTextLabel.text = [strtype stringByAppendingString:strexpire];
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
	return cell;
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
    }
    else {
        self.navigationItem.leftBarButtonItem.title = @"ลบ";
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleBordered;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"ลบ";
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //Get the object to delete from the array.
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        Passport *pp1 = [appDelegate.pp objectAtIndex:indexPath.row];
        [appDelegate removePassport:pp1];
        
        //Delete the object from the table.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
}

@end
