//
//  HistoryTBViewController.m
//  HeartBeatAnalyzer
//
//  Created by Armen Abrahamyan on 9/14/13.
//  Copyright (c) 2013 Sourcio. All rights reserved.
//

#import "HistoryTBViewController.h"
#import "HistoryTableViewCell.h"

@interface HistoryTBViewController ()

@end

@implementation HistoryTBViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void) hideView {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 568, 320, 568);
    }];
}

- (void) loadView {
    [super loadView];
    
    UIImageView * bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"history_bg.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = YES;
    
    self.tableView.backgroundView = bgView;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton * closeView = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 70, 50)];
    [closeView setTitle:@"Close" forState:UIControlStateNormal];
    [closeView setTitle:@"Close" forState:UIControlStateHighlighted];
    [closeView setTitle:@"Close" forState:UIControlStateSelected];
    [closeView addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    
    closeView.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    closeView.titleLabel.textColor = [UIColor whiteColor];

    self.tableView.tableHeaderView = closeView;
    
    self.tableView.delegate = self;
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEE, dd MMM YYYY HH:mm:ss"];
    //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    
    
    /*NSArray * arr = [NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"93", @"rate_result", [DateFormatter stringFromDate:[NSDate date]], @"date", @"Possible tachycardia.", @"dcease", nil]];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"heart_beats"];
    */
    
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"heart_beats"];
    
    NSLog(@"BZZ");
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"heart_beats"];
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary * currentDictionary = (NSDictionary *) [data objectAtIndex:indexPath.row];
    
    if(cell == nil) {
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell constructStructure];
    }
    
    [cell constructData:currentDictionary]; 
       
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56.0f;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
     */
}

@end
