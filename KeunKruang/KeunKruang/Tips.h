//
//  Tips.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/7/11.
//  Copyright 2011 Chulalongkorn University. All rights reserved.
//

@interface Tips : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	
    BOOL pageControlIsChangingPage;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

- (void)setupPage;

@end
