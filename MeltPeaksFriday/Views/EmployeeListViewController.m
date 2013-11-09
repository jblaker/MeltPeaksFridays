//
//  EmployeeListViewController.m
//  MeltPeaksFriday
//
//  Created by Jeremy Blaker on 11/8/13.
//  Copyright (c) 2013 meltmedia. All rights reserved.
//

#import "EmployeeListViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "MBProgressHUD.h"

@interface EmployeeListViewController () {
  MBProgressHUD *_hud;
  int _goingCount;
}

@end

@implementation EmployeeListViewController

@synthesize isGoingSwitch=_isGoingSwitch, goingLabel=_goingLabel;

#pragma mark - Parse Methods

- (PFQuery *)queryForTable {
  
  if( ![PFUser currentUser] ) {
    return nil;
  }
  
  PFQuery *query = [PFUser query];
  [query orderByAscending:kEmployeeNameKey];
  
  [query setCachePolicy:kPFCachePolicyNetworkElseCache];
  
  return query;
  
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
  
  static NSString *identifier = @"EmployeeCell";
  
  PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  NSString *userDecision;
  NSString *employeeName = [object objectForKey:kEmployeeNameKey];
  
  if( [[object objectForKey:kEmployeeHasDecidedKey] boolValue] ) {
    
    if ( [[object objectForKey:kEmployeeGoingKey] boolValue] ) {
      userDecision = @"is going";
    } else {
      userDecision = @"is not going";
    }
    
  } else {
    userDecision = @"has not decided";
  }
  
  [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", employeeName, userDecision]];

  return cell;
  
}

- (void)objectsDidLoad:(NSError *)error {
  [super objectsDidLoad:error];
  [self updateGoingLabel];
}

#pragma mark - View Life Methods

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  // If there is no user object user must log in
  if (![PFUser currentUser]) {
    [self showLoginView];
  } else {
    BOOL isUserGoing = [[[PFUser currentUser] objectForKey:kEmployeeGoingKey] boolValue];
    [_isGoingSwitch setOn:isUserGoing];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setTitle:@"melt Peaks Fridays"];
  [_goingLabel setText:@"Please wait..."];
  _goingCount = 0;
  [self setupBarButtonItems];
}

#pragma mark - Helper Methods

- (void)setupBarButtonItems {
  UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutUser)];
  self.navigationItem.rightBarButtonItem = logout;
}

- (void)logoutUser {
  [PFUser logOut];
  [self showLoginView];
}

- (void)updateGoingLabel {
  
  _goingCount = 0;
  
  [[self objects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([[obj objectForKey:kEmployeeGoingKey] boolValue]) {
      _goingCount++;
    }
  }];
  
  switch(_goingCount) {
    case 1:
      [_goingLabel setText:[NSString stringWithFormat:@"There is 1 person going to Peaks"]];
      break;
    default:
      [_goingLabel setText:[NSString stringWithFormat:@"There are %i people going to Peaks", _goingCount]];
  }
  
}

- (void)showLoginView {
  
  // Create the log in view controller
  LoginViewController *logInViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
  [logInViewController setDelegate:self]; // Set ourselves as the delegate
  [logInViewController setFields: PFLogInFieldsDefault];
  
  // Create the sign up view controller
  SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
  [signUpViewController setDelegate:self]; // Set ourselves as the delegate
  [signUpViewController setFields:PFSignUpFieldsUsernameAndPassword|PFSignUpFieldsSignUpButton|PFSignUpFieldsAdditional];
  
  // Assign our sign up controller to be displayed from the login controller
  [logInViewController setSignUpController:signUpViewController];
  
  // Present the log in view controller
  [self presentViewController:logInViewController animated:NO completion:nil];
  
}

#pragma mark - Login/Signup Delegates

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
  [logInController dismissViewControllerAnimated:YES completion:^{
    [self loadObjects];
  }];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
  [self dismissViewControllerAnimated:YES completion:^{
    [self loadObjects];
  }];
}

#pragma mark - IBActions

- (void)didToggleSwitch:(UISwitch *)sender {
  
  _goingCount = 0;
  
  _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [_hud setLabelText:@"Saving Decision..."];
  [[PFUser currentUser] setObject:[NSNumber numberWithBool:sender.on] forKey:kEmployeeGoingKey];
  [[PFUser currentUser] setObject:[NSNumber numberWithBool:YES] forKey:kEmployeeHasDecidedKey];
  [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    [_hud hide:YES];
    [self loadObjects];
  }];
  
}

@end
