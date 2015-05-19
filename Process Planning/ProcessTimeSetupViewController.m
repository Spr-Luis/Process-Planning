//
//  ProcessTimeSetupViewController.m
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 19/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import "ProcessTimeSetupViewController.h"
#import "XLForm.h"

@interface ProcessTimeSetupViewController ()

@end

@implementation ProcessTimeSetupViewController

@synthesize rowDescriptor = _rowDescriptor;


- (void)viewDidLoad {
    [super viewDidLoad];


    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"processTimeSetup"];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Tiempo de llegada del proceso al CPU"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"initialTime" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Instante de llegada"];
    row.value = [NSString stringWithFormat:@"0 ms"];
    row.disabled = @YES;
    [section addFormRow:row];

    section = [XLFormSectionDescriptor formSectionWithTitle:@"Tiempo de ejecución en el CPU y de E/S"
                                             sectionOptions:XLFormSectionOptionCanInsert sectionInsertMode:XLFormSectionInsertModeButton];
    section.multivaluedTag = @"Times";
    section.multivaluedAddButton.title = @"Agrega una nueva ejecución";
    section.footerTitle = @"Por favor selecciona el icono de '+' para agregar un nuevo campo, para editar el valor solo selección la celda y escoge un tiepo de ejecución para el campo seleccionado.";
    [form addFormSection:section];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"time" rowType:XLFormRowDescriptorTypeSelectorPopover title:@"CPU"];
    }else{
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"time" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"CPU"];
    }
    
    row.selectorOptions = @[@"1 ms", @"2 ms", @"5 ms", @"10 ms", @"15 ms"];
    row.value = [NSString stringWithFormat:@"1 ms"];
    [section addFormRow:row];

    
    self.form = form;
}

-(void)formRowHasBeenAdded:(XLFormRowDescriptor *)formRow atIndexPath:(NSIndexPath *)indexPath
{
    
        [self.tableView beginUpdates];

    
        
        if(indexPath.row % 2){
            formRow.title = @"E/S";
            formRow.value = [NSString stringWithFormat:@"1 ms"];
            
        }else{
            formRow.title = @"CPU";
            formRow.value = [NSString stringWithFormat:@"1 ms"];
        }
    
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:[self insertRowAnimationForRow:formRow]];

        [self.tableView endUpdates];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
    // super implmentation MUST be called
    [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    
    self.saveButton.enabled = true;
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    NSLog(@"%@",[self formValues]);
    self.rowDescriptor.value = [NSString stringWithFormat:@"Listo"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
