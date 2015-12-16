//
//  ViewController.m
//  ChileDataAnalysis
//
//  Created by tang on 15/12/16.
//  Copyright © 2015年 shunzhitang. All rights reserved.
//

#import "ViewController.h"

// 宏定义请求的URL
#define URL  @"https://api.quienllama.cl/v2"

#define strUrl @"http://m.163.com/special/newsclient/iphone_notice.html"
@interface ViewController () <NSURLConnectionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      
      //给这个控制器增加一些颜色
      self.view.backgroundColor = [[UIColor alloc]initWithRed:1 green:1 blue:130/255.0 alpha:1.0];
}

//点击屏幕请求数据
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
      
//      NSLog(@" %@" , [self params]);
      
      
      
      NSString * str = [NSString stringWithFormat:@""];
      
      //网络请求
      
      NSURL *url = [NSURL URLWithString:URL];
      
//      NSURLRequest *request =  [NSURLRequest requestWithURL:url];
      
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
      
      request.HTTPMethod = @"POST";
      
      NSDictionary *parmas = [self params];
      [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
      
      [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
      NSData *data = [NSJSONSerialization dataWithJSONObject:parmas options:NSJSONWritingPrettyPrinted error:nil];
      
      request.HTTPBody = data;
      
    
      //直接发送
//      [NSURLConnection connectionWithRequest:request delegate:self];
      
      //需要使用 post请求
      
      
      [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            NSLog(@"response = %@" ,response);
            
            NSLog(@"connectionError %@" , connectionError);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@" dict = %@" , dict);
      }];
}

- (NSDictionary *)params{
      
      NSDictionary *data= @{@"d": @"00000000-5f28-bd8e-ab43-a54f4ead5956",@"phones":@[@"33316231",@"01533000",@"51698285",@"91629357",@"31130222",@"77320307",@"92438606",@"37072824",@"77436209"],@"o":@1,@"s":@19,@"so":@1,@"v":@3102};
      
      return data;
}

/**
      实现URLConnection的代理
*/

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
      NSLog(@"-----------");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
     
      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
      
       NSLog(@"%@" , dic);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
      
      NSLog(@"%@" , error);
}
@end
