//
//  ViewController.m
//  AddUser
//
//  Created by sbtd on 15/1/10.
//  Copyright (c) 2015年 sbtd. All rights reserved.
//

#import "ViewController.h"
#import "UserCell.h"
#import "UIViewAdditions.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, change, deleteUser, maxValue>
@property (nonatomic, retain)UITableView *userTableView;
@property (nonatomic, retain)NSMutableArray *userArray;
@property (nonatomic, retain)UITextField *userName;
@property (nonatomic, assign)NSInteger number;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = 4;
    
    self.userTableView = [[UITableView  alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 44)];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    [self.view addSubview:_userTableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.userArray = [NSMutableArray arrayWithCapacity:1];
    NSArray *array = @[@"张三", @"李四", @"王五", @"赵六", @"倩儿", @"猪八"];
    [self.userArray addObjectsFromArray:array];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20, 60, 40);
    [btn setTitle:@"增加" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(btn.right, 20, 200, 40)];
    [self.view addSubview:_userName];
    
    UITapGestureRecognizer *TAP = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spbResignFirstResponder:)];
    [self.view addGestureRecognizer:TAP];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, _userTableView.bottom, [UIScreen mainScreen].bounds.size.width, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)submit
{
    //NSLog(@"%d", [self.userTableView visibleCells].count);
    for (int i = 0 ; i < [self.userTableView visibleCells].count; i++) {
       // NSLog(@"%@", [[(UserCell *)[[self.userTableView visibleCells] objectAtIndex:i] userName] text]);
        if ([[[(UserCell *)[[self.userTableView visibleCells] objectAtIndex:i] userSelect] currentTitle] isEqualToString:@"b"]) {
            NSLog(@"bbbbbbbbbbbbbbbbbb%@", [[(UserCell *)[[self.userTableView visibleCells] objectAtIndex:i] userName] text]);
        }
    }
    
    
}


- (void)btnClick
{
    
    NSString *str = [_userName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"***%@***", str);
    
    if (![str isEqualToString:@""]) {
        if([self.userArray containsObject:str])
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存在该联系人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [message show];
        }else
        {
            [self.userArray insertObject:str atIndex:0];
            [self.userTableView reloadData];
        }
    }
    else
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你在逗我" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [message show];
    }
    
}

-(IBAction)spbResignFirstResponder:(id)sender
{
    //    NSLogObj(sender);
    if (sender == NULL || [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        if (self.view != NULL && self.view.subviews != NULL && self.view.subviews.count > 0) {
            for (UIView *item in self.view.subviews) {
                if ([item isKindOfClass:[UITextField class]] || [item isKindOfClass:[UITextView class]]) {
                    UITextField *textField_item = (UITextField *)item;
                    [textField_item resignFirstResponder];
                }
                
                [self spbResignFirstResponder:item];
            }
        }
    }else if ([sender isKindOfClass:[UIView class]]) {
        UIView *view_item = sender;
        if ([view_item isKindOfClass:[UITextField class]] || [view_item isKindOfClass:[UITextView class]]) {
            [view_item resignFirstResponder];
        }
        
        if (view_item.subviews != NULL && view_item.subviews.count > 0) {
            for (UIView *item in view_item.subviews) {
                [self spbResignFirstResponder:item];
            }
        }
    }
}

#pragma mark datadelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.changeDelegate = self;
    cell.deleteDelegate = self;
    cell.maxDelegate = self;
    cell.tag = indexPath.row + 100;
    cell.userName.text = [self.userArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark uitable Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 50;
}

#pragma mark change delegate
- (void)changeUserName:(UITableViewCell *)cell
{
    UserCell *ucell = (UserCell *)cell;
    
    if ([ucell.userChange.currentTitle isEqualToString:@"0"]) {
        [self.userArray removeObject:ucell.userName.text];
        NSLog(@"ucell.userChange.currentTitle = %@, ucell.userName.text = %@", ucell.userChange.currentTitle, ucell.userName.text);
    }
    else
    {
        [self.userArray insertObject:ucell.userName.text atIndex:cell.tag -100];
        [self.userTableView reloadData];
        NSLog(@"ucell.userChange.currentTitle = %@, ucell.userName.text = %@", ucell.userChange.currentTitle, ucell.userName.text);
    }
}

#pragma mark delete delegate
- (void)deleteUser:(UITableViewCell *)cell
{
    NSLog(@"删除联系人%d", cell.tag);
    UserCell *ucell = (UserCell *)cell;
    [self.userArray removeObject:ucell.userName.text];
    [self.userTableView reloadData];
}

#pragma mark maxdelegate
- (void)maxValueLine:(UITableViewCell *)cell
{
    UserCell *ucell = (UserCell *)cell;
    NSLog(@"%d", self.number);
    if (self.number > 0) {
        if ([ucell.userSelect.currentTitle isEqualToString:@"b"]) {
            _number--;
        }
        else
        {
            _number++;
        }
    }
    else
    {
        if ([ucell.userSelect.currentTitle isEqualToString:@"b"]) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已达到最大值" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [message show];
            [ucell.userSelect setTitle:@"a" forState:UIControlStateNormal];
            [ucell.userSelect setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
            [ucell.userDelete setEnabled:YES];
            [ucell.userChange setEnabled:YES];
        }
        else
        {
            [ucell.userSelect setTitle:@"a" forState:UIControlStateNormal];
            [ucell.userSelect setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
            _number++;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
