//
//  UserCell.h
//  AddUser
//
//  Created by sbtd on 15/1/10.
//  Copyright (c) 2015年 sbtd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol change <NSObject>

- (void)changeUserName:(UITableViewCell *)cell;

@end

@protocol deleteUser <NSObject>

- (void)deleteUser:(UITableViewCell *)cell;

@end

@protocol maxValue <NSObject>

- (void)maxValueLine:(UITableViewCell *)cell;

@end

@interface UserCell : UITableViewCell
@property (nonatomic, retain)UIButton *userSelect;
@property (nonatomic, retain)UITextField *userName;
@property (nonatomic, retain)UIButton *userChange;
@property (nonatomic, retain)UIButton *userDelete;

@property (nonatomic, assign)id<change> changeDelegate;
@property (nonatomic, assign)id<deleteUser> deleteDelegate;
@property (nonatomic, assign)id<maxValue> maxDelegate;
@end
