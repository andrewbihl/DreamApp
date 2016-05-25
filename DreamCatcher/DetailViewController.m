//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by Andrew Bihl on 4/26/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"


@interface DetailViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.descriptionString;
    self.title = self.titleString;
}

-(void)viewWillDisappear:(BOOL)animated{
    NSString* newDescription = self.textView.text;
    [self.delegate editDescription:newDescription];
}


@end
