//
//  MessageItemData.h
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItemData : NSObject
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSArray *AttachedFilePath;
@property (nonatomic, retain) NSString *CreateDate;
@property (nonatomic, retain) NSString *Status;
@property (nonatomic, retain) NSString *GroupingId;
@property (nonatomic, retain) NSDictionary *userDetail;







@end
