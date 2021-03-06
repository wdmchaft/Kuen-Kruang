//
//  More.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/15/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "More.h"

@implementation More
@synthesize arryData;
@synthesize currvc,weavc,aboutvc,vvc,dvc,lvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    arryData = [[NSArray alloc] initWithObjects:@"อัตราแลกเปลี่ยน",@"สภาพอากาศ",@"ตัวอย่างการกรอกเอกสาร",@"ข้อมูลสัมภาระ",@"รายละเอียดวีซ่าประเทศต่างๆ",@"เกี่ยวกับโปรแกรม",nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.aboutvc=nil;
    self.currvc=nil;
    self.weavc=nil;
    self.dvc=nil;
    self.lvc=nil;
    self.arryData=nil;
    [aboutvc release];
    [currvc release];
    [weavc release];
    [vvc release];
    [lvc release];
    [dvc release];
    [arryData release];
}
-(void)dealloc
{
    [aboutvc release];
    [currvc release];
    [weavc release];
    [vvc release];
    [dvc release];
    [lvc release];
    [arryData release];
    [super dealloc];
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
    return [arryData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.arryData 
                           objectAtIndex: [indexPath row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    Reachability *r = [Reachability reachabilityWithHostName:@"www.lingoomtang.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if (indexPath.row == 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            if(self.currvc == nil) {
                Currency *curr =
                [[Currency alloc] initWithNibName:@"Currency" bundle:[NSBundle mainBundle]];
                self.currvc = curr;
                [curr release];	
            }
            [self.navigationController pushViewController:self.currvc animated:YES];
        }
	}
    if (indexPath.row == 1) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            if(self.weavc == nil) {
                Weather *wea =
                [[Weather alloc] initWithNibName:@"Weather" bundle:[NSBundle mainBundle]];
                self.weavc = wea;
                [wea release];	
            }
            [self.navigationController pushViewController:self.weavc animated:YES];
        }
	}
    if (indexPath.row == 2) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            if(self.dvc == nil) {
                DocumentMain *v =
                [[DocumentMain alloc] initWithNibName:@"DocumentMain" bundle:[NSBundle mainBundle]];
                self.dvc = v;
                [v release];	
            }
            [self.navigationController pushViewController:self.dvc animated:YES];
        }
	}
    if (indexPath.row == 3) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            if(self.lvc == nil) {
                LuggageMain *v =
                [[LuggageMain alloc] initWithNibName:@"LuggageMain" bundle:[NSBundle mainBundle]];
                self.lvc = v;
                [v release];	
            }
            [self.navigationController pushViewController:self.lvc animated:YES];
        }
	}
    if (indexPath.row == 4) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"เกิดข้อผิดพลาด" message:@"กรุณาเชื่อมต่อกับเครือข่ายอินเตอร์เน็ต" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ตกลง", nil];
            [alert show];
            [alert release];
        }
        else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            if(self.vvc == nil) {
                VisaMain *v =
                [[VisaMain alloc] initWithNibName:@"VisaMain" bundle:[NSBundle mainBundle]];
                self.vvc = v;
                [v release];	
            }
            [self.navigationController pushViewController:self.vvc animated:YES];
        }
	}
    if (indexPath.row == 5) {
        if(self.aboutvc == nil) {
            About *about =
            [[About alloc] initWithNibName:@"About" bundle:[NSBundle mainBundle]];
            self.aboutvc = about;
            [about release];	
        }
        [self.navigationController pushViewController:self.aboutvc animated:YES];
	}
    [aboutvc release];
    [currvc release];
    [weavc release];
    [vvc release];
    [lvc release];
    [dvc release];
    [arryData release];
    aboutvc=nil;
    currvc=nil;
    weavc=nil;
    vvc=nil;
    lvc=nil;
    dvc=nil;
    arryData=nil;
}
@end
