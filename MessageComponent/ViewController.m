//
//  ViewController.m
//  MessageComponent
//
//  Created by Yasin Ugurlu on 02/08/2017.
//  Copyright © 2017 Yasin Ugurlu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize groupingId;
-(void)viewDidLoad {
    [super viewDidLoad];
    goAttach=false;
    isFirstOpenKeyboard=true;
    NSLog(@"tre %@",groupingId);
    // Do any additional setup after loading the view.
    arrayMessage=[[NSMutableArray alloc]init];
    [[self navigationItem] setTitle:@"Messages"];
    
    [self listMessage];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    if(goAttach)
    {
        [self viewDidLoad];
        
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MessageDetailViewController"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

-(IBAction)clickUserContent {
    
    // if User image click go to profil detail
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main.storyboard" bundle: nil];
    ProfileDetailViewController *page = [storyboard instantiateViewControllerWithIdentifier:@"ProfileDetailViewController"];
    page.seletedId= self.seletedId;
    [self.navigationController pushViewController:page animated:YES];
    
}

-(void)listMessage{
    
    [viewStatus removeFromSuperview];
    viewStatus=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    UIImageView*imageViewProfile=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sampleMessageProfile.png"]];
    imageViewProfile.frame=CGRectMake(20, viewStatus.frame.size.height/2-(imageViewProfile.frame.size.height/2), imageViewProfile.frame.size.width, imageViewProfile.frame.size.height);
    //[viewStatus addSubview:imageViewProfile];
    
    UIImageView*profilImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, viewStatus.frame.size.height/2-(35/2), 35, 35)];
    profilImage.image=[UIImage imageNamed:@"sample1.png"];
    
    [viewStatus addSubview:profilImage];
    profilImage.layer.cornerRadius = 8;
    
    profilImage.layer.masksToBounds = true;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUserContent)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate =self;
    [profilImage setUserInteractionEnabled:YES];
    [profilImage addGestureRecognizer:singleTap];
    
    
    UILabel*labelName=[[UILabel alloc]initWithFrame:CGRectMake(profilImage.frame.size.width+profilImage.frame.origin.x+10,profilImage.frame.origin.y,100,100)];
    labelName.textAlignment=NSTextAlignmentLeft;
    [labelName setFont:[UIFont fontWithName:@"Catamaran-Bold" size:13]];
    labelName.text=self.selectedName;
    labelName.textColor=[UIColor blackColor];
    [labelName sizeToFit];
    [viewStatus addSubview:labelName];
    
    
    onlineicon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusIcon.png"]];
    onlineicon.frame=CGRectMake(labelName.frame.size.width+labelName.frame.origin.x, labelName.frame.origin.y, onlineicon.frame.size.width, onlineicon.frame.size.height);
    [viewStatus addSubview:onlineicon];
    NSString*agoStr=@"Online";
    if(self.selectedLogin){
        
        onlineicon.alpha=1;
        
        
    }
    else{
        onlineicon.alpha=0;
        NSDate*lastDate=[self dateFromISO8601DateString:self.selectedLastLoginDate];
        NSDate*nowDate=[NSDate date];
        
        //standar
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        NSDateComponents *components = [gregorian components:unitFlags
                                                    fromDate:lastDate
                                                      toDate:nowDate options:0];
        NSInteger months = [components month];
        NSInteger days = [components day];
        NSInteger hour = [components hour];
        NSInteger minute = [components minute];
        NSInteger second = [components second];

        
        
        
        if(months==0 && days==0 && hour==0 && minute==0){
            agoStr=[[NSString alloc]initWithFormat:@"%li seconds ago",(long)second];
        }
        else if(months==0 && days==0 && hour==0){
            agoStr=[[NSString alloc]initWithFormat:@"%li minutes ago",(long)minute];
        }
        else if(months==0 && days==0 ){
            agoStr=[[NSString alloc]initWithFormat:@"%li hours ago",(long)hour];
        }
        else if(months==0 ){
            agoStr=[[NSString alloc]initWithFormat:@"%li days ago",(long)days];
        }
        else {
            agoStr=[[NSString alloc]initWithFormat:@"%li months ago",(long)months];
        }
        
    }
    
    
    
    
    
    UILabel*labelActiveAgo=[[UILabel alloc]initWithFrame:CGRectMake(profilImage.frame.size.width+profilImage.frame.origin.x+10,labelName.frame.size.height+labelName.frame.origin.y-5,100,100)];
    labelActiveAgo.textAlignment=NSTextAlignmentLeft;
    [labelActiveAgo setFont:[UIFont fontWithName:@"Catamaran-Regular" size:12]];
    labelActiveAgo.text=agoStr;
    labelActiveAgo.textColor=[UIColor blackColor];
    [labelActiveAgo sizeToFit];
    [viewStatus addSubview:labelActiveAgo];
    
    
    
    
    
    //LİNE
    line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.png"]];
    line.frame=CGRectMake(20, imageViewProfile.frame.size.height+imageViewProfile.frame.origin.y+15, line.frame.size.width, line.frame.size.height);
    [viewStatus addSubview:line];
    
    [self.view addSubview:viewStatus];
    [scrollContent removeFromSuperview];
    scrollContent=[[UIScrollView alloc]initWithFrame:CGRectMake(0,line.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-(line.frame.origin.y)-self.navigationController.navigationBar.frame.size.height)];
    scrollContent.backgroundColor=[UIColor clearColor];
    
    UITapGestureRecognizer*   singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.delegate =self;
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    
    
    _height=5;
    for (int i=0; i<arrayMessage.count; i++) {
        MessageItemData*messageData=[arrayMessage objectAtIndex:i];
        MessageItem*messageItem=[[MessageItem alloc]init];
        
        if(messageData.AttachedFilePath !=(id)[NSNull null]) {
            UIControl*viewAttach = [[UIControl alloc]init];
            NSLog(@"gelen resim url %@", messageData.AttachedFilePath);
            
            if([messageData._id isEqual:@"0"]){
                
                viewAttach = [messageItem yourMessageAttach:messageData.message sender:i viewContent:self attachURL:messageData.AttachedFilePath];
                viewAttach.frame=CGRectMake(self.view.frame.size.width-viewAttach.frame.size.width, _height, viewAttach.frame.size.width, viewAttach.frame.size.height);
            }
            else{
                viewAttach = [messageItem hisMessageAttach:messageData.message sender:i viewContent:self attachURL:messageData.AttachedFilePath];
                viewAttach.frame=CGRectMake(10, _height, viewAttach.frame.size.width, viewAttach.frame.size.height);
                
            }
            viewAttach.tag=i;
            [viewAttach addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchDown];
            _height+=viewAttach.frame.size.height+10;
            [scrollContent addSubview:viewAttach];
            
        }
        
        UIView*view;
        if([messageData._id isEqual:@"0"]){
            view=[messageItem yourMessage:messageData.message sender:i viewContent:self];
            view.frame=CGRectMake(view.frame.origin.x, _height, view.frame.size.width, view.frame.size.height);
            
        }
        else{
            view=[messageItem hisMessage:messageData.message sender:i viewContent:self];
            view.frame=CGRectMake(view.frame.origin.x, _height, view.frame.size.width, view.frame.size.height);
            
            
        }
        
        UITapGestureRecognizer*   singleTapCopy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyMessage:)];
        singleTapCopy.numberOfTapsRequired = 1;
        singleTapCopy.delegate =self;
        view.tag=i;
        [view setUserInteractionEnabled:YES];
        [view addGestureRecognizer:singleTapCopy];
        
        
        _height+=view.frame.size.height+10;
        [scrollContent addSubview:view];
        
    }
    
    scrollContent.contentSize=CGSizeMake(scrollContent.frame.size.width, _height+10);
    scrollContent.contentOffset=CGPointMake(0, (_height+10)-scrollContent.frame.size.height);
    
    
    
    //write message
    [viewWriteMessage removeFromSuperview];
    viewWriteMessage=[[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-4), self.view.frame.size.width, 50)];
    viewWriteMessage.backgroundColor=UIColorFromRGB(0xFDF2DD);
    
    Component*component=[[Component alloc]init];
    
    fieldWriteMessage=[component inputMessageText:@"Tap to reply..." w:10 h:10 degate:self];
    fieldWriteMessage.frame=CGRectMake(10, viewWriteMessage.frame.size.height/2-(fieldWriteMessage.frame.size.height/2), fieldWriteMessage.frame.size.width, fieldWriteMessage.frame.size.height);
    
    
    textViewYourMessage=[[UITextView alloc]initWithFrame:CGRectMake(45, 10, fieldWriteMessage.frame.size.width, fieldWriteMessage.frame.size.height)];
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
    [btnSender addTarget:self action:@selector(clickSender) forControlEvents:UIControlEventTouchUpInside];
    [viewWriteMessage addSubview:btnSender];
    
    
    UIImage*imageAttach=[UIImage imageNamed:@"btnAttach.png"];
    UIButton* btnAtach=[[UIButton alloc]initWithFrame:CGRectMake(10, viewWriteMessage.frame.size.height/2-(imageSender.size.height/2), imageAttach.size.width, imageAttach.size.height)];
    [btnAtach setImage:imageAttach forState:UIControlStateNormal];
    [btnAtach addTarget:self action:@selector(clickAttachPlus) forControlEvents:UIControlEventTouchUpInside];
    [viewWriteMessage addSubview:btnAtach];
    
    
    [self.view addSubview:scrollContent];
    [self.view addSubview:viewWriteMessage];
    
}

-(void)clickAttachPlus {
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main.storyboard" bundle: nil];
        MessageAttachViewController *page = [storyboard instantiateViewControllerWithIdentifier:@"MessageAttachViewController"];
        page.seletedId=self.seletedId;
        [self.navigationController pushViewController:page animated:YES];
        goAttach=true;
    
}

-(void)clickImage:(UIControl*)sender {
    // when click images on the mesage list. You can open some image galery component.
}

-(void)copyMessage:(UITapGestureRecognizer*)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    MessageItemData*messageData=[arrayMessage objectAtIndex:[tapRecognizer.view tag]];
    NSLog (@"asdasdads %@",messageData.message);
    
    NSString*message=@"Message copied";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.yOffset = 250.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    
    UIPasteboard*copyMessage = [UIPasteboard generalPasteboard];
    copyMessage.string=messageData.message;
    
}

-(void)clickSender{

        // send message to service
    
        if(![textViewYourMessage.text isEqual:@""]){
            
            textViewYourMessage.frame = CGRectMake(45, 10, fieldWriteMessage.frame.size.width, fieldWriteMessage.frame.size.height);
            viewWriteMessage.frame=CGRectMake(0, (self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-4), self.view.frame.size.width, 50);
            [textViewYourMessage resignFirstResponder];
            viewWriteMessage.frame=CGRectMake(0, (self.view.frame.size.height)-50, self.view.frame.size.width, 50);
            UserData*userData=[[UserData alloc]init];
            NSDictionary*dicUser=[userData getUserData];
            NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 [dicUser objectForKey:@"Id"], @"SenderId",
                                 self.seletedId, @"ReceiverId",
                                 textViewYourMessage.text, @"Message",
                                 @"true" , @"NotSendPush",
                                 nil];
            
            
            
            connetId=2;
            [[Post alloc] Post2:tmp method:@"messages/add" self:self];
            
            
        }
    
    
}

-(void)singleTap:(UITapGestureRecognizer *)gesture {
    //handle taps
    [textViewYourMessage resignFirstResponder];
    
    textViewYourMessage.frame = CGRectMake(45, 10, fieldWriteMessage.frame.size.width, fieldWriteMessage.frame.size.height);
    viewWriteMessage.frame=CGRectMake(0, (self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-4), self.view.frame.size.width, 50);
    
}

-(void)myNotificationMethod:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    if (isFirstOpenKeyboard) {
        isFirstOpenKeyboard= false;
        [self openKeyboard];
    }
    
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
    }
    return YES;
    
    
}

-(void)textViewDidChange:(UITextView *)textView {
    if(![textViewYourMessage hasText]) {
        placeholderLable.hidden = NO;
    }
    else{
        placeholderLable.hidden = YES;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if(isFirstOpenKeyboard){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myNotificationMethod:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
    }
    
    [self openKeyboard];
    
    return YES;
    
}

-(void)openKeyboard {
    viewWriteMessage.frame= CGRectMake(0, (self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-4), self.view.frame.size.width, 60);
    textViewYourMessage.frame = CGRectMake(45, 5, fieldWriteMessage.frame.size.width, 50);
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         viewWriteMessage.frame=CGRectMake(viewWriteMessage.frame.origin.x,viewWriteMessage.frame.origin.y-keyboardFrameBeginRect.size.height-10,viewWriteMessage.frame.size.width ,viewWriteMessage.frame.size.height);
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         
                     }
     ];
    
}

-(NSDate *) dateFromISO8601DateString:(NSString *) dateString {
    NSString *numberString=dateString;
    if(dateString.length>18){
        numberString = [dateString substringWithRange:NSMakeRange(0,18)];
    }
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate * date = [dateFormatter dateFromString:numberString];
    return date;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void) animateTextField2: (UITextView*) textField up: (BOOL) up {
    if(up){
        if(self.view.frame.origin.y>-1){
            const int movementDistance = 110; // tweak as needed
            const float movementDuration = 0.3f; // tweak as needed
            
            int movement = (up ? -movementDistance : movementDistance);
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = CGRectOffset(self.view.frame, 0, movement);
            [UIView commitAnimations];
            
        }
        
    }
    else{
        if(self.view.frame.origin.y<0){
            const int movementDistance = 110; // tweak as needed
            const float movementDuration = 0.3f; // tweak as needed
            
            int movement = (up ? -movementDistance : movementDistance);
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = CGRectOffset(self.view.frame, 0, movement);
            [UIView commitAnimations];
        }
        
        
        
        
    }
}


@end
