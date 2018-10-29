//
//  ViewController.swift
//  CustomNavBar
//
//  Created by 刘敏 on 2018/10/26.
//  Copyright © 2018 刘敏. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    func fetchVideos() {
        APIService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "   Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        // let the content totally beneath the menu bar
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupNavBarButtons()
        setupMenuBar()
    }
    
    private func setupNavBarButtons() {
        // search button
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBtn = UIButton()
        searchBtn.setImage(searchImage, for: .normal)
        searchBtn.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        
        let searchBarButton = UIBarButtonItem(customView: searchBtn)
        searchBarButton.customView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
        searchBarButton.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        // more button
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBtn = UIButton()
        moreBtn.setImage(moreImage, for: .normal)
        moreBtn.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
    
        
        let moreBarButton = UIBarButtonItem(customView: moreBtn)
        moreBarButton.customView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
        moreBarButton.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
      
        
        
        
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
//        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0.0, left: -15, bottom: 0, right: -10);
    }
    
    @objc func handleSearch() {
        print("search")
    }
    
    // lazy var, executed once and only executes when needed
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        
        return launcher
    }()
    
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showControllerForSettings(setting: Setting) {
        let dummySettingViewController = UIViewController()
        dummySettingViewController.view.backgroundColor = UIColor.white
        dummySettingViewController.navigationItem.title = setting.name.rawValue
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        
        return mb
    }()
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        
        redView.activateConstrainsWithFormat(format: "H:|[v0]|", views: redView)
        redView.activateConstrainsWithFormat(format: "V:[v0(50)]", views: redView)
        
        
        view.addSubview(menuBar)
        view.activateConstrainsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.activateConstrainsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count {
//            return count
//        }
//
//        return 0
        
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 16:9 ratio for screen is best
        
        let imageViewheight = (view.frame.width - 16 - 16) * 9 / 16
        let cellHeight = imageViewheight + 16 + 88
        
        return CGSize(width: view.frame.width, height: cellHeight)
    }


}





