//
//  ViewController.m
//  TestAnimation
//
//  Created by QuangTran on 6/8/16.
//  Copyright © 2016 company. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

#define kIdentifyCell   @"cell"
#define kCellHeight     20.f
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *date;
    NSMutableArray *content;
    NSInteger       indexScroll;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *fakeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewToTopContraints;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    date = [[NSMutableArray alloc] initWithObjects:@"10/7",@"10/7",@"10/7",@"10/7",@"10/7",@"10/8",@"10/8",@"10/9",@"10/9",@"10/7",@"10/7",@"10/7",@"10/7",@"10/7",@"10/8",@"10/8",@"10/9",@"10/9",@"10/7",@"10/7",@"10/7",@"10/7",@"10/7",@"10/8",@"10/8",@"10/9",@"10/9",@"10/7",@"10/7",@"10/7",@"10/7",@"10/7",@"10/8",@"10/8",@"10/9",@"10/9", nil];
    content = [[NSMutableArray alloc] initWithObjects:@"Event1",@"Event2",@"Event3",@"Event4",@"Event5",@"Event6",@"Event7",@"Event8",@"Event9",@"Event1",@"Event2",@"Event3",@"Event4",@"Event5",@"Event6",@"Event7",@"Event8",@"Event9",@"Event1",@"Event2",@"Event3",@"Event4",@"Event5",@"Event6",@"Event7",@"Event8",@"Event9",@"Event1",@"Event2",@"Event3",@"Event4",@"Event5",@"Event6",@"Event7",@"Event8",@"Event9", nil];
    [self.myTableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:kIdentifyCell];
    self.fakeLabel.text = date[0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return content.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CustomCell heightCell];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifyCell];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifyCell];
    }
    cell.dateLabel.text = date[indexPath.row];
    cell.contentLabel.text = content[indexPath.row];
    if (indexPath.row == 0) {
        cell.dateLabel.hidden = YES;
    }
    if (indexPath.row >= 1) {
        NSString *strOld = [date objectAtIndex:indexPath.row -1];
        NSString *strCur = [date objectAtIndex:indexPath.row];
        if ([strOld isEqualToString:strCur]) {
            cell.dateLabel.hidden = YES;
        }
        else{
            cell.dateLabel.hidden = NO;
        }
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *arrObjTableVisible = [self.myTableView indexPathsForVisibleRows];
    if([arrObjTableVisible count]<=0)
        return;
    NSIndexPath *pathTopScroll = [arrObjTableVisible objectAtIndex:0];
    if (pathTopScroll.row == 0) {
        self.fakeLabel.text = date[0];
    }else{
        self.fakeLabel.text = date[pathTopScroll.row];
        self.viewToTopContraints.constant = 0.f;
        [self.view layoutIfNeeded];
        NSString *dateCur = date[pathTopScroll.row];
        NSString *dateNext = date[pathTopScroll.row + 1];
        if (![dateCur isEqualToString:dateNext]) {
            CGPoint offset = self.myTableView.contentOffset;
            CGFloat offsetCell = [CustomCell heightCell] * pathTopScroll.row;
            if (offset.y > offsetCell && offset.y < (offsetCell + [CustomCell heightCell] - kCellHeight)) {
                
            }else if(offset.y >= (offsetCell + [CustomCell heightCell] - kCellHeight) && offset.y < (offsetCell + [CustomCell heightCell])){
                self.viewToTopContraints.constant = (offsetCell + [CustomCell heightCell] - kCellHeight) - offset.y;
                [self.view layoutIfNeeded];
            }
        }else{
            self.fakeLabel.text = date[pathTopScroll.row];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
