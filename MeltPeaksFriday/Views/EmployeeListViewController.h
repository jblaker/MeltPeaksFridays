//
//  EmployeeListViewController.h
//  MeltPeaksFriday
//
//  Created by Jeremy Blaker on 11/8/13.
//  Copyright (c) 2013 meltmedia. All rights reserved.
//

@interface EmployeeListViewController : PFQueryTableViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UISwitch *isGoingSwitch;
@property (nonatomic, weak) IBOutlet UILabel *goingLabel;

- (IBAction)didToggleSwitch:(UISwitch *)sender;

@end
