//
//  SongsController.m
//  MusicAppTracking
//
//  Created by MMF on 19/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "SongsController.h"
#import "Constant.h"

@interface SongsController ()

{
    NSMutableArray *recipeImages;
    SongsCollectionViewCell *cell;
  
  
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection_Songs;
@end

@implementation SongsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // recipeImages = [[NSMutableArray alloc] init];
    recipeImages = [[NSMutableArray alloc] initWithObjects:@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg",@"Guitar.jpg", nil];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return [recipeImages count];
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [recipeImages count];
  //  return [[recipeImages objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    cell = (SongsCollectionViewCell *)[_collection_Songs dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
 
    cell.img_Guitar.layer.borderWidth = 1.0f;
    cell.img_Guitar.layer.borderColor = [UIColor whiteColor].CGColor;
   cell.img_Guitar.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedSongController *LastViewController1=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectedSongController"];
    
    NSString *img_Song = [recipeImages objectAtIndex:indexPath.row];
    LastViewController1.stringimg=img_Song; //[ArrayForPics objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:LastViewController1 animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((_collection_Songs.frame.size.width/2)-5,150);
}


@end
