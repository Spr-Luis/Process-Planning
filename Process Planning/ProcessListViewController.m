//
//  ProcessListViewController.m
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 18/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import "ProcessListViewController.h"
#import "XLForm.h"
#import "ProcessTimeSetupViewController.h"
#import "ProcessManager.h"
#import "ProcessTimelineCollectionViewController.h"


#import "FCFS_Algorithm.h"


@interface ProcessListViewController ()

@end

@implementation ProcessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ProcessManager *manager = [ProcessManager sharedManager];
    manager = [manager init];
    
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Listado de Procesos"];
    section.footerTitle = [NSString stringWithFormat:@"Hay un total de %ld proceso(s), los cuales tendrás que indicar los tiempos de ejecución en el CPU y de E/S.",(long)self.noProcess];
    [form addFormSection:section];

    
    for (int i = 0; i < self.noProcess; i++) {
        XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:[NSString stringWithFormat:@"%d",i] rowType:XLFormRowDescriptorTypeSelectorPush title:[NSString stringWithFormat:@"Proceso %d",i+1]];
        row.action.formSegueIdenfifier = @"processTimeSetup";
        row.value = [NSString stringWithFormat:@"Configurar"];

        [section addFormRow:row];
    }

    self.form = form;
    
    self.doneProcessButton.hidden = true;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    BOOL statusButton = true;
    
    for (NSString *status in [[self formValues] allValues]) {
        if ([status isEqualToString:@"Configurar"]) {
            statusButton = true;
            return;
        }
        
        if ([status isEqualToString:@"Listo"]) {
            statusButton = false;
        }
    }
    
    self.doneProcessButton.hidden = statusButton;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"processTimeSetup"]) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        ProcessTimeSetupViewController *vc = segue.destinationViewController;
        vc.tag = [[(XLFormRowDescriptor*)sender tag] integerValue];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserverForName:[NSString stringWithFormat:@"Proceso %d",[[(XLFormRowDescriptor*)sender tag] integerValue]+1]
                            object:nil
                             queue:nil
                        usingBlock:^(NSNotification *notification){

                            XLFormRowDescriptor *rowUpdate = [self.form formRowWithTag:notification.object];
                            rowUpdate.value = [NSString stringWithFormat:@"Listo"];
                            
                        }];
    }else if ([segue.identifier isEqualToString:@"timeline"]){
        ProcessTimelineCollectionViewController *vc = segue.destinationViewController;
        vc.allProcess = sender;
    }
}


- (IBAction)doneProcessAction:(UIButton *)sender {
    
    NSArray *allProcess = [FCFS_Algorithm FCFSWithProcessList:[[ProcessManager sharedManager] processList]];
    
    for (Process *proc in allProcess) {
        
        NSLog(@"Process Name: %@", proc.name);
        
        for (Execution* ex in proc.exections) {
            NSLog(@"%@ ::: %@ -> %@ ::: %ld", ex.executionType, ex.startDate, ex.endDate,(long)
                  ex.durationTime);
        }
        
    }
    
    [self performSegueWithIdentifier:@"timeline" sender:allProcess];
}
@end
