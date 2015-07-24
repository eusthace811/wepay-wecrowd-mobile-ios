//
//  WCCampaignHeaderModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignHeaderModel.h"
#import "WCClient.h"

#pragma mark - Interface

@interface WCCampaignHeaderModel ()

@property (nonatomic, strong, readwrite) UIImage *thumbnailImage;
@property (nonatomic, strong, readwrite) NSString *thumbnailImageURLString;

@end

#pragma mark - Implementation

@implementation WCCampaignHeaderModel

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title
                   imageURLString:(NSString *) imageURLString
{
    if (self = [super initWithCampaign:campaign
                                 title:title])
    {
        self.thumbnailImageURLString = imageURLString;
    } else {
        // Do nothing
    }
    
    return self;
}

- (void) fetchImageIfNeededWithCompletion:(void (^)(UIImage *image, NSError *error)) completion
{
    // Only fetch the image if one isn't already stored
    if (!self.thumbnailImage) {
        [WCClient fetchImageWithURLString:self.thumbnailImageURLString
                          completionBlock:^(UIImage *image, NSError *error) {
                              self.thumbnailImage = image;
                              completion(image, error);
                          }];
    } else {
        completion(self.thumbnailImage, nil);
    }
}

@end
