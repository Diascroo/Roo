//
//  DatabaseTool.m
//  0112Test
//
//  Created by Mac on 16/1/12.
//  Copyright © 2016年 泛舟水上. All rights reserved.
//

#import "DatabaseTool.h"
static FMDatabase *_database;
@implementation DatabaseTool
+ (void)createDatabaseAndCreateTable {
    
    if (_database == nil) {
        _database = [[FMDatabase alloc]initWithPath:[self getPath]];
        [_database open];
        NSString *createTable = @"create table if not exists contact (_ID integer primary key autoincrement,name text, phone text)";
        [_database executeUpdate:createTable];
        [_database close];
    }
}

+(NSString *)getPath {
    return [NSString stringWithFormat:@"%@/Documents/data.sqlite",NSHomeDirectory()];
}

+ (void)insertDataToContact:(Model *)m {
    NSString *insert = [NSString stringWithFormat:@"insert into contact (name,phone) values ('%@','%@')",m.name,m.phone];
    [_database open];
    [_database executeUpdate:insert];
    [_database close];
}

+ (NSArray *)selectAllDataFromContact {
    NSString *select = @"select * from contact";
    [_database open];
    FMResultSet *result = [_database executeQuery:select];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        Model *m =[[Model alloc]init];
        m.contact_ID = [result intForColumn:@"_ID"];
        m.name = [result stringForColumn:@"name"];
        m.phone = [result stringForColumn:@"phone"];
        [array addObject:m];
        [m release];
    }
    [result close];
    [_database close];
    return array;
}

+ (void) deleteDataAtIndexPath:(NSInteger)index {
    NSString *delete = [NSString stringWithFormat:@"delete from contact where _ID = %ld",index+1];
    [_database open];
    [_database executeUpdate:delete];
    [_database close];
}
@end
