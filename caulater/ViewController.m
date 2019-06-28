//
//  ViewController.m
//  caulater
//
//  Created by 许远备 on 2019/2/18.
//  Copyright © 2019 meAuto. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic,strong) UILabel* label1;
@property(nonatomic,strong) CBCentralManager* myManager;
@property(nonatomic,strong) CBPeripheral* myPeripheral;
@property(nonatomic,strong) NSMutableArray<NSString*>* nameArray;//testGit
@end//tessAgain24560000

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameArray=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
   
 //  self.label1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
//    NSLayoutConstraint* contrainTop=[NSLayoutConstraint constraintWithItem:self.label1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:50];
//  
//    NSLayoutConstraint* constraintHcenter=[NSLayoutConstraint constraintWithItem:self.label1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
//   CBCentralManager* myCentralManager =
    
    self.myManager=[[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
 //   self.myPeripheral=[[CBPeripheral alloc]init];

    
}
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if([peripheral.name isEqualToString:@"许远备的MacBook Air"])
    {
        self.myPeripheral=peripheral;
        self.myPeripheral.delegate=self;
            [self.myManager connectPeripheral:self.myPeripheral options:nil];
    }
}
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"connet%@",peripheral.name);
     [self.myPeripheral discoverServices:nil];
    
}
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in self.myPeripheral.services) {
        NSLog(@"Discovered service %@", service);
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"centralManagerDidUpadate");
    NSLog(@"");
    CBManagerState state = central.state;
    NSString *stateString = nil;
    switch(state)
    {
        case CBManagerStateResetting:
            stateString = @"CBManagerStateResetting";
            break;
        case CBManagerStateUnsupported:
            stateString = @"CBManagerStateUnsupported";
            break;
        case CBManagerStateUnauthorized:
            stateString = @"CBManagerStateUnauthorized";
            break;
        case CBManagerStatePoweredOff:
            stateString = @"CBManagerStatePoweredOff";
            break;
        case CBManagerStatePoweredOn:
            stateString = @"CBManagerStatePoweredOn";
            [self.myManager scanForPeripheralsWithServices:nil options:nil];
            break;
        case CBManagerStateUnknown:
        default:
            stateString = @"CBManagerStateUnknown";
    }
    NSLog(@"蓝牙状态：%@",stateString);
    
}
-(UILabel*)label1
{
    if(_label1==nil)
    {
        _label1=[[UILabel alloc]init];
         _label1.text=@"管道压降验算器";
    }
    return _label1;
    
}

@end
