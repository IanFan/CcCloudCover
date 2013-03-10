//
//  CloudCover.m
//  MathCloud
//
//  Created by Ian Fan on 10/03/13.
//
//

#import "CloudCover.h"

@implementation CloudCover
@synthesize currentCloudAmount=_currentCloudAmount;

#pragma mark - Control

-(void)setChangeWithEditAmount:(int)editAmount {
  _currentCloudAmount += editAmount;
  
  if (_currentCloudAmount >=8) {
    _currentCloudAmount = 8;
  }else if (_currentCloudAmount <=0){
    _currentCloudAmount = 0;
    
    //delegate Zero
  }
  
  for (int i=0; i<[_oktaArray count]; i++) {
    CCSprite *targetSprite = [_oktaArray objectAtIndex:i];
    
    if (i <= _currentCloudAmount) {
      if (targetSprite.opacity != 255) {
        [targetSprite runAction:[CCFadeTo actionWithDuration:0.35 opacity:255]];
      }
    }
    else if (targetSprite.opacity != 0){
      [targetSprite runAction:[CCFadeTo actionWithDuration:0.35 opacity:0]];
    }
    
  }
  
}

-(void)setIsObservable:(BOOL)isObservable {
  
}

-(void)setCloudCoverStyle:(CloudCoverStyle)style {
  
}

#pragma mark - Init

-(void)setupCloudCoverWithParentLayer:(CCLayer *)parentL position:(CGPoint)position sizeLength:(float)sizeLength style:(CloudCoverStyle)style cloudAmount:(int)cloudAmount {
  _parentLayer = parentL;
  _currentCloudAmount = cloudAmount;

  _oktaArray = [[NSMutableArray alloc]init];
  
  NSString *s0;
  NSString *s1;
  NSString *s2;
  NSString *s3;
  NSString *s4;
  NSString *s5;
  NSString *s6;
  NSString *s7;
  NSString *s8;
  NSString *s9;
  
  if (style == CloudCoverStyle_Simple) {
    s0 = @"cloudCover_sim_bg.png";
    s1 = @"cloudCover_sim_1.png";
    s2 = @"cloudCover_sim_2.png";
    s3 = @"cloudCover_sim_3.png";
    s4 = @"cloudCover_sim_4.png";
    s5 = @"cloudCover_sim_5.png";
    s6 = @"cloudCover_sim_6.png";
    s7 = @"cloudCover_sim_7.png";
    s8 = @"cloudCover_sim_8.png";
    s9 = @"cloudCover_sim_circle.png";
  }
  
  CCSprite *simple0 = [CCSprite spriteWithFile:s0];
  float scale = sizeLength/simple0.boundingBox.size.width;
  simple0.scale = scale;
  simple0.position = position;
  [_oktaArray addObject:simple0];
  [_parentLayer addChild:simple0];
  
  CCSprite *simple1 = [CCSprite spriteWithFile:s1];
  simple1.scale = scale;
  simple1.position = position;
  [_oktaArray addObject:simple1];
  [_parentLayer addChild:simple1];
  
  CCSprite *simple2 = [CCSprite spriteWithFile:s2];
  simple2.scale = scale;
  simple2.position = position;
  [_oktaArray addObject:simple2];
  [_parentLayer addChild:simple2];
  
  CCSprite *simple3 = [CCSprite spriteWithFile:s3];
  simple3.scale = scale;
  simple3.position = position;
  [_oktaArray addObject:simple3];
  [_parentLayer addChild:simple3];
  
  CCSprite *simple4 = [CCSprite spriteWithFile:s4];
  simple4.scale = scale;
  simple4.position = position;
  [_oktaArray addObject:simple4];
  [_parentLayer addChild:simple4];
  
  CCSprite *simple5 = [CCSprite spriteWithFile:s5];
  simple5.scale = scale;
  simple5.position = position;
  [_oktaArray addObject:simple5];
  [_parentLayer addChild:simple5];
  
  CCSprite *simple6 = [CCSprite spriteWithFile:s6];
  simple6.scale = scale;
  simple6.position = position;
  [_oktaArray addObject:simple6];
  [_parentLayer addChild:simple6];
  
  CCSprite *simple7 = [CCSprite spriteWithFile:s7];
  simple7.scale = scale;
  simple7.position = position;
  [_oktaArray addObject:simple7];
  [_parentLayer addChild:simple7];
  
  CCSprite *simple8 = [CCSprite spriteWithFile:s8];
  simple8.scale = scale;
  simple8.position = position;
  [_oktaArray addObject:simple8];
  [_parentLayer addChild:simple8];
  
  CCSprite *circle = [CCSprite spriteWithFile:s9];
  circle.scale = scale;
  circle.position = position;
  [_parentLayer addChild:circle];
  
  
  [self setChangeWithEditAmount:0];
}

-(id) init {
	if( (self = [super init]) ) {
	}
  
	return self;
}

- (void) dealloc {
	[super dealloc];
}

@end
