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



@interface ProcessListViewController ()

@end

@implementation ProcessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Listado de Procesos"];
    section.footerTitle = [NSString stringWithFormat:@"Hay un total de %ld proceso(s), los cuales tendrás que indicar los tiempos de ejecución en el CPU y de E/S.",(long)self.noProcess];
    [form addFormSection:section];

    self.processList = [NSMutableArray array];
    
    for (int i = 0; i < self.noProcess; i++) {
        XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:[NSString stringWithFormat:@"setupProcess%d",i] rowType:XLFormRowDescriptorTypeSelectorPush title:[NSString stringWithFormat:@"Proceso %d",i+1]];
        row.action.formSegueIdenfifier = @"processTimeSetup";
        row.value = [NSString stringWithFormat:@"Configurar"];

        [section addFormRow:row];
    }

    self.form = form;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
