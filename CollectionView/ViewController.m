//
//  ViewController.m
//  CollectionView
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DetailsView.h"

@interface ViewController ()
@property (nonatomic, retain)NSArray *collectionImages;
@property (nonatomic, retain)DetailsView *popup;
@property (nonatomic) BOOL isViewProfile;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"],  [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"],[UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"], [UIImage imageNamed:@"movie-poster.jpg"],  nil];
}

#pragma mark - UICollectionView Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return [self.collectionImages  count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *identifier = @"CollectionViewCell";
  CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  cell.starImageView.image = [self.collectionImages objectAtIndex:indexPath.row];
  [[cell viewProfileButton] setHidden:NO];
  [[cell viewProfileButton] setTag:indexPath.row];
  [cell viewProfileButton].layer.cornerRadius = 16;
  [[cell viewProfileButton] addTarget:self action:@selector(viewProfile:) forControlEvents:UIControlEventTouchUpInside];
  
  return cell;
}

-(IBAction)viewProfile:(id)sender {
  NSLog(@"tagg-- > %ld", (long)[sender tag]);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"indexPath1-%ldd",(long)indexPath.row);
  
  CGRect screenRect = [[UIScreen mainScreen] bounds];
  CGFloat screenWidth = screenRect.size.width;
  CGFloat screenHeight = screenRect.size.height;
  self.popup = [[DetailsView alloc]init];
  self.popup.tag = 1;
  [self.popup setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
  self.popup.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
  [self.view addSubview:self.popup];
  [self.popup.imagePopView setImage:[self.collectionImages objectAtIndex:indexPath.row]];
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(eventHandler:)
   name:@"closeButton"
   object:nil ];
  [UIView animateWithDuration:0.3/1.5 animations:^{
    self.popup.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.3/2 animations:^{
      self.popup.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.3/2 animations:^{
        self.popup.transform = CGAffineTransformIdentity;
      }];
    }];
  }];
}
//event handler when event occurs
-(void)eventHandler: (NSNotification *) notification {
  NSLog(@"closeButton triggered");
  [UIView animateWithDuration:0.3/1.5 animations:^{
    self.popup.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.3/2 animations:^{
      self.popup.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.3/2 animations:^{
        self.popup.transform = CGAffineTransformIdentity;
        [self.popup removeFromSuperview];
      }];
    }];
  }];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  //NSLog(@"indexPath2-%ldd",(long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
