//
//  Gameplay.m
//  Dinosaurz
//
//  Created by George Pearman on 4/6/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "dinosaur.h"

@implementation Gameplay
{
    CCNode *_gameplayNode;
    NSMutableArray *dinos;
}

- (id)init
{
    if (self = [super init])
    {
        [self schedule:@selector(moveDinos) interval:.015];
        [self schedule:@selector(addDino) interval:4];
    }
	return self;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    dinos = [[NSMutableArray alloc] init];
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
}

- (void)moveDinos {
    for( int i = 0; i < [dinos count]; i++ )
    {
        dinosaur* dino = [dinos objectAtIndex:i];
        dino.position = ccpSub(dino.position, ccp(.5, 0));
        
        if( dino.position.x < 0 )
        {
            [dinos removeObjectAtIndex:i--];
            [_gameplayNode removeChild:dino];
        }
    }
}

- (void) addDino {
    CCNode* dino = [CCBReader load:@"dinosaur"];
    CGPoint dinoPos = ccp(650, 70);
    dino.position = [_gameplayNode convertToNodeSpace:dinoPos];
    [_gameplayNode addChild:dino];
    [dinos addObject:dino];
}

@end
