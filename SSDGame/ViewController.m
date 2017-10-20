//
//  ViewController.m
//  SSDGame
//
//  Created by Gong Xueqiang on 2017/10/19.
//  Copyright © 2017年 Gong Xueqiang. All rights reserved.
//

#import "ViewController.h"

CGFloat side = 50;
NSInteger const kCount = 6;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startGame];
}

- (void)startGame {
    side = ([[UIScreen mainScreen] bounds].size.width - 10 * 2) * 1.0 / kCount;
    NSMutableArray *arcArray = [[NSMutableArray alloc] init];
    for (int r = 0; r < kCount * kCount / 2; r++) {
         int random = arc4random() % kCount;
        [arcArray addObject:@(random)];
        [arcArray addObject:@(random)];
    }
    for (int i = 0; i < kCount; i++) {
        for (int j = 0; j < kCount; j++) {
            UIButton *btn = [[UIButton alloc] init];
            [UIView beginAnimations:nil context:nil];
            btn.frame = CGRectMake(200, 200, side, side);
            [UIView setAnimationDuration:1];
            btn.frame = CGRectMake(10 + side*j, 40 + side*i, side, side);
            [UIView commitAnimations];
      
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            int random = arc4random() % arcArray.count;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", arcArray[random]]];
            btn.tag = [arcArray[random] integerValue];
            [arcArray removeObjectAtIndex:random];
            [btn setImage:image forState:UIControlStateNormal];
            [self.view addSubview:btn];
        }
    }
}

- (void)btnClicked:(UIButton *)button {
    static UIButton *selectedButton = nil;
    if (selectedButton == nil) {
        selectedButton = button;
        selectedButton.enabled = NO;
    } else {
        if (selectedButton.tag == button.tag) {
            selectedButton.hidden = YES;
            button.hidden = YES;
            selectedButton = nil;
        } else {
            selectedButton.enabled = YES;
            selectedButton = nil;
        }
    }
}


@end
