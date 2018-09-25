## NSSet和NSOrderedSet使用

### 简介
>  * **NSSet: 无序不可变集合**
>  * **NSMutableSet:  无序可变集合**
>  ----
>  * **NSOrderedSet:  有序不可变集合**
>  * **NSMutableOrderedSet:  有序可变集合** 

### 使用场景
> 用法与`NSArray`相似,  但是若是需要保证操作的集体数据中, 相同的`对象`只存在一份,  我们一般采用集合进行数据源的操作, 集合又分为无序集合**(`NSSet` | `NSMutableSet`) 和 有序集合 (`NSOrderedSet` | `NSMutableOrderedSet`)**.  下面我们来了解一些集合的简单用法;

### 使用示例
```
// 我们先来验证下NSSet或NSMutableSet集合是有序还是无序的; 结论: 是无序的!
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
```
```objectivec
// 向集合中加入相同的元素, 集合会自动过滤掉重复的元素.
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
```
```objectivec
// BHPerson是继承与NSObject的类, 因为即使属性都是相同的, 但内存地址不一样. 所以会同时存在于集合
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
```
```objectivec
// BHOverwritePerson是一个继承NSObject的类, 但是对其isEqual方法进行了重写, 若名字(name属性值)是一样的,则认为是同一个对象, 所以集中只会存在一份; 
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
```
```
// 将一个数组转化为NSMutableSet, 此时, 将会由有序的数组变为无序的NSMutableSet
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
```
```objectivec
// 对NSSet进行排序, 返回一个数组(数组是有序的)
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
```
```objectivec
// 对元素增加或者删除
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
```
```objectivec
// 集合交集和子集的判断
- (void)testMethodForHasIntersection {
NSMutableSet *set1 = [NSMutableSet setWithObjects:@"1", @"2", @"3", @"4", nil, nil];
NSMutableSet *set2 = [NSMutableSet setWithObjects:@"1", @"2", nil];

// 判断是否有交集;
BOOL hasIntersection = [set1 intersectsSet:set2];
NSLog(@"set1和set2是否有交集: %@", hasIntersection ? @"有" : @"无"); // 输出: set1和set2是否有交集: 有

// 判断set2是否是set1的子集;
BOOL isSubsetOfSet1 = [set2 isSubsetOfSet:set1];
NSLog(@"set2是否是set1的子集: %@", isSubsetOfSet1 ? @"是" : @"否"); // 输出: set2是否是set1的子集: 是

// 判断set2是否是set2的子集;
BOOL isSubsetOfSet2 = [set2 isSubsetOfSet:set2];
NSLog(@"set2是否是set2的子集: %@", isSubsetOfSet2 ? @"是" : @"否"); // 输出: set2是否是set2的子集: 是

// 获取set1 和 set2 交集
[set1 intersectSet:set2];
NSLog(@"交集: %@", set1);
/* 输出:交集: {(
1,
2
)} */
}
```
```objectivec
// NSMutableOrderedSet集合是否有序; 结论: 是有序的;
- (void)testMethodForOrderedSet {
NSMutableOrderedSet *mutableOrderedSet = [NSMutableOrderedSet new];
[mutableOrderedSet addObject:@"1"];
[mutableOrderedSet addObject:@"3"];
[mutableOrderedSet addObject:@"4"];
[mutableOrderedSet addObject:@"2"];

NSLog(@"mutableOrderedSet: %@", mutableOrderedSet);
/* 输出: mutableOrderedSet: {(
1,
3,
4,
2
)} */
}
```
```objectivec
// 对有序集合的排序
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
```
### 交流与建议
- GitHub：<https://github.com/BaHui>
- 邮&nbsp;&nbsp;&nbsp; 箱：<qiaobahuiyouxiang@163.com>
