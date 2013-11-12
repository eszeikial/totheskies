//
//  ViewController.m
//  ToTheSkies
//
//  Created by Student on 11/12/13.
//  Copyright (c) 2013 Student. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "GameplayScene.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    GameplayScene *gp = [[GameplayScene alloc] initWithSize:CGSizeMake(768, 1024)];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene:gp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
