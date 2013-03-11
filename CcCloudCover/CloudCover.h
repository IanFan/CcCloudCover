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
  
  BOOL _isObservable;
}

@property (nonatomic,assign) id <CloudCoverDelegate> cloudCoverDelegate;
@property CGPoint position;
@property float length;
@property CloudCoverStyle cloudCoverStyle;
@property int currentCloudAmount;

-(void)setupCloudCoverWithParentLayer:(CCLayer*)parentL position:(CGPoint)position sizeLength:(float)sizeLength style:(CloudCoverStyle)style cloudAmount:(int)cloudAmount isObservable:(BOOL)isObservable;

//Control Methods
-(void)changeOktaWithIsObservable:(BOOL)isObservable;
-(void)changeOktaWithEditAmount:(int)editAmount;
-(void)changeStyleWithCloudCoverStyle:(CloudCoverStyle)style;

@end

@protocol CloudCoverDelegate <NSObject>
@optional
-(void)cloudCoverDelegateTappedWithCloudCover:(CloudCover*)cloudCover;
-(void)cloudCoverDelegateAmountChangedWithCloudCover:(CloudCover*)cloudCover;
@end
