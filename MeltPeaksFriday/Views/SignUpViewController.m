//
//  SignUpViewController.m
//  MeltPeaksFriday
//
//  Created by Jeremy Blaker on 11/8/13.
//  Copyright (c) 2013 meltmedia. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[self signUpView] setBackgroundColor:[UIColor whiteColor]];
  [[self signUpView] setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meltmediaLogo"]]];
  [[[self signUpView] usernameField] setBackgroundColor:[UIColor lightGrayColor]];
  [[[self signUpView] passwordField] setBackgroundColor:[UIColor lightGrayColor]];
  [[[self signUpView] additionalField] setBackgroundColor:[UIColor lightGrayColor]];
  [[[self signUpView] additionalField] setPlaceholder:@"Your Name"];
//  [[[self signUpView] usernameField] setTextColor:[UIColor kickassGreenColor]];
//  [[[self signUpView] passwordField] setTextColor:[UIColor kickassGreenColor]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

@end
