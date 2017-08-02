//
//  Component.m
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import "Component.h"

@implementation Component


-(id)inputMessageText:(NSString*)_title w:(int)_w h:(int)_h degate:(UIViewController*)_degate{
    
    UIImage*_image=[UIImage imageNamed:@"messegaSenderBg.png"];
    
    
    
    UITextField*filed=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, _degate.view.frame.size.width-90, _image.size.height)];
    filed.placeholder=_title;
    filed.backgroundColor=[UIColor clearColor];
    filed.background=_image;
    filed.textAlignment=NSTextAlignmentLeft;
    UIColor *color = [UIColor lightGrayColor];
    
    
    filed.attributedPlaceholder =[[NSAttributedString alloc] initWithString:_title
                                                                 attributes:@{
                                                                              NSForegroundColorAttributeName: color,
                                                                              NSFontAttributeName : [UIFont fontWithName:@"Catamaran-Regular" size:13.0]
                                                                              }
                                  ];
    
    filed.delegate=_degate;
    
    filed.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    filed.leftView = paddingView;
    filed.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    return filed;
}

-(id)labelSubText:(NSString*)_title view:(UIView*)_view{
    
    UILabel*labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0,0,_view.frame.size.width-40,100)];
    labelTitle.textAlignment=NSTextAlignmentLeft;
    [labelTitle setFont:[UIFont fontWithName:@"Catamaran-Regular" size:12]];
    labelTitle.text=_title;
    labelTitle.textColor=UIColorFromRGB(0x787878);
    
    labelTitle.numberOfLines=0;
    
    CGSize labelTextSize = [_title boundingRectWithSize:CGSizeMake(255, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{
                                                          NSFontAttributeName : [UIFont fontWithName:@"Catamaran-Regular" size:12]
                                                          }
                                                context:nil].size;
    
    
    
    [labelTitle sizeToFit];
    labelTitle.adjustsFontSizeToFitWidth  = YES;
    
    labelTitle.frame=CGRectMake(0, 0, labelTitle.frame.size.width, labelTextSize.height);
    
    
    return labelTitle;
    
}

@end
