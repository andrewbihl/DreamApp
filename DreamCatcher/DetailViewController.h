//
//  DetailViewController.h
//  DreamCatcher
//
//  Created by Andrew Bihl on 4/26/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@protocol DetailViewControllerDelegate <NSObject>

-(void)editDescription:(NSString*)newDescription;

@end

@interface DetailViewController : UIViewController

@property NSString* titleString;
@property NSString* descriptionString;
@property NSUInteger arrayIndex;
@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;

@end
