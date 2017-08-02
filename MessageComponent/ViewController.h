//
//  ViewController.h
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageAttachViewController.h"
#import "MessageItemData.h"
#import "MessageItem.h"
#import "Component.h"

@interface ViewController  : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    UIView*viewWriteMessage;
    UITextField*fieldWriteMessage;
    int _height;
    UIScrollView*scrollContent;
    int connetId;
    NSMutableArray* arrayMessage;
    UIImageView*line;
    UIImageView*onlineicon;
    UIView*viewStatus;
    UITextView* textViewYourMessage;
    UILabel*placeholderLable;
    int heightAttach;
    UISegmentedControl *_segmentedControl;
    Boolean goAttach;
    Boolean valid;
    Boolean hasPanding;
    CGRect keyboardFrameBeginRect;
    Boolean isFirstOpenKeyboard;
    
    
}
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic,strong) NSString* groupingId;
@property (nonatomic,strong) NSString* seletedId;
@property (nonatomic,strong) NSString* selectedName;
@property (nonatomic,strong) NSString* selectedImage;
@property (nonatomic,strong) NSString* selectedLastLoginDate;
@property (nonatomic) Boolean selectedLogin;



@end

