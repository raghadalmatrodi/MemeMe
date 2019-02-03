//
//  MemeDetail.swift
//  MemeMe
//
//  Created by Raghad Almatrodi on 12/9/18.
//  Copyright © 2018 raghad almatrodi. All rights reserved.
//

import UIKit

class memeDetails:UIViewController{
    
    var image: UIImage!
    
    @IBOutlet weak var detailedImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedImage.image = image
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

