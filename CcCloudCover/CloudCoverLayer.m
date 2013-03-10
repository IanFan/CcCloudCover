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

-(void)changeCloudRandamly:(ccTime)dt {
  int changeInt = arc4random()%2==0? +1:-1;
  [_cloudCover setChangeWithEditAmount:changeInt];
}

-(void)setupCloudCover {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  _cloudCover = [[CloudCover alloc]init];
  [_cloudCover setupCloudCoverWithParentLayer:self position:ccp(winSize.width/2, winSize.height/2) sizeLength:200 style:CloudCoverStyle_Simple cloudAmount:4];
}

-(void)setBackgroundLayer {
  [self addChild:[CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)] z:-1];
}

-(id)init {
  if ((self = [super init])) {
    [self setBackgroundLayer];
    
    [self setupCloudCover];
    
    [self schedule:@selector(changeCloudRandamly:) interval:0.5];
  }
  
  return self;
}

- (void) dealloc {
  [_cloudCover release];
  
	[super dealloc];
}

@end
