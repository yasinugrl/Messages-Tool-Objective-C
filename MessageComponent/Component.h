//
//  Component.h
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Component : NSObject

-(id)inputMessageText:(NSString*)_title w:(int)_w h:(int)_h degate:(UIViewController*)_degate;
-(id)labelSubText:(NSString*)_title view:(UIView*)_view;

@end
