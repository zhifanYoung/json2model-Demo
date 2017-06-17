//
//  ViewController.m
//  json2model
//
//  Created by zhifanYoung on 2017/6/16.
//  Copyright © 2017年 zhifanYoung. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Json2Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = @{
                          @"name": @"小李",
                          @"title": @"司机"
                          };
    Person *personModel = [Person modelWithDic:dic];
    
    NSLog(@"%@ --- %@", personModel.name, personModel.title);
    
}

@end
