//
//  ViewController.m
//  DO_EdgeDragAnimation_Demo

#import "LW_EdgeDragView.h"
#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

{

    LW_EdgeDragView *edge;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"滑动";
   LW_EdgeDragView *ev = [[LW_EdgeDragView alloc] initWithFrame:self.view.bounds EdgeType:LWEdgeTyperight];
    ev.color = [UIColor cyanColor];
    [self.view addSubview:ev];
    edge = ev;
}
-(void)addSysLog{

    NSLog(@"sys_log");
}

@end
