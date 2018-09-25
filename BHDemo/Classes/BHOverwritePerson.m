//
//  BHOverwritePerson.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/25.
//  Copyright © 2018 QiaoBaHui. All rights reserved.
//

#import "BHOverwritePerson.h"

@implementation BHOverwritePerson

+ (instancetype)create {
	BHOverwritePerson *overwritePerson = [BHOverwritePerson new];

	return overwritePerson;
}

- (void)updateName:(NSString *)name age:(NSInteger)age {
	self.name = name;
	self.age = age;
}

#pragma mark - Override Methods

- (BOOL)isEqual:(id)object {
	if (self == object) {
		return YES;
	}

	if ([object isKindOfClass:[BHOverwritePerson class]]) {
		BHOverwritePerson *overwritePerson = (BHOverwritePerson *)object;
		return [self isEqualToPerson:overwritePerson];
	}

	return NO;
}

- (BOOL)isEqualToPerson:(BHOverwritePerson *)overwritePerson {
	if (!overwritePerson) {
		return NO;
	}

	return (!self.name && !overwritePerson.name) || [self.name isEqualToString:overwritePerson.name];
}

- (NSUInteger)hash {
	return [self.name hash];
}

@end
