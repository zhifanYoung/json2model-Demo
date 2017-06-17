//
//  NSObject+Json2Model.m
//  json2model
//
//  Created by zhifanYoung on 2017/6/16.
//  Copyright © 2017年 zhifanYoung. All rights reserved.
//

#import "NSObject+Json2Model.h"
#import <objc/runtime.h>

const char *key = "key";

@implementation NSObject (Json2Model)

+ (NSArray *)getPropertyArr {
    
    // 获取关联对象
    NSArray *proArr = objc_getAssociatedObject(self, key);
    if (proArr) return proArr; // 如果有值，直接返回
    
    // 调用运行时方法，获取类的属性列表
    /* 成员变量:
     * class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 方法:
     * class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 属性:
     * class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 协议:
     * class_copyProtocolList(__unsafe_unretained Class cls, unsigned int *outCount)
     */
    
    unsigned int count = 0;
    
    // retain, creat, copy 需要release
    objc_property_t *property_List = class_copyPropertyList([self class], &count);
    NSMutableArray *mtArr = [NSMutableArray array];
    
    // 遍历属性列表, 获取属性名称
    for (int i = 0; i < count; i ++) {
        
        objc_property_t pro = property_List[i];
        const char *proName_c = property_getName(pro);
        NSString *proName = [NSString stringWithCString:proName_c encoding:NSUTF8StringEncoding];
        [mtArr addObject:proName];
    }
    
    // 设置关联对象
     objc_setAssociatedObject(self, key, mtArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    free(property_List);
    return mtArr;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    // 实例化当前对象
    id objc = [[self alloc] init];
    
    // 获取self 的属性列表
    NSArray *proArr = [self getPropertyArr];
    
    // 遍历字典
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        // 判断 属性列表中是否包含这个 key
        if ([proArr containsObject:key]) {
            
            // 如果包含通过 KVC 赋值到 model
            [objc setValue:obj forKey:key];
        }
    }];
    return objc;
}

@end
