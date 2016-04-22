//
//  DatabaseTool.h
//  0112Test
//
//  Created by Mac on 16/1/12.
//  Copyright © 2016年 泛舟水上. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Model.h"
@interface DatabaseTool : NSObject
//封装一个创建数据库和表的加号方法
+ (void)createDatabaseAndCreateTable;
//封装一个插入数据方法
+ (void)insertDataToContact:(Model *)m;

//封装查询数据方法
+ (NSArray *)selectAllDataFromContact;

//封装删除方法
+ (void) deleteDataAtIndexPath:(NSInteger)index;
@end
