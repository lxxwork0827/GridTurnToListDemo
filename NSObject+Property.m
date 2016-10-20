//
//  NSObject+Property.m
//  GridTurnToListDemo
//
//  Created by 刘星星 on 16/10/20.
//  Copyright © 2016年 刘星星. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
@implementation NSObject (Property)
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    id obj = [[self alloc]init];
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];//去除下划线
        id value = dict[key];
        if (!value) {
            if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
                NSString *replacedKey = [self replacedKeyFromPropertyName][key];
                value = dict[replacedKey];
            }
        }
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            NSRange range = [type rangeOfString:@"\""];
            type = [type substringFromIndex:range.location + range.length];
            range = [type rangeOfString:@"\""];
            type = [type substringToIndex:range.location];
            Class modelClass = NSClassFromString(type);
            if (modelClass) {
                value = [modelClass modelWithDictionary:value];
            }
        }
        // 字典嵌套数组
        if ([value isKindOfClass:[NSArray class]]) {
            if ([self respondsToSelector:@selector(objectClassInArray)]) {
                NSMutableArray *models = [NSMutableArray array];
                NSString *type = [self objectClassInArray][key];
                Class classModel = NSClassFromString(type);
                for (NSDictionary *dict in value) {
                    id model = [classModel modelWithDictionary:dict];
                    [models addObject:model];
                }
                value = models;
            }
        }
        if (value){
            [obj setValue:value forKey:key];
        }
    }
    free(ivars);
    return obj;
}
@end
