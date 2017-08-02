//
//  MessageItem.h
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItem : NSObject

-(id)yourMessage:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent;
-(id)hisMessage:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent;
-(id)hisMessageAttach:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent attachURL:(NSArray*)_attach;
-(id)yourMessageAttach:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent attachURL:(NSArray*)_attach;

@end
