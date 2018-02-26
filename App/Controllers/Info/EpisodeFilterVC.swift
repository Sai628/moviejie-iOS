//
//  EpisodeFilterVC.swift
//  "分集过滤"视图
//
//  Created by Sai on 26/02/2018.
//  Copyright © 2018 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


protocol EpisodeFilterDelegate: class
{
    func onItemClicked(index: Int, episode: String, text: String)
}


class EpisodeFilterVC: UIViewController
{
    fileprivate var episodeFilterCollectionView: UICollectionView!
    
    var episodeFitlers: [[String: String]] = []  // item 的 dic 结构为 ["episode": String, "text": String]
    var selectedEpisode: String = ""
    weak var delegate: EpisodeFilterDelegate?
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        title = "分集查看"
        
        episodeFilterCollectionView = UICollectionView(frame: Dimens.screenFrameWithoutNavBar,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
        episodeFilterCollectionView.register(EpisodeFilterCCell.self, forCellWithReuseIdentifier: EpisodeFilterCCell.className)
        episodeFilterCollectionView.backgroundColor = UIColor.clear
        episodeFilterCollectionView.delegate = self
        episodeFilterCollectionView.dataSource = self
        view.addSubview(episodeFilterCollectionView)
    }
    
    
    func cellClickedHandler(index: Int)
    {
        let episode = episodeFitlers[index]["episode"]!
        let episodeText = episodeFitlers[index]["text"]!
        delegate?.onItemClicked(index: index, episode: episode, text: episodeText)
        popVC()
    }
}


//MARK:- UICollectionViewDelegate
extension EpisodeFilterVC: UICollectionViewDelegate
{
}


//MARK:- UICollectionViewDelegateFlowLayout
extension EpisodeFilterVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return EpisodeFilterCCell.cellSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(inset: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        let numColumns: CGFloat = ez.screenWidth >= Dimens.iphone6PlusWidth ? 6 :
                                  ez.screenWidth >= Dimens.iphone6Width ? 5 : 4
        return (ez.screenWidth - 16 * 2 - EpisodeFilterCCell.cellSize.width * numColumns) / (numColumns - 1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 16
    }
}


//MARK:- UICollectionViewDataSource
extension EpisodeFilterVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return episodeFitlers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let episode = episodeFitlers[indexPath.row]["episode"]!
        let episodeText = episodeFitlers[indexPath.row]["text"]!
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeFilterCCell.className, for: indexPath) as! EpisodeFilterCCell
        cell.setModel(text: episodeText, isSelected: episode == selectedEpisode)
        
        cell.layoutClickedHandler = { [weak self] in
            self?.cellClickedHandler(index: indexPath.row)
        }
        
        return cell
    }
}
