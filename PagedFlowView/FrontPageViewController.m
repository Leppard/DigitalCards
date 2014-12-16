//
//  FrontPageViewController.m
//  PagedFlowView
//
//  Created by Leppard on 14/11/27.
//  Copyright (c) 2014年 Taobao.com. All rights reserved.
//

#import "FrontPageViewController.h"

@interface FrontPageViewController ()

@property(strong, nonatomic)EAGLContext * context;
@property(strong, nonatomic)GLKBaseEffect * effect;

@end

@implementation FrontPageViewController

@synthesize context;
@synthesize effect;

GLfloat squareVertexData[48] = {
    1.0f, 1.0f, 0.000001f,       0.0f, 0.0f, 1.0f,     1.0f, 1.0f,
    -1.0f, 1.0f, 0.000001f,      0.0f, 0.0f, 1.0f,     0.0f, 1.0f,
    1.0f, -1.0f, 0.000001f,      0.0f, 0.0f, 1.0f,     1.0f, 0.0f,
    1.0f, -1.0f, 0.000001f,       0.0f, 0.0f, 1.0f,     1.0f, 0.0f,
    -1.0f, 1.0f, 0.000001f,      0.0f, 0.0f, 1.0f,     0.0f, 1.0f,
    -1.0f, -1.0f, 0.000001f,     0.0f, 0.0f, 1.0f,     0.0f, 0.0f,
};

GLfloat squareVertexData_Back[48] = {
    1.0f, 1.0f, -0.000001f,       0.0f, 0.0f, 1.0f,     1.0f, 1.0f,
    -1.0f, 1.0f, -0.000001f,      0.0f, 0.0f, 1.0f,     0.0f, 1.0f,
    1.0f, -1.0f, -0.000001f,      0.0f, 0.0f, 1.0f,     1.0f, 0.0f,
    1.0f, -1.0f, -0.000001f,       0.0f, 0.0f, 1.0f,     1.0f, 0.0f,
    -1.0f, 1.0f, -0.000001f,      0.0f, 0.0f, 1.0f,     0.0f, 1.0f,
    -1.0f, -1.0f, -0.000001f,     0.0f, 0.0f, 1.0f,     0.0f, 0.0f,
};


GLfloat frontAndBack = 0;
GLfloat rotateAngle = 0;
int startRotate = 0;
int rotateTimes = 0;

- (IBAction)rotate:(id)sender {
    startRotate = 1;
    frontAndBack = 0;
    rotateTimes ++;
    [self update];
}

- (IBAction)backToCardSelect:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)phoneButtonPressed:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger index ;
    index = [userDefault integerForKey:@"IndexTapOn"];
    
    DataModel *dataModel = [[DataModel alloc]init];
    [dataModel initializeCardsList];
    PersonalInformation *p = dataModel.cardsList[index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"tel://%@",p.telephone]]];
}
- (IBAction)messageButtonPressed:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger index = [userDefault integerForKey:@"IndexTapOn"];
    
    DataModel *dataModel = [[DataModel alloc]init];
    [dataModel initializeCardsList];
    PersonalInformation *p = dataModel.cardsList[index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"sms://%@",p.telephone]]];
}
- (IBAction)emailButtonPressed:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger index = [userDefault integerForKey:@"IndexTapOn"];
    
    DataModel *dataModel = [[DataModel alloc]init];
    [dataModel initializeCardsList];
    PersonalInformation *p = dataModel.cardsList[index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"mailto://%@",p.email]]];
}
- (IBAction)locationButtonPressed:(id)sender {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //init
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView * view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:context];
    glEnable(GL_DEPTH_TEST);
    
    self.effect = [[GLKBaseEffect alloc]init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    //get image with text
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger index ;
    index = [userDefault integerForKey:@"IndexTapOn"];

    
    DataModel *dataModel = [[DataModel alloc]init];
    [dataModel initializeCardsList];
    PersonalInformation *p = dataModel.cardsList[index];

    UIImage *img = p.photo;
    
    CGSize size = CGSizeMake(581, 775);
    UIImage *image = [self OriginImage:img scaleToSize:size];
    UIImageView *tmpImgView=[[UIImageView alloc] initWithImage:image];
    UIImage *theImage = [self captureView:tmpImgView frame:CGRectMake(0, 0, 581, 581)];// 切割尺寸
    
    
    
    NSArray *imgArray = [[NSArray alloc] initWithObjects:
                         theImage,
                         [UIImage imageNamed:@"3.png"],
                         [UIImage imageNamed:@"close.png"],
                         nil];
    
    NSArray *imgPointArray = [[NSArray alloc] initWithObjects:
                              @"31", @"106",
                              @"31", @"609",
                              @"546", @"122",
                              nil];
    
    
    UIImage *newImage = [self mergedImageOnMainImage:[UIImage imageNamed:@"1.png"] WithImageArray:imgArray AndImagePointArray:imgPointArray];

    
    NSString *name = p.name;
    NSString *company = p.company;
    NSString *position = p.position;
    
    newImage = [self addFrontText:newImage name:name company:company position:position];
    
    NSData *imgData = UIImageJPEGRepresentation(newImage, 1.0);
    
    //vertex data
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 0);
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 12);
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 24);
    
    //texture
    //NSString * filePath = [[NSBundle mainBundle]pathForResource:@"CardBackground" ofType:@"jpg"];
    NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo * textureInfo = [GLKTextureLoader textureWithContentsOfData:imgData options:options error:nil];
    
    
    
    
    
    
    //    glEnable(GL_CULL_FACE);
    //
    //    glCullFace(GL_BACK);
    
    
    self.effect.texture2d0.enabled = GL_TRUE;
    self.effect.texture2d0.name = textureInfo.name;
    
    
}

- (void)update {
    
    GLKMatrix4 projectionMatrix = GLKMatrix4Identity;
    
    if (rotateTimes%2 == 0) {
        if(frontAndBack == 90) {
            //vertex data
            //get image with text
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSInteger index ;
            index = [userDefault integerForKey:@"IndexTapOn"];
            
            
            DataModel *dataModel = [[DataModel alloc]init];
            [dataModel initializeCardsList];
            PersonalInformation *p = dataModel.cardsList[index];
            
            UIImage *img = p.photo;
            
            CGSize size = CGSizeMake(581, 775);
            UIImage *image = [self OriginImage:img scaleToSize:size];
            UIImageView *tmpImgView=[[UIImageView alloc] initWithImage:image];
            UIImage *theImage = [self captureView:tmpImgView frame:CGRectMake(0, 0, 581, 581)];// 切割尺寸
            
            
            
            NSArray *imgArray = [[NSArray alloc] initWithObjects:
                                 theImage,
                                 [UIImage imageNamed:@"3.png"],
                                 [UIImage imageNamed:@"close.png"],
                                 nil];
            
            NSArray *imgPointArray = [[NSArray alloc] initWithObjects:
                                      @"31", @"106",
                                      @"31", @"609",
                                      @"546", @"122",
                                      nil];
            
            
            UIImage *newImage = [self mergedImageOnMainImage:[UIImage imageNamed:@"1.png"] WithImageArray:imgArray AndImagePointArray:imgPointArray];

            
            NSString *name = p.name;
            NSString *company = p.company;
            NSString *position = p.position;
            newImage = [self addFrontText:newImage name:name company:company position:position];
            
            NSData *imgData = UIImageJPEGRepresentation(newImage, 1.0);
            
            //vertex data
            GLuint buffer;
            glGenBuffers(1, &buffer);
            glBindBuffer(GL_ARRAY_BUFFER, buffer);
            glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
            
            glEnableVertexAttribArray(GLKVertexAttribPosition);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 0);
            
            glEnableVertexAttribArray(GLKVertexAttribNormal);
            glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 12);
            
            glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
            glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 24);
            
            //texture
            //NSString * filePath = [[NSBundle mainBundle]pathForResource:@"CardBackground" ofType:@"jpg"];
            NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],GLKTextureLoaderOriginBottomLeft, nil];
            GLKTextureInfo * textureInfo = [GLKTextureLoader textureWithContentsOfData:imgData options:options error:nil];
            
            
            self.effect.texture2d0.enabled = GL_TRUE;
            self.effect.texture2d0.name = textureInfo.name;
            
        }
    }
    
    
    
    if (rotateTimes%2 == 1) {
        if(frontAndBack == 90) {
            //vertex data
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSInteger index ;
            index = [userDefault integerForKey:@"IndexTapOn"];
            
            DataModel *dataModel = [[DataModel alloc]init];
            [dataModel initializeCardsList];
            PersonalInformation *p = dataModel.cardsList[index];
            UIImage *img = [UIImage imageNamed:@"Back.png"];
            
            NSString *phone = [[NSString alloc]initWithFormat:@"%@",p.telephone];
            NSString *email = p.email;
            NSString *address = p.address;
            
            img = [self addBackText:img phone:phone email:email address:address];
            
            NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
            
            
            GLuint buffer_Back;
            glGenBuffers(1, &buffer_Back);
            glBindBuffer(GL_ARRAY_BUFFER, buffer_Back);
            glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData_Back), squareVertexData_Back, GL_STATIC_DRAW);
            
            glEnableVertexAttribArray(GLKVertexAttribPosition);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 0);
            
            glEnableVertexAttribArray(GLKVertexAttribNormal);
            glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 12);
            
            glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
            glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL + 24);
            
            //texture
            NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],GLKTextureLoaderOriginBottomLeft, nil];
            GLKTextureInfo * textureInfo = [GLKTextureLoader textureWithContentsOfData:imgData options:options error:nil];
            
            projectionMatrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(180), 0.0, 1.0, 0.0);
            self.effect.transform.projectionMatrix = projectionMatrix;
            
            
            self.effect.texture2d0.enabled = GL_TRUE;
            self.effect.texture2d0.name = textureInfo.name;
            
        }
    }
    
    if(startRotate == 1) {
        if (frontAndBack==90) {
            rotateAngle += 180;
        }
        if(frontAndBack < 180) {
            projectionMatrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(0.0 + rotateAngle), 0.0, 1.0, 0.0);
        }
        else {
            startRotate = 0;
            return;
        }
        frontAndBack += 5.0;
        rotateAngle += 5.0;
        self.effect.transform.projectionMatrix = projectionMatrix;
        
    }
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    
    [self.effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
}

-(UIImage *)addFrontText:(UIImage *)img
                    name:(NSString *)n
                 company:(NSString *)c
                position:(NSString *)p{
    //上下文的大小
    int width = img.size.width;
    int height = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), img.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    //    a = [NSString stringWithFormat:@"%d", width];
    char* name = (char *)[n cStringUsingEncoding:NSASCIIStringEncoding];
    char* company = (char *)[c cStringUsingEncoding:NSASCIIStringEncoding];
    char* position = (char *)[p cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Helvetica", 30, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 0.4667, 0.4902, 0.5294, 1);//设置字体绘制的颜色
    
    CGContextShowTextAtPoint(context, 110, 330, name, strlen(name));//设置字体绘制的位置

    CGContextShowTextAtPoint(context, 110, 180, position, strlen(position));
    
    CGContextSetRGBFillColor(context, 1, 0.3882, 0.3098, 1);//设置字体绘制的颜色
    CGContextShowTextAtPoint(context, 110, 230, company, strlen(company));
    
    
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
}

-(UIImage *)addBackText:(UIImage *)img
                  phone:(NSString *)p
                  email:(NSString *)e
                address:(NSString *)a {
    //上下文的大小
    int width = img.size.width;
    int height = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), img.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    //    a = [NSString stringWithFormat:@"%d", width];
    char* phone = (char *)[p cStringUsingEncoding:NSASCIIStringEncoding];
    char* email = (char *)[e cStringUsingEncoding:NSASCIIStringEncoding];
    char* address = (char *)[a cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Helvetica", 30, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 0.4667, 0.4902, 0.5294, 1);//设置字体绘制的颜色
    CGContextShowTextAtPoint(context, 190, 850, phone, strlen(phone));
    CGContextShowTextAtPoint(context, 190, 740, email, strlen(email));
    CGContextShowTextAtPoint(context, 190, 630, address, strlen(address));
    
    char* ph = (char *)[@"Phone: " cStringUsingEncoding:NSASCIIStringEncoding];
    char* em = (char *)[@"E-Mail: " cStringUsingEncoding:NSASCIIStringEncoding];
    char* ad = (char *)[@"Address: " cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Helvetica", 30, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 1, 0.3882, 0.3098, 1);//设置字体绘制的颜色
    CGContextShowTextAtPoint(context, 70, 850, ph, strlen(ph));
    CGContextShowTextAtPoint(context, 70, 740, em, strlen(em));
    CGContextShowTextAtPoint(context, 70, 630, ad, strlen(ad));
    
    
    
    
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
}


//-(void)initializeFrontImage{
//    self.frontPicture.layer.cornerRadius = self.frontPicture.frame.size.height/25;
//    self.frontPicture.clipsToBounds = YES;
//}

- (UIImage *) mergedImageOnMainImage:(UIImage *)mainImg WithImageArray:(NSArray *)imgArray AndImagePointArray:(NSArray *)imgPointArray
{
    
    UIGraphicsBeginImageContext(mainImg.size);
    
    [mainImg drawInRect:CGRectMake(0, 0, mainImg.size.width, mainImg.size.height)];
    int i = 0;
    for (UIImage *img in imgArray) {
        [img drawInRect:CGRectMake([[imgPointArray objectAtIndex:i] floatValue],
                                   [[imgPointArray objectAtIndex:i+1] floatValue],
                                   img.size.width,
                                   img.size.height)];
        
        i+=2;
    }
    
    CGImageRef NewMergeImg = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage,
                                                          CGRectMake(0, 0, mainImg.size.width, mainImg.size.height));
    
    UIGraphicsEndImageContext();
    UIImage * newImg = [UIImage imageWithCGImage:NewMergeImg];
    return newImg;
}

- (UIImage*)captureView:(UIView *)theView frame:(CGRect)frame { //截图
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, frame);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


@end
