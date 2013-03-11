//
//  CloudCover.m
//  MathCloud
//
//  Created by Ian Fan on 10/03/13.
//
//

#import "CloudCover.h"

#define CLOUDCOVER_OKTA_FADE_TIME 0.0

@implementation CloudCover
@synthesize currentCloudAmount=_currentCloudAmount,cloudCoverStyle = _cloudCoverStyle, position=_position, length=_length;

#pragma mark - Control

-(void)changeOktaWithEditAmount:(int)editAmount {
  _currentCloudAmount += editAmount;
  
  //amount max is 8, min is 0
  if (_currentCloudAmount >=8) _currentCloudAmount = 8;
  else if (_currentCloudAmount <=0) _currentCloudAmount = 0;
  
  NSLog(@"_currentCloudAmount =%d",_currentCloudAmount);
  
  //delegate amount changed
  if ([self.cloudCoverDelegate respondsToSelector:@selector(cloudCoverDelegateAmountChangedWithCloudCover:)] == YES) {
    [self.cloudCoverDelegate cloudCoverDelegateAmountChangedWithCloudCover:self];
  }
  
  [self changeOktaWithIsObservable:_isObservable];
}

-(void)changeOktaWithIsObservable:(BOOL)isObservable {
  _isObservable = isObservable;
  
  if (isObservable == YES) {
    //hide unkownSimbol
    [[_oktaArray objectAtIndex:9] runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:0]];
    
    //show oktas
    switch (_cloudCoverStyle) {
      case CloudCoverStyle_Simple: {
        for (int i=0; i<=8; i++) {
          CCSprite *targetSprite = [_oktaArray objectAtIndex:i];
          if (i <= _currentCloudAmount) [targetSprite runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:255]];
          else [targetSprite runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:0]];
        }
      } break;
        
      case CloudCoverStyle_Meteorology: {
        for (int i=0; i<=8; i++) {
          CCSprite *targetSprite = [_oktaArray objectAtIndex:i];
          if (i == _currentCloudAmount) [targetSprite runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:255]];
          else [targetSprite runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:0]];
        }
      } break;
        
      default: break;
    }
  }
  
  else {
    //show unkownsimbol
    [[_oktaArray objectAtIndex:9] runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:255]];
    
    //hide oktas
    for (int i=0; i<=8; i++) {
      CCSprite *targetSprite = [_oktaArray objectAtIndex:i];
      [targetSprite runAction:[CCFadeTo actionWithDuration:CLOUDCOVER_OKTA_FADE_TIME opacity:0]];
    }
  }
  
}

-(void)changeStyleWithCloudCoverStyle:(CloudCoverStyle)style {
  if (_cloudCoverStyle != style) {
    _cloudCoverStyle = style;
    [self setupOktaArray];
  }
}

#pragma mark - Init

-(void)setupOktaArray {
  if (_oktaArray == nil) _oktaArray = [[NSMutableArray alloc]init];
  else {
    for (CCSprite *targetSprite in _oktaArray) [_parentLayer removeChild:targetSprite cleanup:YES];
    [_oktaArray removeAllObjects];
  }
  
  CCSprite *scaleSprite = [CCSprite spriteWithFile:@"cloudCover_bg.png"];
  float scale = _length/scaleSprite.boundingBox.size.width;
  
  NSString *s1;
  NSString *s2;
  NSString *s3;
  NSString *s4;
  NSString *s5;
  NSString *s6;
  NSString *s7;
  NSString *s8;
  
  switch (_cloudCoverStyle) {
    case CloudCoverStyle_Simple: {
      s1 = @"cloudCover_sim_1.png";
      s2 = @"cloudCover_sim_2.png";
      s3 = @"cloudCover_sim_3.png";
      s4 = @"cloudCover_sim_4.png";
      s5 = @"cloudCover_sim_5.png";
      s6 = @"cloudCover_sim_6.png";
      s7 = @"cloudCover_sim_7.png";
      s8 = @"cloudCover_sim_8.png";
    }break;
      
    case CloudCoverStyle_Meteorology: {
      s1 = @"cloudCover_meteor_1.png";
      s2 = @"cloudCover_meteor_2.png";
      s3 = @"cloudCover_meteor_3.png";
      s4 = @"cloudCover_meteor_4.png";
      s5 = @"cloudCover_meteor_5.png";
      s6 = @"cloudCover_meteor_6.png";
      s7 = @"cloudCover_meteor_7.png";
      s8 = @"cloudCover_meteor_8.png";
    }break;
      
    default: break;
  }
  
  [self setupOktaWithPngName:@"cloudCover_bg.png" scale:scale position:_position opacity:255];
  [self setupOktaWithPngName:s1 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s2 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s3 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s4 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s5 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s6 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s7 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:s8 scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:@"cloudCover_unknown.png" scale:scale position:_position opacity:0];
  [self setupOktaWithPngName:@"cloudCover_circle.png" scale:scale position:_position opacity:255];
  
  [self changeOktaWithEditAmount:0];
}

-(void)setupOktaWithPngName:(NSString*)pngName scale:(float)scale position:(CGPoint)position opacity:(int)opacity {
  CCSprite *sprite = [CCSprite spriteWithFile:pngName];
  sprite.scale = scale;
  sprite.position = position;
  sprite.opacity = opacity;
  [_oktaArray addObject:sprite];
  [_parentLayer addChild:sprite];
}

-(void)setupCloudCoverWithParentLayer:(CCLayer *)parentL position:(CGPoint)position sizeLength:(float)sizeLength style:(CloudCoverStyle)style cloudAmount:(int)cloudAmount isObservable:(BOOL)isObservable {
  _parentLayer = parentL;
  _position = position;
  _length = sizeLength;
  _cloudCoverStyle = style;
  _currentCloudAmount = cloudAmount;
  _isObservable = isObservable;

  [self setupOktaArray];
}

-(id) init {
	if( (self = [super init]) ) {
	}
  
	return self;
}

- (void) dealloc {
  for (CCSprite *sprite in _oktaArray) [_parentLayer removeChild:sprite cleanup:YES];
  [_oktaArray release];
  
	[super dealloc];
}

@end
