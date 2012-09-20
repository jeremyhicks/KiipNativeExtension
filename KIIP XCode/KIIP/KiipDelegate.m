//
//  KiipDelegate.m
//  KIIP
//
//  Created by Jeremy Hicks on 9/15/12.
//  Copyright (c) 2012 Jeremy Hicks. All rights reserved.
//

#import "KiipDelegate.h"
#import "Kiip.h"


@interface KiipDelegate (Private) <KPManagerDelegate>

@end


@implementation KiipDelegate

@synthesize resources;

-(id) initKiip {
	
	// Start and initialize when application starts
    KPManager *manager = [[KPManager alloc] initWithKey:@"291e2672e9b76370209c73e817d54a15" secret:@"b59886bd69cdcf65a7e63f9fc201dd77"];
    // Set the shared instance after initialization
    // to allow easier access of the object throughout the project.
    [KPManager setSharedManager:manager];
	[manager setDelegate:self];
	
	return self;
}


- (void)setLocation {
    NSLog(@"set location");
    [[KPManager sharedManager] updateLatitude:(double)37.7753 longitude:(double)-122.4189];
}

- (void)unlockAchievement {
    NSLog(@"unlock achievement");
    [[KPManager sharedManager] unlockAchievement:@"test" withTags:[NSArray arrayWithObjects:@"movies", @"music", nil]];
}



//==============================================================================
#pragma mark -
#pragma mark KPManagerDelegate callbacks
//==============================================================================

- (void) manager:(KPManager*)manager didStartSession:(NSDictionary*)resource {
    NSLog(@"Delegate: managerDidStartSession: %@", resource);
	
    if (resource == nil) {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Kiip"
                 message:@"Session Created\n\n(No Promo)"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
    } else {
        NSMutableDictionary* reward = [NSMutableDictionary dictionaryWithDictionary:resource];
        [reward setObject:[NSNumber numberWithInt:kKPViewPosition_FullScreen] forKey:@"position"];
        [[KPManager sharedManager] presentReward:reward];
		
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Kiip"
                 message:@"Session Created\n\n(w/ Promo)"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
    }
	
    [alert show];
}

- (void) managerDidUpdateLocation:(KPManager*)manager {
    NSLog(@"Delegate: managerDidUpdateLocation");
}

- (void) managerDidEndSession:(KPManager*)manager {
    NSLog(@"Delegate: managerDidCloseSession");
}

- (void) manager:(KPManager*)manager didGetActivePromos:(NSArray*)promos {
    NSLog(@"Delegate: didGetActivePromos: %@", promos);
}

- (void) manager:(KPManager*)manager didUnlockAchievement:(NSDictionary*)resource {
    /**
     * Note: By overriding this method, we must call presentReward ourselves.
     */
    NSLog(@"Delegate: didUnlockAchievement: %@", resource);
    if(resource != nil) {
        [resources addObject:resource];
//        if(viewController.toggleAction.on) {
//            [manager presentReward:resource];
//        }
    } else {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Kiip"
                 message:@"No reward recieved"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
        [alert show];
    }
}

- (void) manager:(KPManager*)manager didUpdateLeaderboard:(NSDictionary*)resource {
    /**
     * Note: By overriding this method, we must call presentReward ourselves.
     */
    NSLog(@"Delegate: didUpdateLeaderboard: %@", resource);
    if(resource != nil) {
        [resources addObject:resource];
//        if(viewController.toggleAction.on) {
//            [manager presentReward:resource];
//        }
    } else {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Kiip"
                 message:@"No reward recieved"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
        [alert show];
    }
}

- (void) manager:(KPManager*)manager didReceiveError:(NSError*)error {
    NSLog(@"Delegate: error(%d): %@", [error code], [error userInfo]);
    alert = [[UIAlertView alloc]
             initWithTitle:[NSString stringWithFormat:@"Kiip Error: %d", [error code]]
             message:[NSString stringWithFormat:@"%@", [[error userInfo] objectForKey:NSLocalizedDescriptionKey]]
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil];
    [alert show];
}

- (void) willPresentNotification:(NSString*)rid {
    NSLog(@"Delegate: willPresentNotification");
}

- (void) didPresentNotification:(NSString*)rid {
    NSLog(@"Delegate: didPresentNotification");
}

- (void) willCloseNotification:(NSString*)rid {
    NSLog(@"Delegate: willCloseNotification");
}

- (void) didCloseNotification:(NSString*)rid {
    NSLog(@"Delegate: didCloseNotification");
}

- (void) willShowWebView:(NSString*)rid {
    NSLog(@"Delegate: willShowWebView");
}

- (void) didShowWebView:(NSString*)rid {
    NSLog(@"Delegate: didShowWebView");
}

- (void) willCloseWebView:(NSString*)rid {
    NSLog(@"Delegate: willCloseWebView");
}

- (void) didCloseWebView:(NSString*)rid {
    NSLog(@"Delegate: didCloseWebView");
}

- (void) didStartSwarm:(NSString *)leaderboard_id {
    NSLog(@"Delegate: didStartSwarm: %@", leaderboard_id);
	
    alert = [[UIAlertView alloc]
             initWithTitle:@"Kiip"
             message:[NSString stringWithFormat:@"Swarm Delegate: %@", leaderboard_id]
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil];
    [alert show];
}

- (void) didReceiveContent:(NSString*)content quantity:(int)quantity withReceipt:(NSDictionary *)receipt {
    NSLog(@"Delegate: didReceiveContent:%@ quantity:%d receipt:%@", content, quantity, receipt);
	
    alert = [[UIAlertView alloc]
             initWithTitle:@"Kiip"
             message:[NSString stringWithFormat:@"Content Delegate: %d %@", quantity, content]
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil];
    [alert show];
}

@end
