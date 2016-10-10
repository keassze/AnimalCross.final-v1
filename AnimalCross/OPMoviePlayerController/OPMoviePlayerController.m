//
//  OPMoviePlayerController.m
//  OPMoviePlayerController
//
//  Created by Brandon Williams on 7/7/14.
//  Copyright (c) 2014 Opetopic. All rights reserved.
//

#import "OPMoviePlayerController.h"

static NSArray *notificationsAndSelectors;

@implementation OPMoviePlayerController

+(void) initialize {
  if (self == OPMoviePlayerController.class) {
    notificationsAndSelectors = @[
                                  @[MPMovieDurationAvailableNotification, @"durationAvailable:"],
                                  @[MPMovieMediaTypesAvailableNotification, @"mediaTypesAvailable:"],
                                  @[MPMovieNaturalSizeAvailableNotification, @"naturalSizeAvailable:"],
                                  @[MPMoviePlayerDidEnterFullscreenNotification, @"didEnterFullscreen:"],
                                  @[MPMoviePlayerDidExitFullscreenNotification, @"didExitFullscreen:"],
                                  @[MPMoviePlayerIsAirPlayVideoActiveDidChangeNotification, @"isAirPlayVideoActiveDidChange:"],
                                  @[MPMoviePlayerLoadStateDidChangeNotification, @"loadStateDidChange:"],
                                  @[MPMoviePlayerNowPlayingMovieDidChangeNotification, @"nowPlayingMovieDidChange:"],
                                  @[MPMoviePlayerPlaybackDidFinishNotification, @"playbackDidFinish:"],
                                  @[MPMoviePlayerPlaybackStateDidChangeNotification, @"playbackStateDidChange:"],
                                  @[MPMoviePlayerScalingModeDidChangeNotification, @"scalingModeDidChange:"],
                                  @[MPMoviePlayerThumbnailImageRequestDidFinishNotification, @"thumbnailImageRequestDidFinish:"],
                                  @[MPMoviePlayerWillEnterFullscreenNotification, @"willEnterFullscreen:"],
                                  @[MPMoviePlayerWillExitFullscreenNotification, @"willExitFullscreen:"],
                                  @[MPMovieSourceTypeAvailableNotification, @"sourceTypeAvailable:"],
                                  @[MPMoviePlayerReadyForDisplayDidChangeNotification, @"readyForDisplayDidChange:"],
                                  ];
  }
}

-(id) init {
  if (! (self = [super init])) {
    return nil;
  }

  for (NSArray *notificationAndSelector in notificationsAndSelectors) {
    NSString *notification = notificationAndSelector[0];
    SEL selector = NSSelectorFromString(notificationAndSelector[1]);
    if ([self respondsToSelector:selector]) {
      [NSNotificationCenter.defaultCenter addObserver:self selector:selector name:notification object:self];
    } else {
      NSAssert(NO, @"");
    }
  }

  return self;
}

-(void) dealloc {
  for (NSArray *notificationAndSelector in notificationsAndSelectors) {
    [NSNotificationCenter.defaultCenter removeObserver:self name:notificationAndSelector[0] object:self];
  }
}


-(void) durationAvailable:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerDurationAvailable:)]) {
    [self.delegate moviePlayerDurationAvailable:self];
  }
}

-(void) mediaTypesAvailable:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerMediaTypesAvailable:)]) {
    [self.delegate moviePlayerMediaTypesAvailable:self];
  }

}

-(void) naturalSizeAvailable:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerNaturalSizeAvailable:)]) {
    [self.delegate moviePlayerNaturalSizeAvailable:self];
  }
}

-(void) didEnterFullscreen:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerDidEnterFullscreen:)]) {
    [self.delegate moviePlayerDidEnterFullscreen:self];
  }
}

-(void) didExitFullscreen:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerDidExitFullscreen:)]) {
    [self.delegate moviePlayerDidExitFullscreen:self];
  }
}

-(void) isAirPlayVideoActiveDidChange:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerIsAirPlayVideoActiveDidChange:)]) {
    [self.delegate moviePlayerIsAirPlayVideoActiveDidChange:self];
  }
}

-(void) loadStateDidChange:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerLoadStateDidChange:)]) {
    [self.delegate moviePlayerLoadStateDidChange:self];
  }
}

-(void) nowPlayingMovieDidChange:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerNowPlayingMovieDidChange:)]) {
    [self.delegate moviePlayerNowPlayingMovieDidChange:self];
  }
}

-(void) playbackDidFinish:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerPlaybackDidFinish:)]) {
    [self.delegate moviePlayerPlaybackDidFinish:self];
  }
}

-(void) playbackStateDidChange:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerPlaybackStateDidChange:)]) {
    [self.delegate moviePlayerPlaybackStateDidChange:self];
  }
}

-(void) scalingModeDidChange:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerScalingModeDidChange:)]) {
    [self.delegate moviePlayerScalingModeDidChange:self];
  }
}

-(void) thumbnailImageRequestDidFinish:(NSNotification*)notification {

  UIImage *image = notification.userInfo[MPMoviePlayerThumbnailImageKey];
  NSTimeInterval time = [notification.userInfo[MPMoviePlayerThumbnailTimeKey] doubleValue];
  NSError *error = notification.userInfo[MPMoviePlayerThumbnailErrorKey];

  if (error && [self.delegate respondsToSelector:@selector(moviePlayer:thumbnailImageRequestFailedWithError:atTime:)]) {
    [self.delegate moviePlayer:self thumbnailImageRequestFailedWithError:error atTime:time];
  } else if (! error && [self.delegate respondsToSelector:@selector(moviePlayer:thumbnailImageRequestSucceededWithImage:atTime:)]) {
    [self.delegate moviePlayer:self thumbnailImageRequestSucceededWithImage:image atTime:time];
  }
}

-(void) willEnterFullscreen:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerWillEnterFullscreen:)]) {
    [self.delegate moviePlayerWillEnterFullscreen:self];
  }
}

-(void) willExitFullscreen:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerWillExitFullscreen:)]) {
    [self.delegate moviePlayerWillExitFullscreen:self];
  }
}

-(void) sourceTypeAvailable:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerSourceTypeAvailable:)]) {
    [self.delegate moviePlayerSourceTypeAvailable:self];
  }
}

-(void) readyForDisplayDidChange:(NSNotification*)notification {
  if ([self.delegate respondsToSelector:@selector(moviePlayerReadyForDisplayDidChange:)]) {
    [self.delegate moviePlayerReadyForDisplayDidChange:self];
  }
}


@end
