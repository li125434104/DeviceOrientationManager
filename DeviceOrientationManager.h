//
//  DeviceOrientationManager.h
//  whzx
//
//  Created by Applezxk on 2020/6/22.
//  Copyright © 2020 Peng Cuishi. All rights reserved.
//

//陀螺仪判断屏幕方向

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,TgDirection) {
    TgDirectionUnkown,
    TgDirectionPortrait,
    TgDirectionDown,
    TgDirectionRight,
    TgDirectionLeft,
};

NS_ASSUME_NONNULL_BEGIN

@protocol DeviceOrientationDelegate <NSObject>

- (void)directionChange:(TgDirection)direction;

@end
@interface DeviceOrientationManager : NSObject

@property(nonatomic,strong)id<DeviceOrientationDelegate>delegate;
@property (nonatomic, assign) TgDirection currentDirection;

- (instancetype)initWithDelegate:(id<DeviceOrientationDelegate>)delegate;
/**
 开启监听
 */
- (void)startMonitor;
/**
 结束监听，请stop
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
