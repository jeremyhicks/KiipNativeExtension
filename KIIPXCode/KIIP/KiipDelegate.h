//
//  KiipDelegate.h
//  KIIP
//
//  Created by Jeremy Hicks on 9/15/12.
//  Copyright (c) 2012 Jeremy Hicks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KiipDelegate : NSObject {
	
	UIAlertView *alert;
	
    NSMutableArray *resources;
}

@property (nonatomic, retain) NSMutableArray *resources;

- (id)initKiip;
- (void)setLocation;
- (void)unlockAchievement;

@end