//
//  DeviceOrientationManager.m
//  whzx
//
//  Created by Applezxk on 2020/6/22.
//  Copyright © 2020 Peng Cuishi. All rights reserved.
//

#import "DeviceOrientationManager.h"
#import <CoreMotion/CoreMotion.h>

@interface DeviceOrientationManager () {
    
    CMMotionManager *_motionManager;
}
@end
//sensitive 灵敏度
static const float sensitive = 0.77;

@implementation DeviceOrientationManager

- (instancetype)initWithDelegate:(id<DeviceOrientationDelegate>)delegate {
    self = [super init];
    if (self) {
        
        _delegate = delegate;
    }
    return self;
}
- (void)startMonitor {
    
    [self start];
}

- (void)stop {
    [_motionManager stopDeviceMotionUpdates];
}


//陀螺仪 每隔一个间隔做轮询
- (void)start{
    
    if (_motionManager == nil) {
        
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1/40.f;
    if (_motionManager.deviceMotionAvailable) {
        
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                [self performSelectorOnMainThread:@selector(deviceMotion:) withObject:motion waitUntilDone:YES];
                                            }];
    }
}
- (void)deviceMotion:(CMDeviceMotion *)motion{
    
    double x = motion.gravity.x;
    double y = motion.gravity.y;

    if (y < 0 ) {
        if (fabs(y) > sensitive) {
            if (self.currentDirection != TgDirectionPortrait) {
                self.currentDirection = TgDirectionPortrait;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:self.currentDirection];
                }
            }
        }
    }else {
        if (y > sensitive) {
            if (self.currentDirection != TgDirectionDown) {
                self.currentDirection = TgDirectionDown;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:self.currentDirection];
                }
            }
        }
    }
    if (x < 0 ) {
        if (fabs(x) > sensitive) {
            if (self.currentDirection != TgDirectionLeft) {
                self.currentDirection = TgDirectionLeft;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:self.currentDirection];
                }
            }
        }
    }else {
        if (x > sensitive) {
            if (self.currentDirection != TgDirectionRight) {
                self.currentDirection = TgDirectionRight;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:self.currentDirection];
                }
            }
        }
    }
}
@end
