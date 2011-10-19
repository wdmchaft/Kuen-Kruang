//
//  PassportViewCell.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Passport.h"
@interface PassportViewCell : UITableViewCell{
    Passport *pp;
    UILabel *ppNo;
    UILabel *ppType;
    UILabel *ppExpire;
}
@property(nonatomic,retain) UILabel *ppNo;
@property(nonatomic,retain) UILabel *ppType;
@property(nonatomic,retain) UILabel *ppExpire;

-(Passport *) pp;
-(void)setPP:(Passport *)newPP;

@end
