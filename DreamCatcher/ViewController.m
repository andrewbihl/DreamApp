//
//  ViewController.m
//  DreamCatcher
//
//  Created by Andrew Bihl on 4/24/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<DetailViewControllerDelegate, UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray* titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray new];
    self.descriptions = [[NSMutableArray alloc] init];
}

-(void)editDescription:(NSString*)newDescription{
    NSLog(@"Oh shit it worked");
    NSUInteger currentDescriptionIndex =  self.tableView.indexPathForSelectedRow.row;
    [self.descriptions removeObjectAtIndex:currentDescriptionIndex];
    [self.descriptions insertObject:newDescription atIndex:currentDescriptionIndex];
    [self.tableView reloadData];
}

-(void)presentDreamEntry{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Enter new dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField* _Nonnull textField){
        textField.placeholder = @"Dream Title";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField* _Nonnull textField){
        textField.placeholder = @"Dream Description";
    }];

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"  style:UIAlertActionStyleCancel
        handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
        UITextField *textField1 = alertController.textFields.firstObject;
        [self.titles addObject:textField1.text];
        [self.descriptions addObject:alertController.textFields.lastObject.text];
        [self.tableView reloadData];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return [self.tableView numberOfRowsInSection:section];
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.descriptions objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.editing){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }
    else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    return true;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString* sourceTitle = [self.titles objectAtIndex:sourceIndexPath.row];
    NSString* sourceDescription = [self.descriptions objectAtIndex:sourceIndexPath.row];
    [self.titles insertObject:[self.titles objectAtIndex:destinationIndexPath.row] atIndex:sourceIndexPath.row+1];
    [self.titles removeObjectAtIndex:sourceIndexPath.row];
    [self.titles insertObject:sourceTitle atIndex:destinationIndexPath.row+1];
    [self.titles removeObjectAtIndex:destinationIndexPath.row];
    [self.descriptions insertObject:[self.descriptions objectAtIndex:destinationIndexPath.row] atIndex:sourceIndexPath.row+1];
    [self.descriptions removeObjectAtIndex:sourceIndexPath.row];
    [self.descriptions insertObject:sourceDescription atIndex:destinationIndexPath.row+1];
    [self.descriptions removeObjectAtIndex:destinationIndexPath.row];
    
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    [self presentDreamEntry];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titles removeObjectAtIndex:indexPath.row];
    [self.descriptions removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *dvc = segue.destinationViewController;
    dvc.titleString = [self.titles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    dvc.descriptionString = [self.descriptions objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    //dvc.arrayIndex = self.tableView.indexPathForSelectedRow.row;
    dvc.delegate = self;
}
@end