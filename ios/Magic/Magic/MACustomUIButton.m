// MACustomUIButton.m
#import "MACustomUIButton.h"

@implementation MACustomUIButton

- (void)awakeFromNib
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth  = self.borderWidth ;
}

@end