//
//  DetailView.m
//  ThaiVisaGuru
//
//  Created by Napawan Srisuksawad on 12/25/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "VisaDetail.h"

@implementation VisaDetail
@synthesize selectedCountry,fullnameCountry;

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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [super viewDidLoad];
    self.navigationItem.title = fullnameCountry;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *url = [NSString  stringWithFormat:@"http://app.lingoomtang.com/boarding/visa/getVisa/%@",selectedCountry];
    pars = [[VisaParser alloc] loadXMLByURL:url];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [selectedCountry release];
    [fullnameCountry release];
    [pars release];
    
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
- (void) dealloc{
    [selectedCountry release];
    [fullnameCountry release];
    [pars release];
    [super dealloc];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
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
    UIColor *ok=[UIColor colorWithRed:42.0/255.0 green:86.0/255.0 blue:42.0/255.0 alpha:1];
    UIColor *nook=[UIColor colorWithRed:159.0/255.0 green:12.0/255.0 blue:10.0/255.0 alpha:1];
    
    Visa *currentCountry = [[pars Visa_l] objectAtIndex:0];
    if(indexPath.row==0 && indexPath.section==0){
        NSString *val=[NSString alloc];
        if([currentCountry or_visa]==0){
            val = [NSString stringWithFormat:@"ไม่ต้องทำการขอวีซ่า"];
            cell.textLabel.textColor=ok;
        }
        else{
            val = [NSString stringWithFormat:@"ต้องทำการขอวีซ่า"];
            cell.textLabel.textColor=nook;
        }
        cell.textLabel.text=val;
    }
    if(indexPath.row==1 && indexPath.section==0){
        NSString *val=[NSString alloc];
        int res=[currentCountry or_day];
        if(res){
            val = [NSString stringWithFormat:@"สามารถอยู่อาศัยได้ %d วัน",res];
            cell.textLabel.textColor=ok;
        }
        else{
            val = [NSString stringWithFormat:@"ระยะเวลาในการอาศัยขึ้นอยู่กับวีซ่า"];
            cell.textLabel.textColor=nook;
        }
        cell.textLabel.text=val;
    }
    if(indexPath.row==0 && indexPath.section==1){
        NSString *val=[NSString alloc];
        if([currentCountry of_visa]==0){
            val = [NSString stringWithFormat:@"ไม่ต้องทำการขอวีซ่า"];
            cell.textLabel.textColor=ok;
        }
        else{
            val = [NSString stringWithFormat:@"ต้องทำการขอวีซ่า"];
            cell.textLabel.textColor=nook;
        }
        cell.textLabel.text=val;
    }
    if(indexPath.row==1 && indexPath.section==1){
        NSString *val=[NSString alloc];
        int res=[currentCountry of_day];
        if(res){
            val = [NSString stringWithFormat:@"สามารถอยู่อาศัยได้ %d วัน",res];
            cell.textLabel.textColor=ok;
        }
        else{
            val = [NSString stringWithFormat:@"ระยะเวลาในการอาศัยขึ้นอยู่กับวีซ่า"];
            cell.textLabel.textColor=nook;
        }
        cell.textLabel.text=val;
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return @"หนังสือเดินทางทั่วไป";
    }
    else{
        return @"หนังสือเดินทางราชการ";
    }
    return 0;
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
