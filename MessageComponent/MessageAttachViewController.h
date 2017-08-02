//
//  MessageAttachViewController.h
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Component.h"

@interface MessageAttachViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate> {
    UIView*loaderMessageView;
    UIView*viewWriteMessage;
    UITextField*fieldWriteMessage;
    UILabel*placeholderLable;
    UITextView* textViewYourMessage;
    UIScrollView*scrollContent;
    UIControl*controlPlusView;
    int cameraId;
    NSMutableArray*aryImages;
    UIView*loadingPhoto;
    int countPhoto;
    int xx;
    int yy;
    int selectDelete;
    Boolean isFirst;
    int ySizeWr;
    Boolean valid;
    Boolean hasPanding;
    Boolean isFirstOpenKeyboard;
    CGRect keyboardFrameBeginRect;
    
}
@property (nonatomic,strong) NSString* seletedId;


@end
