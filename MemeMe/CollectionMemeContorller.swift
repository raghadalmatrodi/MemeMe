//
//  CollectionMemeContorller.swift
//  MemeMe
//
//  Created by Raghad Almatrodi on 12/29/18.
//  Copyright © 2018 raghad almatrodi. All rights reserved.
//

import UIKit

class CollcetionMemeController: UICollectionViewController {
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.meme1.count ?? 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as? CollectionMemeCell else {
            fatalError("couldn't load cell for collection view")
        }
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        let meme = appDelegate?.meme1
        
        let memeN = meme![indexPath.row]
        cell.imagePicker.image = memeN.MemeImg
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        let meme = appDelegate?.meme1
        let meme2 = meme![indexPath.row]
        performSegue(withIdentifier:"detailed", sender:meme2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="detailed"{
            let meme = sender as? meme
            let vc = segue.destination as? memeDetails
            vc?.image = meme?.MemeImg
            
            
        }
        
    }
    
    
    
    
    
    
    
}
