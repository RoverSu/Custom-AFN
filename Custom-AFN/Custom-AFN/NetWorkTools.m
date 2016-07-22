//
//  NetWorkTools.m
//  Custom-AFN
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NetWorkTools.h"
//网络工具协议
@protocol NetworkToolsProxy <NSObject>

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end
//遵守协议,利用OC的漏洞,来使用AFN的私有方法
@interface NetWorkTools ()<NetworkToolsProxy>

@end

@implementation NetWorkTools
+(instancetype)sharedTools{
    
    static NetWorkTools *tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://httpbin.org/"];
        
        tools = [[self alloc]initWithBaseURL:baseURL];
        
        //设置反序列化格式
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return tools;
}

-(void)request:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(void (^)(id, NSError *))finished{
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    //本类中没有实现此方法，但是父类实现了。调用的时候，直接调用父类方法
    [self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        finished(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        finished(nil,error);
    }];
    
}
@end
