//
//  PassportViewCell.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "PassportViewCell.h"

@implementation PassportViewCell
@synthesize ppNo,ppType,ppExpire;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Create a subview - don't need to specify its position/size
        ppNo = [[UILabel alloc] initWithFrame:CGRectZero];
        [ppNo setFont:[UIFont boldSystemFontOfSize:19]];
        // Put it on the content view of the cell
        [[self contentView] addSubview:ppNo];
        // It is being retained by its superview
        [ppNo release];
        // Type
        ppType = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [[self contentView] addSubview:ppType];
        [ppType release];
        // Expire
        ppExpire = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:ppExpire];
        [ppExpire release];
    }
    return self;
}

- (Passport *)pp
{
    return self.pp;
}

- (void)setPP:(Passport *)newPP
{
    pp = newPP;

    self.ppNo.text = [NSString stringWithFormat:@"หนังสือเดินทาง %@", newPP.no];
    if(newPP.type==1){
        self.ppType.text = [NSString stringWithFormat:@"ประเภททั่วไป"];
    }
    else{
        self.ppType.text = [NSString stringWithFormat:@"ประเภทราชการ"];
    }
    //binding soon
    self.ppExpire.text = [NSString stringWithFormat:@"หมดอายุ "];
    [self setNeedsDisplay];
}



- (void)layoutSubviews {
    // We always call this, the table view cell needs to do its own work first
    [super layoutSubviews];
    // We'll use this to add spacing between borders
    float inset = 5.0;
    // How much space do we have to work with?
    CGRect bounds = [[self contentView] bounds];
    // Let's pull out of the height and width
    // into easier-to-type variable names
    float h = bounds.size.height;
    float w = bounds.size.width;
    // This will be a constant value for the valueField's width
    float valueWidth = 5.0;
    //Passport Type
    CGRect ppTFrame = CGRectMake(inset,22,w - (h + valueWidth + inset * 2.0)-130,h - inset * 4.5);
    [ppType setFrame:ppTFrame];
    //Passport Expire
    CGRect ppEFrame = CGRectMake(inset+w - (h + valueWidth + inset * 2.0)-130,22,w - (h + valueWidth + inset * 2.0),h - inset * 4.5);
    [ppExpire setFrame:ppEFrame];
    // Create a rectangle in the middle for the name
    CGRect ppNFrame = CGRectMake(inset,inset-10,w - (h + valueWidth + inset * 4.0),h - inset * 2.0);
    [ppNo setFrame:ppNFrame];
    
}

@end
