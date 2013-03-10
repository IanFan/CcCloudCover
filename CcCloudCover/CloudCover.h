//
//  CloudCover.h
//  MathCloud
//
//  Created by Ian Fan on 10/03/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
  CloudCoverStyle_Meteorology,
  CloudCoverStyle_Simple,
} CloudCoverStyle;

@protocol CloudCoverDelegate;

@interface CloudCover : NSObject
{
  CCLayer *_parentLayer;
  NSMutableArray *_oktaArray;
}

@property (nonatomic,assign) id <CloudCoverDelegate> cloudCoverDelegate;
@property int currentCloudAmount;

-(void)setupCloudCoverWithParentLayer:(CCLayer*)parentL position:(CGPoint)position sizeLength:(float)sizeLength style:(CloudCoverStyle)style cloudAmount:(int)cloudAmount;

//Control Methods
-(void)setIsObservable:(BOOL)isObservable;
-(void)setChangeWithEditAmount:(int)editAmount;
-(void)setCloudCoverStyle:(CloudCoverStyle)style;

@end

@protocol CloudCoverDelegate <NSObject>
@optional
-(void)cloudCoverDelegateTappedWithCloudCover:(CloudCover*)cloudCover;
-(void)cloudCoverDelegateChangedWithCloudCover:(CloudCover*)cloudCover;
@end
