//
//  ViewController.m
//  PleaseBaoMe
//
//  Created by why on 7/7/15.
//  Copyright (c) 2015 why. All rights reserved.
//

#import "ViewController.h"
#import "PBMDemoTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PBMDemoTool setupDemoData];
    _tipLabel.text = [PBMTool URL];
}

@end
