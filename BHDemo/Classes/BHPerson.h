//
//  BHPerson.h
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/25.
//  Copyright © 2018 QiaoBaHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)create;
- (void)updateName:(NSString *)name age:(NSInteger)age;

@end
