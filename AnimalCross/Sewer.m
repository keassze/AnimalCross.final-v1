//
//  Sewer.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/21.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Sewer.h"

@implementation Sewer

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super initWithImageNamed:@"sewer.png"]) {
        self.scale = 0.25f;
    }
    return self;
}




@end
