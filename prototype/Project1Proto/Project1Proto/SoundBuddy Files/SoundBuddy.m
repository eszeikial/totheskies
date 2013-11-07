//
//  SoundBuddy.m
//  AceyDucey
//
//  Created by Tony Jefferson on 9/17/13.
//  Copyright (c) 2013 Tony Jefferson. All rights reserved.
//

#import "SoundBuddy.h"
#import <AVFoundation/AVFoundation.h>

/*
static NSString* const kSoundFlipCard =  @"playCard";
static NSString* const kSoundWinHand =  @"PowerUp";
static NSString* const kSoundLoseHand =  @"badswap";
*/
static NSString* const kBGMusic = @"SoaringHigh";
static NSString* const kJumpSound = @"jumpSound";

@implementation SoundBuddy{
    NSMutableDictionary *_dict;
    AVAudioPlayer *_player;
    float _volume;
}

- (void)preloadAllSounds{
    _volume = 0.0;
    /*
    [self playSound: kSoundFlipCard];
    [self playSound: kSoundWinHand];
    [self playSound: kSoundLoseHand];
    */
}

-(void)setUp
{
    _dict = [NSMutableDictionary dictionary];
    [self createChannel:kBGMusic];
    [self createChannel:kJumpSound];
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

@end
