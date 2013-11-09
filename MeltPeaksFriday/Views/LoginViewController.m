//
//  LoginViewController.m
//  MeltPeaksFriday
//
//  Created by Jeremy Blaker on 11/8/13.
//  Copyright (c) 2013 meltmedia. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[self logInView] setBackgroundColor:[UIColor whiteColor]];
  [[self logInView] setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meltmediaLogo"]]];
  [[[self logInView] usernameField] setBackgroundColor:[UIColor lightGrayColor]];
  [[[self logInView] passwordField] setBackgroundColor:[UIColor lightGrayColor]];
//  [[[self logInView] usernameField] setTextColor:[UIColor kickassGreenColor]];
//  [[[self logInView] passwordField] setTextColor:[UIColor kickassGreenColor]];
  [[[self logInView] signUpLabel] setTextColor:[UIColor blackColor]];
  [[[self logInView] signUpLabel] setShadowColor:[UIColor clearColor]];
  [[[self logInView] dismissButton] setHidden:YES];
}


@end
