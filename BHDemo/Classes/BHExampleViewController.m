//
//  BHExampleViewController.m
//  NSSet 基础学习
//
//  Created by QiaoBaHui on 2018/9/18.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import "BHExampleViewController.h"
#import "BHPerson.h"
#import "BHOverwritePerson.h"

@interface BHExampleViewController ()

@end

static NSString *const DEMO_VIEWS_STORYBOARD_NAME = @"DemoViews";

@implementation BHExampleViewController

+ (instancetype)create {
	UIStoryboard *demoViewsStoryboard = [UIStoryboard storyboardWithName:DEMO_VIEWS_STORYBOARD_NAME bundle:nil];
	return [demoViewsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([BHExampleViewController class])];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	// *************** 无序集合 ***************
	/* 无序集合
	 * NSSet: 不可变无序集合
	 * NSMutableSet: 可变无序集合
	 */

	// 集合中为字符串 (结论: 相同的字符串, 只会存在一份)
	[self testMethodForSetOfString];

	// 集合中为NSObject对象 (结论: 相同的内存地址的对象, 只会存在一份)
	[self testMethodForSetOfPerson];

	// 集合中对Person的isEqual方法进行重写 (结论: 相同的对象, 只会存在一份)
	[self testMethodForOfOverwritePerson];

	// 测试集合的顺序 (结论: 无序的,散列存储)
	[self testMethodForSetOrderStatus];

	// 数组转Set (结论: 会将数组中重复元素保持存在一份)
	[self testMethodForSetFromArray];

	// 对set进行排序
	[self testMethodForOrderbySet];

	// 对set元素增加或者删除
	[self testMethodForAddAndRemoveObject];

	// *************** 有序集合 ***************

	/* 有序集合
	 * NSOrderedSet: 不可变有序集合
	 * NSMutableOrderedSet: 可变有序集合
	 */

	// 创建有序集合
	[self testMethodForOrderedSet];

	// 对有序集合s元素进行排序
	[self testMethodForOrderbyOrderedSet];
}

#pragma mark - NSSet

- (void)testMethodForSetOfString {
	NSString *equalString1 = @"1";
	NSString *equalString2 = @"1";

	NSMutableSet *mutableSetEqualString  = [NSMutableSet new];
	[mutableSetEqualString addObject:equalString1];
	[mutableSetEqualString addObject:equalString2];
	NSLog(@"mutableSetEqualString: %@", mutableSetEqualString);
	/* 输出: mutableSetEqualString: {(
	 1
	 )} */

	NSString *notEqualString1 = @"1";
	NSString *notEqualString2 = @"2";
	NSMutableSet *mutableSetsetNotEqualString  = [NSMutableSet new];
	[mutableSetsetNotEqualString addObject:notEqualString1];
	[mutableSetsetNotEqualString addObject:notEqualString2];
	NSLog(@"mutableSetsetNotEqualString: %@", mutableSetsetNotEqualString);
	/* 输出: mutableSetsetNotEqualString: {(
	 1,
	 2
	 )} */
}

- (void)testMethodForSetOfPerson {
	BHPerson *person1 = [BHPerson create];
	BHPerson *person2 = [BHPerson create];
	[person1 updateName:@"小明" age:20];
	[person2 updateName:@"小明" age:20];

	NSMutableSet *mutableSetPerson = [NSMutableSet new];
	[mutableSetPerson addObject:person1];
	[mutableSetPerson addObject:person2];
	NSLog(@"mutableSetPerson: %@", mutableSetPerson);
	/* 输出: mutableSetPerson: {(
	 <BHPerson: 0x6000035a83a0>,
	 <BHPerson: 0x6000035a8420>
	 )} */
}

- (void)testMethodForOfOverwritePerson {
	BHOverwritePerson *overwritePerson1 = [BHOverwritePerson create];
	BHOverwritePerson *overwritePerson2 = [BHOverwritePerson create];
	[overwritePerson1 updateName:@"小明" age:20];
	[overwritePerson2 updateName:@"小明" age:20];

	NSMutableSet *mutableSetOverwritePerson = [NSMutableSet new];
	[mutableSetOverwritePerson addObject:overwritePerson1];
	[mutableSetOverwritePerson addObject:overwritePerson2];
	NSLog(@"mutableSetOverwritePerson: %@", mutableSetOverwritePerson);
	/* 输出: mutableSetOverwritePerson: {(
	 <BHOverwritePerson: 0x60000379c620>
	 )} */
}

- (void)testMethodForSetOrderStatus {
	NSMutableSet *mutableSetOrder = [NSMutableSet new];
	[mutableSetOrder addObject:@"1"];
	[mutableSetOrder addObject:@"2"];
	[mutableSetOrder addObject:@"3"];
	[mutableSetOrder addObject:@"4"];
	NSLog(@"mutableSetOrderStatus: %@", mutableSetOrder);
	/* 输出: mutableSetOrderStatus: {(
	 3,
	 1,
	 4,
	 2
	 )} */
}

- (void)testMethodForSetFromArray {
	NSArray *strigns = @[@"1", @"2", @"3", @"1"];
	NSMutableSet *setFormArray = [NSMutableSet setWithArray:strigns];
	NSLog(@"setFormArray: %@", setFormArray);
	/* 输出: setFormArray: {(
	 3,
	 1,
	 2
	 )} */
}

- (void)testMethodForOrderbySet {
	NSSet *set = [NSSet setWithObjects:@"a", @"d", @"b", @"c", @"e", nil];

	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
	NSArray *orderbyedArray = [set sortedArrayUsingDescriptors:@[sortDescriptor]];
	NSLog(@"orderbyedArray: %@", orderbyedArray);
	/* 输出: orderbyedArray: (
	 a,
	 b,
	 c,
	 d,
	 e
	 ) */
}

- (void)testMethodForAddAndRemoveObject {
	NSMutableSet *set = [NSMutableSet new];

	[set addObject:@"1"];
	[set addObject:@"2"];
	[set addObject:@"3"];
	NSLog(@"添加元素后: %@", set);
	/* 输出: 添加元素后: {(
	 1,
	 2,
	 3
	 )} */

	[set removeObject:@"3"];
	NSLog(@"移除元素后: %@", set);
	/* 输出: 移除元素后: {(
	 1,
	 2
	 )} */

	[set removeAllObjects];
	NSLog(@"移除所有元素后: %@", set);
	/* 输出: 移除所有元素后: {(
	 )} */
}

#pragma mark - NSOrderedSet

- (void)testMethodForOrderedSet {
	NSMutableOrderedSet *mutableOrderedSet = [NSMutableOrderedSet new];
	[mutableOrderedSet addObject:@"1"];
	[mutableOrderedSet addObject:@"2"];
	[mutableOrderedSet addObject:@"3"];
	[mutableOrderedSet addObject:@"4"];

	NSLog(@"mutableOrderedSet: %@", mutableOrderedSet);
	/* 输出: 移除所有元素后: {(
	 1,
	 2,
	 3,
	 4
	 )} */
}

- (void)testMethodForOrderbyOrderedSet {
	NSMutableOrderedSet *mutableOrderedSet = [NSMutableOrderedSet new];
	[mutableOrderedSet addObject:@"1"];
	[mutableOrderedSet addObject:@"3"];
	[mutableOrderedSet addObject:@"2"];
	[mutableOrderedSet addObject:@"5"];

	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
	[mutableOrderedSet sortUsingDescriptors:@[sortDescriptor]];
	NSLog(@"orderbyMutableOrderedSet: %@", mutableOrderedSet);
	/* 输出: orderbyMutableOrderedSet: {(
	 1,
	 2,
	 3,
	 5
	 )} */
}

@end
