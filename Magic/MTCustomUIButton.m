// MACustomUIButton.m
#import "MTCustomUIButton.h"

@implementation MTCustomUIButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth  = self.borderWidth ;
}

@end
