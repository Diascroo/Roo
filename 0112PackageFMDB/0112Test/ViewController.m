//
//  ViewController.m
//  0112Test
//
//  Created by Mac on 16/1/12.
//  Copyright © 2016年 泛舟水上. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "Model.h"
#import "DatabaseTool.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;
- (IBAction)addAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) NSMutableArray *dataSourceArr;

@property (retain,nonatomic) FMDatabase *database;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *array = [DatabaseTool selectAllDataFromContact];
    if (array.count>0) {
        _dataSourceArr = [[NSMutableArray arrayWithArray:array]retain];
    }else {
        _dataSourceArr = [[NSMutableArray array]retain];
    }
    _tableView.dataSource=self;
    _tableView.delegate = self;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = view;
    [view release];
    
}
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Model *m = _dataSourceArr[indexPath.row];
    UILabel *name = (UILabel *)[cell viewWithTag:1];
    name.text = m.name;
    UILabel *phone = (UILabel *)[cell viewWithTag:2];
    phone.text = m.phone;
    return cell;
}
#pragma mark <UITableViewDelegate>
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSourceArr removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [DatabaseTool deleteDataAtIndexPath:indexPath.row];
    }
    /*
//     用对象的ID充当索引时 要先删除数据库中的数据 然后再删数组中的数据  原因：如果先删数组中的数据 model的对象指针指向的内存被释放
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Model *m = _dataSourceArr[indexPath.row];
        [DatabaseTool deleteDataAtIndexPath:m.contact_ID];
        [_dataSourceArr removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_database release];
    [_dataSourceArr release];
    [_nameTextField release];
    [_phoneTextField release];
    [_tableView release];
    [super dealloc];
}

- (IBAction)addAction:(id)sender {
    
    Model *m = [[Model alloc]init];
    m.name = _nameTextField.text;
    m.phone = _phoneTextField.text;
    [_dataSourceArr addObject:m];
    [m release];
    [_tableView reloadData];
    
    [DatabaseTool insertDataToContact:m];
}
@end
