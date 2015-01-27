//
//  UserCell.m
//  AddUser
//
//  Created by sbtd on 15/1/10.
//  Copyright (c) 2015年 sbtd. All rights reserved.
//

#import "UserCell.h"
#import "UIViewAdditions.h"
@implementation UserCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
        
        // Initialization code
    }
    return self;
}

- (void)creatCell
{
    self.userSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userSelect.frame = CGRectMake(10, 10, 30, 30);
    [self.userSelect setTitle:@"a" forState:UIControlStateNormal];
    self.userSelect.titleLabel.font = [UIFont systemFontOfSize:0.1];
    [self.userSelect setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.userSelect addTarget:self action:@selector(background:) forControlEvents:UIControlEventTouchUpInside];
    _userSelect.backgroundColor = [UIColor redColor];
    [self addSubview:_userSelect];
    
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(_userSelect.right, 0, 150, 50)];
    [self.userName setEnabled:NO];
    [self addSubview:_userName];
    
    self.userChange = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userChange.frame = CGRectMake(_userName.right +5, 5, 40, 40);
    self.userChange.backgroundColor = [UIColor orangeColor];
    [self.userChange addTarget:self action:@selector(changUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.userChange setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:_userChange];
    
    self.userDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userDelete.frame =CGRectMake(_userChange.right+5, _userChange.top, _userChange.width, _userChange.height);
    [self.userDelete addTarget:self action:@selector(deleteUser) forControlEvents:UIControlEventTouchUpInside];
    self.userDelete.backgroundColor = [UIColor greenColor];
    [self addSubview:_userDelete];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)changUser:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"1"]) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [self.userName setEnabled:YES];
        [self.userName becomeFirstResponder];
        NSLog(@"btn.currentTitle = %@", btn.currentTitle);
        [self.userSelect setEnabled:NO];
    }
    else
    {
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [self.userName setEnabled:NO];
        NSLog(@"btn.currentTitle = %@", btn.currentTitle);
        [self.userSelect setEnabled:YES];
    }
    [self.changeDelegate changeUserName:self];
}

- (void)deleteUser
{
    [self.deleteDelegate deleteUser:self];
}

- (void)background:(UIButton *)btn
{
    NSLog(@"btncurrtitle=%@", btn.currentTitle);
    if ([btn.currentTitle isEqualToString:@"a"]) {
        [btn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        [btn setTitle:@"b" forState:UIControlStateNormal];
        [self.userChange setEnabled:NO];
        [self.userDelete setEnabled:NO];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [btn setTitle:@"a" forState:UIControlStateNormal];
        [self.userChange setEnabled:YES];
        [self.userDelete setEnabled:YES];
    }
    
    [self.maxDelegate maxValueLine:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
