//
//  MemeCell.swift
//  MemeMe
//
//  Created by Raghad Almatrodi on 12/9/18.
//  Copyright © 2018 raghad almatrodi. All rights reserved.
//

import UIKit

class CollectionMemeCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePicker: UIImageView!
    
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 10
        let cellWidth = width / 3
        return CGSize(width: cellWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

