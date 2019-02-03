//
//  TableMemeController.swift
//  MemeMe
//
//  Created by Raghad Almatrodi on 12/29/18.
//  Copyright © 2018 raghad almatrodi. All rights reserved.
//

import UIKit
class TableMemeController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.meme1.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell2", for: indexPath) as? tableMemeCell else {
            fatalError("couldn't load cell for collection view")
        }
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        let meme = appDelegate?.meme1
        
        let memeN = meme![indexPath.row]
        cell.imgPicker.image = memeN.MemeImg
        cell.topText.text=memeN.topMeme
        cell.buttomText.text=memeN.buttomMeme
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

