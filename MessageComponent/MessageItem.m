//
//  MessageItem.m
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import "MessageItem.h"
#import "AsyncImageView.h"

@implementation MessageItem


-(id)yourMessageAttach:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent attachURL:(NSArray*)_attach {

    UIControl*viewAttach = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 170, 50)];
    AsyncImageView*imageView=[[AsyncImageView alloc]init];
    int xx;
    switch (_attach.count) {
        case 1:
            xx=115;
            break;
           
        case 2:
            xx=65;
            break;
            
        case 3:
            xx=0;
            break;
            
        default:
            break;
    }
    
    
    for(int i=0; i<_attach.count; i++) {
        NSString*strurl=[[NSString alloc]initWithFormat:@"%@%@",SERVER_URL,[_attach objectAtIndex:i]];
        imageView=[[AsyncImageView alloc]initWithFrame:CGRectMake(xx, 0, 50, 50)];
        imageView.imageURL=[NSURL URLWithString:strurl];
        //viewAttach.backgroundColor=UIColorFromRGB(0xE0F9CE);
 
        [viewAttach addSubview:imageView];
        xx+=53;
    }
    return viewAttach;
}

-(id)hisMessageAttach:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent attachURL:(NSArray*)_attach {

    UIControl*viewAttach = [[UIControl alloc]initWithFrame:CGRectMake(0, 0 , 170 , 50)];
    AsyncImageView*imageView=[[AsyncImageView alloc]init];
    int xx = 0;
    for(int i=0; i<_attach.count; i++) {
        NSString*strurl=[[NSString alloc]initWithFormat:@"%@%@",SERVER_URL,[_attach objectAtIndex:i]];
        imageView=[[AsyncImageView alloc]initWithFrame:CGRectMake(xx, 0, 50, 50)];
        imageView.imageURL=[NSURL URLWithString:strurl];
        //viewAttach.backgroundColor=UIColorFromRGB(0x4dc9f2);
        [viewAttach addSubview:imageView];
        
        xx+=53;
    }
    return viewAttach;
}

-(id)yourMessage:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent{
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250,20)];
    
    label.textAlignment=NSTextAlignmentLeft;
    [label setFont:[UIFont fontWithName:@"Catamaran-Regular" size:13]];
    label.text=_message;
   
    label.numberOfLines=0;
    
    CGSize labelTextSize = [label.text boundingRectWithSize:CGSizeMake(250, MAXFLOAT)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{
                                                                    NSFontAttributeName : [UIFont fontWithName:@"Catamaran-Regular" size:13]
                                                                    }
                                                          context:nil].size;
    
    
    [label sizeToFit];
    label.adjustsFontSizeToFitWidth  = YES;
    label.frame=CGRectMake(5, 0, label.frame.size.width, labelTextSize.height);
    
   
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(_viewContent.view.frame.size.width-label.frame.size.width-30, 0, label.frame.size.width+20, labelTextSize.height)];
    view.layer.cornerRadius = 7;
    view.layer.masksToBounds = true;
    view.backgroundColor=UIColorFromRGB(0x8abefa);
    [view addSubview:label];
    
    
    
    
    return view;


}

-(id)hisMessage:(NSString*)_message sender:(int)_sender viewContent:(UIViewController*)_viewContent{
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250,20)];
    label.textAlignment=NSTextAlignmentLeft;
    [label setFont:[UIFont fontWithName:@"Catamaran-Regular" size:13]];
    label.text=_message;
    
    label.numberOfLines=0;
    
    CGSize labelTextSize = [label.text boundingRectWithSize:CGSizeMake(250, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{
                                                              NSFontAttributeName : [UIFont fontWithName:@"Catamaran-Regular" size:13]
                                                              }
                                                    context:nil].size;
    
    
    [label sizeToFit];
    label.adjustsFontSizeToFitWidth  = YES;
    label.frame=CGRectMake(5, 0, label.frame.size.width, labelTextSize.height);
    
    
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, label.frame.size.width+20, labelTextSize.height)];
    view.layer.cornerRadius = 7;
    
    view.layer.masksToBounds = true;
    view.backgroundColor=UIColorFromRGB(0xfea21c);

    [view addSubview:label];
    
    
    
    
    return view;
    
    
}

@end
