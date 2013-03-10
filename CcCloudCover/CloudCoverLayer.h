//
//  CloudCoverLayer.h
//  CcCloudCover
//
//  Created by Ian Fan on 10/03/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "CloudCover.h"

@interface CloudCoverLayer : CCLayer <CloudCoverDelegate>
{
  CloudCover *_cloudCover;
}

+(CCScene *) scene;

@end
