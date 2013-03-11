//
//  CloudCoverLayer.m
//  CcCloudCover
//
//  Created by Ian Fan on 10/03/13.
//
//

#import "CloudCoverLayer.h"

@implementation CloudCoverLayer

+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CloudCoverLayer *layer = [CloudCoverLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)changeCloud:(ccTime)dt {
  //increase okta from zero to 8, then decrease it from 8 to zero, repeatForever
  int changeInt = (isDecreasing == NO)? +1:-1;
  [_cloudCover changeOktaWithEditAmount:changeInt];
  
  if (_cloudCover.currentCloudAmount == 8) isDecreasing = YES;
  else if (_cloudCover.currentCloudAmount == 0) isDecreasing = NO;
  
  //switch Style
  if (_cloudCover.currentCloudAmount == 0) {
    if (_cloudCover.cloudCoverStyle == CloudCoverStyle_Simple) {
      [_cloudCover changeStyleWithCloudCoverStyle:CloudCoverStyle_Meteorology];
    }else {
      [_cloudCover changeStyleWithCloudCoverStyle:CloudCoverStyle_Simple];
    }
  }
  
  //switch observable randomly
//  if (arc4random()%2 == 0) [_cloudCover changeOktaWithIsObservable:NO];
//  else [_cloudCover changeOktaWithIsObservable:YES];
}

-(void)setupCloudCover {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  _cloudCover = [[CloudCover alloc]init];
  [_cloudCover setupCloudCoverWithParentLayer:self position:ccp(winSize.width/2, winSize.height/2) sizeLength:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?200:150 style:CloudCoverStyle_Simple cloudAmount:0 isObservable:YES];
}

-(void)setBackgroundLayer {
  [self addChild:[CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)] z:-1];
}

-(id)init {
  if ((self = [super init])) {
    [self setBackgroundLayer];
    
    [self setupCloudCover];
    
    [self schedule:@selector(changeCloud:) interval:0.5];
  }
  
  return self;
}

- (void) dealloc {
  [_cloudCover release];
  
	[super dealloc];
}

@end
