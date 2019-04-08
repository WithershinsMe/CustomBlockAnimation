//
//  ViewController.m
//  CustomBlockAnimation
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CustomBlockAnimations.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *selectView;
@end

@implementation ViewController
- (IBAction)changeColor:(UIButton *)sender {
    [UIView popAnimationWithDuration:0.7
                             animations:^{
                                 self.selectView.backgroundColor = [UIColor redColor];
                             }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
