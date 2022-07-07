//
//  ColorsCollectionViewController.swift
//  FullScreenSwiping
//
//  Created by Q on 2022-06-30.
//

import Foundation
import UIKit

class ColorsCollectionViewController: FullPageCollectionViewController {
    let colors: [UIColor] = [
        .blue, .red, .yellow, .green, .systemCyan, .systemPink, .systemMint
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuse")
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}
extension ColorsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
}
