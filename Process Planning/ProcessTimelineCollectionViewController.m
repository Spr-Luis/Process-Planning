//
//  ProcessTimelineCollectionViewController.m
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 19/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//


#import "ProcessTimelineCollectionViewController.h"

#import "INSElectronicProgramGuideLayout.h"
#import "ISHourHeader.h"
#import "ISEPGCell.h"
#import "ISSectionHeader.h"
#import "ISCurrentTimeIndicatorView.h"
#import "ISGridlineView.h"
#import "ISHeaderBackgroundView.h"
#import "ISCurrentTimeGridlineView.h"
#import "ISHalfHourLineView.h"
#import "ISFloatingCell.h"
#import "ISHourHeaderBackgroundView.h"

#import "NSDate+MTDates.h"
#import "Execution.h"
#import "Process.h"



@interface ProcessTimelineCollectionViewController ()<INSElectronicProgramGuideLayoutDataSource, INSElectronicProgramGuideLayoutDelegate>

@property (nonatomic, weak) INSElectronicProgramGuideLayout *collectionViewEPGLayout;


@end

@implementation ProcessTimelineCollectionViewController



static NSString * const reuseIdentifier = @"Cell";

- (INSElectronicProgramGuideLayout *)collectionViewEPGLayout
{
    return (INSElectronicProgramGuideLayout *)self.collectionViewLayout;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImage.image = [UIImage imageNamed:@"backgroundImage"];
    self.collectionView.backgroundView = backgroundImage;
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionViewEPGLayout.dataSource = self;
    self.collectionViewEPGLayout.delegate = self;
    
    self.collectionViewEPGLayout.shouldResizeStickyHeaders = YES;
    self.collectionViewEPGLayout.shouldUseFloatingItemOverlay = NO;
    self.collectionViewEPGLayout.floatingItemOffsetFromSection = 10.0;
    self.collectionViewEPGLayout.currentTimeVerticalGridlineWidth = 4;
    self.collectionViewEPGLayout.sectionHeight = 60;
    self.collectionViewEPGLayout.sectionHeaderWidth = 110;
    
    NSString *timeRowHeaderStringClass = NSStringFromClass([ISHourHeader class]);
    [self.collectionView registerNib:[UINib nibWithNibName:timeRowHeaderStringClass bundle:nil] forSupplementaryViewOfKind:INSEPGLayoutElementKindHourHeader withReuseIdentifier:timeRowHeaderStringClass];
    [self.collectionView registerNib:[UINib nibWithNibName:timeRowHeaderStringClass bundle:nil] forSupplementaryViewOfKind:INSEPGLayoutElementKindHalfHourHeader withReuseIdentifier:timeRowHeaderStringClass];
    
    NSString *cellStringClass = NSStringFromClass([ISFloatingCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:cellStringClass bundle:nil] forCellWithReuseIdentifier:cellStringClass];
    
    NSString *dayColumnHeaderStringClass = NSStringFromClass([ISSectionHeader class]);
    [self.collectionView registerNib:[UINib nibWithNibName:dayColumnHeaderStringClass bundle:nil] forSupplementaryViewOfKind:INSEPGLayoutElementKindSectionHeader withReuseIdentifier:dayColumnHeaderStringClass];
    
    [self.collectionViewEPGLayout registerClass:ISCurrentTimeGridlineView.class forDecorationViewOfKind:INSEPGLayoutElementKindCurrentTimeIndicatorVerticalGridline];
    [self.collectionViewEPGLayout registerClass:ISGridlineView.class forDecorationViewOfKind:INSEPGLayoutElementKindVerticalGridline];
    [self.collectionViewEPGLayout registerClass:ISHalfHourLineView.class forDecorationViewOfKind:INSEPGLayoutElementKindHalfHourVerticalGridline];
    
    [self.collectionViewEPGLayout registerClass:ISHeaderBackgroundView.class forDecorationViewOfKind:INSEPGLayoutElementKindSectionHeaderBackground];
    [self.collectionViewEPGLayout registerClass:ISHourHeaderBackgroundView.class forDecorationViewOfKind:INSEPGLayoutElementKindHourHeaderBackground];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionViewEPGLayout scrollToCurrentTimeAnimated:YES];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(INSElectronicProgramGuideLayout *)electronicProgramGuideLayout startTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Process *processSection = [self.allProcess objectAtIndex:indexPath.section];
    Execution *Exec = [processSection.exections objectAtIndex:indexPath.row];
    
    return Exec.startDate;

}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(INSElectronicProgramGuideLayout *)electronicProgramGuideLayout endTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Process *processSection = [self.allProcess objectAtIndex:indexPath.section];
    Execution *Exec = [processSection.exections objectAtIndex:indexPath.row];
    
    return Exec.endDate;
}

- (NSDate *)currentTimeForCollectionView:(UICollectionView *)collectionView layout:(INSElectronicProgramGuideLayout *)collectionViewLayout
{
    return [NSDate date];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view;
    if (kind == INSEPGLayoutElementKindSectionHeader) {
        ISSectionHeader *dayColumnHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ISSectionHeader class]) forIndexPath:indexPath];
        Process *processSection = [self.allProcess objectAtIndex:indexPath.section];
        dayColumnHeader.dayLabel.text = processSection.name;
        view = dayColumnHeader;
    } else if (kind == INSEPGLayoutElementKindHourHeader) {
        ISHourHeader *timeRowHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ISHourHeader class]) forIndexPath:indexPath];
        timeRowHeader.time = [self.collectionViewEPGLayout dateForHourHeaderAtIndexPath:indexPath];
        view = timeRowHeader;
    } else if (kind == INSEPGLayoutElementKindHalfHourHeader) {
        ISHourHeader *timeRowHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ISHourHeader class]) forIndexPath:indexPath];
        timeRowHeader.time = [self.collectionViewEPGLayout dateForHalfHourHeaderAtIndexPath:indexPath];
        view = timeRowHeader;
    }
    
    return view;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.allProcess count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    Process *processSection = [self.allProcess objectAtIndex:section];
    return [processSection.exections count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ISFloatingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ISFloatingCell class]) forIndexPath:indexPath];

    Process *processSection = [self.allProcess objectAtIndex:indexPath.section];
    Execution *Exec = [processSection.exections objectAtIndex:indexPath.row];
    
    
    cell.titleLabel.text = Exec.executionType;
    
    [cell setDate:Exec.startDate];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
