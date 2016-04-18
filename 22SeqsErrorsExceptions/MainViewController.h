//
//  MainViewController.h
//  22SeqsErrorsExceptions
//
//  Created by Alejandro Gomez on 30/01/14.
//  Copyright (c) 2014 Alejandro Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *redButton;
@property (nonatomic, weak) IBOutlet UIButton *blueButton;
@property (nonatomic, weak) IBOutlet UIButton *greenButton;
@property (nonatomic, weak) IBOutlet UIButton *yellowButton;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@property (nonatomic, retain) NSMutableArray *sequencesArray;
@property (nonatomic, retain) NSMutableArray *humanArray;

@end
