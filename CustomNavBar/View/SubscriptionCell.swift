//
//  SubscriptionCell.swift
//  CustomNavBar
//
//  Created by 刘敏 on 2018/10/30.
//  Copyright © 2018 刘敏. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        
       APIService.sharedInstance.fetchSubscriptionFeed{ (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
