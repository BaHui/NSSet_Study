//
//  BHPerson.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/25.
//  Copyright © 2018 QiaoBaHui. All rights reserved.
//

#import "BHPerson.h"

@implementation BHPerson

+ (instancetype)create {
	BHPerson *person = [BHPerson new];

	return person;
}

- (void)updateName:(NSString *)name age:(NSInteger)age {
	self.name = name;
	self.age = age;
}

@end
