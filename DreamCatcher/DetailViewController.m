//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by Andrew Bihl on 4/26/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.descriptionString;
    self.title = self.titleString;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return true;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
}
-(void)textViewDidChange:(UITextView *)textView{
    self.descriptionString = self.textView.text;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* listView = segue.destinationViewController;

    
}

@end
