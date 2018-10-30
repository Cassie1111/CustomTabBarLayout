//
//  TrendingCell.swift
//  CustomNavBar
//
//  Created by 刘敏 on 2018/10/30.
//  Copyright © 2018 刘敏. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        APIService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
