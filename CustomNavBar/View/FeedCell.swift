//
//  FeedCell.swift
//  CustomNavBar
//
//  Created by 刘敏 on 2018/10/30.
//  Copyright © 2018 刘敏. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let cellId = "cellId"
    var videos: [Video]?
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        
        backgroundColor = .brown
        addSubview(collectionView)
        
        // add constraint for collectionView
        activateConstrainsWithFormat(format: "H:|[v0]|", views: collectionView)
        activateConstrainsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        // register videoCell for the collectionView
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchVideos() {
        APIService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count {
//            return count
//        }
//
//        return 0

        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // 16:9 ratio for screen is best

        let imageViewheight = (frame.width - 16 - 16) * 9 / 16
        let cellHeight = imageViewheight + 16 + 88

        return CGSize(width: frame.width, height: cellHeight)
    }
    
}
