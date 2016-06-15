//
//  CustomCell.h
//  TestAnimation
//
//  Created by QuangTran on 6/8/16.
//  Copyright © 2016 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (CGFloat)heightCell;

@end
