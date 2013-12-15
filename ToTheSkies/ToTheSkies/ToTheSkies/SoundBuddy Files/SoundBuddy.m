//
//  SoundBuddy.m
//  AceyDucey
//
//  Created by Tony Jefferson on 9/17/13.
//  Copyright (c) 2013 Tony Jefferson. All rights reserved.
//

#import "SoundBuddy.h"
#import <AVFoundation/AVFoundation.h>


static NSString* const kBGMusic = @"SoaringHigh";
static NSString* const kJumpSound = @"jumpSound";
static NSString* const kPopSound = @"BalloonPop";
static NSString* const kRocketSound = @"rocketThrust";
static NSString* const kPlaneSound = @"planeCrash";

@implementation SoundBuddy{
    NSMutableDictionary *_dict;
    AVAudioPlayer *_player;
    float _volume;
}

- (void)preloadAllSounds{
    _volume = 0.0;
    [self playSound: kJumpSound];
    [self playSound: kPopSound];
}

-(void)setUp
{
    _dict = [NSMutableDictionary dictionary];
    [self createChannel:kBGMusic];
    [self createChannel:kJumpSound];
    [self createChannel:kPopSound];
    [self createChannel:kRocketSound];
    [self createChannel:kPlaneSound];
    [self preloadAllSounds];
}

-(void)createChannel:(NSString*)fileName{
    NSString* soundPath;
    if(fileName == kBGMusic)
    {
        soundPath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"mp3"];
    }
    else{
        soundPath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"wav"];
    }
   
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:&error];
    
    player.volume = .5;
    [player prepareToPlay];
    
    _dict[fileName] = player;
    
}

-(void) playSound:(NSString *)fileName{
    AVAudioPlayer *player = _dict[fileName];
    player.currentTime = 0;
    player.volume = _volume;
    
    //Loop forever if background music is played.
    if(fileName == kBGMusic)
    {
        player.numberOfLoops = -1;
    }
    
    [player play];
}



/*
- (void)playDrawTwoCardsSound{
    _volume = 0.5;
    [self playSound: kSoundFlipCard];
    [self performSelector:@selector(playSound:) withObject: kSoundFlipCard afterDelay:0.35];
}
*/

-(void)playPopSound{
    _volume = 0.5;
    [self playSound:kPopSound];
}

-(void)playJumpSound{
    _volume =  0.5;
    [self playSound:kJumpSound];
    //[self performSelector:@selector(playSound:) withObject: kJumpSound afterDelay:0.35];
}

-(void)playBackgroundMusic{
    _volume = 0.5;
    [self playSound:kBGMusic];
    //[self performSelector:@selector(playSound:) withObject: kBGMusic afterDelay:0.35];
}

-(void)playRocketSound {
    _volume = 0.5;
    [self playSound:kRocketSound];
}

-(void)playPlaneSound {
    _volume = 0.5;
    [self playSound:kPlaneSound];
}


@end
