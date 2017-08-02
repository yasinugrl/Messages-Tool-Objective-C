//
//  MessageAttachViewController.m
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import "MessageAttachViewController.h"
#import "AsyncImageView.h"

@interface MessageAttachViewController ()

@end

@implementation MessageAttachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Send Image"];
    aryImages=[[NSMutableArray alloc]init];
    isFirst=true;
    isFirstOpenKeyboard=true;
    
    
    [self createPage];
    
}

- (void)createPage {
    [scrollContent removeFromSuperview];
    scrollContent=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollContent.backgroundColor=[UIColor clearColor];
    
    scrollContent.contentSize=CGSizeMake(scrollContent.frame.size.width, scrollContent.frame.size.height);
    
    
    
    if(isFirst)
        ySizeWr=self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-70;
    else
        ySizeWr= self.view.frame.size.height-50;
    

    
    Component*component=[[Component alloc]init];
    
    UILabel*labelSubText=[component labelSubText:@"You can send only 3 images per message" view:self.view];
    labelSubText.frame=CGRectMake(20, 10, labelSubText.frame.size.width, labelSubText.frame.size.height);
    [scrollContent addSubview:labelSubText];
    yy = labelSubText.frame.size.height+20;
    xx=20;
    
    for (int i=0; i<aryImages.count; i++) {
        // selectedPhoto=1;
        
        
        
        UIImage*item=[aryImages objectAtIndex:i];
        
        
        UIControl*controlPhoto=[[UIControl alloc]initWithFrame:CGRectMake(xx, yy, 75, 75)];
        AsyncImageView*imageView=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
        imageView.backgroundColor=[UIColor blackColor];
        controlPhoto.tag=i;
        [controlPhoto addTarget:self action:@selector(clickStatuPhoto:) forControlEvents:UIControlEventTouchDown];
        imageView.image=item;
        [controlPhoto addSubview:imageView];
        [scrollContent addSubview:controlPhoto];
        
        xx+=100;
    }
    
    
    
    
    UIImage*btnPlusImage=[UIImage imageNamed:@"plusBlack.png"];
    UIImageView*btnViewPlus=[[UIImageView alloc]initWithImage:btnPlusImage];
    controlPlusView=[[UIControl alloc]initWithFrame:CGRectMake(xx, yy, btnPlusImage.size.width, btnPlusImage.size.height)];
    [controlPlusView addTarget:self action:@selector(clickPlusPhoto) forControlEvents:UIControlEventTouchDown];
    [controlPlusView addSubview:btnViewPlus];
    [scrollContent addSubview:controlPlusView];
    
    viewWriteMessage=[[UIView alloc]initWithFrame:CGRectMake(0, ySizeWr, self.view.frame.size.width, 50)];
    viewWriteMessage.backgroundColor=UIColorFromRGB(0xFDF2DD);
    
    
    
    
    textViewYourMessage=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-60, 30)];
    textViewYourMessage.backgroundColor=[UIColor whiteColor];
    textViewYourMessage.tag=4;
    [viewWriteMessage addSubview:textViewYourMessage];
    textViewYourMessage.delegate=self;
    
    
    placeholderLable=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 100)];
    placeholderLable.text=@"Tap to reply...";
    placeholderLable.textColor=[UIColor lightGrayColor];
        
    [placeholderLable sizeToFit];
    placeholderLable.font=[UIFont fontWithName:@"Catamaran-Regular" size:13.0];
    [textViewYourMessage addSubview:placeholderLable];
    
    UIImage*imageSender=[UIImage imageNamed:@"btnMessageSender.png"];
    UIButton* btnSender=[[UIButton alloc]initWithFrame:CGRectMake(viewWriteMessage.frame.size.width-imageSender.size.width-10, viewWriteMessage.frame.size.height/2-(imageSender.size.height/2), imageSender.size.width, imageSender.size.height)];
    [btnSender setImage:imageSender forState:UIControlStateNormal];
    [btnSender addTarget:self action:@selector(clickUploadPhotos) forControlEvents:UIControlEventTouchUpInside];
    [viewWriteMessage addSubview:btnSender];
    
    [scrollContent addSubview:viewWriteMessage];
    
    [self.view addSubview:scrollContent];
    
    
}

- (void)closeKeyboard {
    
    [textViewYourMessage resignFirstResponder];
    
    textViewYourMessage.frame= CGRectMake(10, 10, self.view.frame.size.width-60, 30);
    viewWriteMessage.frame =CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    
    
}

- (void)clickPlusPhoto {
    
    [textViewYourMessage resignFirstResponder];
    
    textViewYourMessage.frame= CGRectMake(10, 10, self.view.frame.size.width-60, 30);
    viewWriteMessage.frame =CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:nil
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Choose From Library",@"Take Photo", nil];
    message.tag=1;
    [message show];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if(cameraId==0){
        
    }
    else{
        
        
        [controlPlusView removeFromSuperview];
        
        if(aryImages.count%3==0){
            xx=20;
            
        }
        
        //[aryImages removeAllObjects];
        [aryImages addObject:chosenImage];
        
        UIControl*controlPhoto=[[UIControl alloc]initWithFrame:CGRectMake(xx, yy, 75, 75)];
        AsyncImageView*imageView=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
        controlPhoto.tag=aryImages.count-1;
        [controlPhoto addTarget:self action:@selector(clickStatuPhoto:) forControlEvents:UIControlEventTouchDown];
        imageView.backgroundColor=[UIColor blackColor];
        imageView.image=chosenImage;
        [controlPhoto addSubview:imageView];
        [scrollContent addSubview:controlPhoto];
        
        //countPhoto+=1;
        if(aryImages.count%3==0){
            xx=20;
            
        }
        else{
            xx+=100;
        }
        
        UIImage*btnPlusImage=[UIImage imageNamed:@"plusBlack.png"];
        UIImageView*btnViewPlus=[[UIImageView alloc]initWithImage:btnPlusImage];
        controlPlusView=[[UIControl alloc]initWithFrame:CGRectMake(xx, yy, btnPlusImage.size.width, btnPlusImage.size.height)];
        [controlPlusView addTarget:self action:@selector(clickPlusPhoto) forControlEvents:UIControlEventTouchUpInside];
        [controlPlusView addSubview:btnViewPlus];
        [scrollContent addSubview:controlPlusView];
        
        
        
        
    }
    
    if(aryImages.count==3){
        [controlPlusView removeFromSuperview];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)clickStatuPhoto:(UIControl*)sender{
    
    selectDelete=(int)sender.tag;
    NSLog(@"count photo %li", (long)sender.tag);
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:nil
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Delete Photo", nil];
    message.tag=99;
    [message show];
    
}

- (void)clickUploadPhotos{
    
    
    if(![textViewYourMessage.text isEqual:@""]){
        
        // Upload Photo to service, if texput is not empty.
        
        
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
    }
    return YES;
    
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if(![textViewYourMessage hasText]) {
        placeholderLable.hidden = NO;
    }
    else{
        placeholderLable.hidden = YES;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if(isFirstOpenKeyboard){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myNotificationMethod:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
    }
    
    
    [self openKeyboard];
    
    return YES;
    
}

- (void)myNotificationMethod:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    if (isFirstOpenKeyboard) {
        isFirstOpenKeyboard= false;
        [self openKeyboard];
    }
    
    
}

- (void)openKeyboard {
    viewWriteMessage.frame= CGRectMake(0, (self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-4), self.view.frame.size.width, 60);
    textViewYourMessage.frame = CGRectMake(10, 5, self.view.frame.size.width-60, 50);
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:nil
                     animations:^{
                         viewWriteMessage.frame=CGRectMake(viewWriteMessage.frame.origin.x,viewWriteMessage.frame.origin.y-keyboardFrameBeginRect.size.height-10,viewWriteMessage.frame.size.width ,viewWriteMessage.frame.size.height);
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         
                     }
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MessageDetailViewController"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

@end
