//
//  TodayViewController.swift
//  Widget
//
//  Created by 고대원 on 2020/02/21.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let githubService = GitHubService()
    
    var items: [ParsingContribution] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .compact
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let groupUserDefault = UserDefaults(suiteName: "group.DWGitHub"),
            let login = groupUserDefault.value(forKey: "login") as? String else {
            return
        }
        
        githubService.parsingContribution(username: login) { (item) in
            if let item = item {
                self.items = item
                
                if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    let jandiWidth = CGFloat(self.view.bounds.width / (CGFloat(self.items.count) / 4.7))
                    layout.itemSize = CGSize(width: jandiWidth, height: jandiWidth)
                    self.collectionView.collectionViewLayout = layout
                    
                    let topPadding = 110 - CGFloat(jandiWidth * 7) - 14
                    if topPadding > 0 {
                        self.collectionView.contentInset = UIEdgeInsets(top: topPadding / 2, left: 2, bottom: topPadding / 2, right: 2)
                    }
                }
                
                self.collectionView.reloadData()
            }
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

// MARK: - UICollectionViewDataSource
extension TodayViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayJandiCollectionViewCell.identifer, for: indexPath) as! TodayJandiCollectionViewCell
        
        let item = items[indexPath.row]
        cell.backgroundColor = UIColor(hexString: item.color)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TodayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - setup
extension TodayViewController {
    func setupViews() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            layout.itemSize = CGSize(width: 94 / 7, height: 94 / 7)
            collectionView.collectionViewLayout = layout
        }
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
