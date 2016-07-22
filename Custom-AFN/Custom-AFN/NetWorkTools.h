//
//  NetWorkTools.h
//  Custom-AFN
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

///  网络请求枚举
typedef enum : NSUInteger{
    
    GET,
    POST,
    
}RequestMethod;

@interface NetWorkTools : AFHTTPSessionManager

+(instancetype)sharedTools;

-(void)request:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(void (^)(id result,NSError *error))finished;

@end
