//
//  Tips.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/14/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tips : UIViewController<UIScrollViewDelegate>
{
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
	
    BOOL pageControlIsChangingPage;
}
@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;

/* for pageControl */
- (IBAction)changePage:(id)sender;

/* internal */
- (void)setupPage;


@end
