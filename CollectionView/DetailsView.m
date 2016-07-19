//
//  DetailsView.m
//  CollectionView
//

#import "DetailsView.h"


@implementation DetailsView

-(id)init{
  NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"DetailsView" owner:self options:nil];
  id mainView = [subviewArray objectAtIndex:0];
  return mainView;
}

-(IBAction)close:(id)sender {
  //trigger event
  [[NSNotificationCenter defaultCenter]
   postNotificationName:@"closeButton"
   object:nil ];
}
@end
