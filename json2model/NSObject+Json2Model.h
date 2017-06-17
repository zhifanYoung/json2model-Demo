//
//  NSObject+Json2Model.h
//  json2model
//
//  Created by zhifanYoung on 2017/6/16.
//  Copyright © 2017年 zhifanYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Json2Model)

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
