//
//  ViewController.swift
//  MemeMe
//
//  Created by Raghad Almatrodi on 11/17/18.
//  Copyright © 2018 raghad almatrodi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate ,UITextFieldDelegate {
    
    var meme1: [meme]!
    
    
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var album: UIBarButtonItem!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var toolBarTop: UIToolbar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttom: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    
    let memeTextAttribue :[NSAttributedString.Key:Any] = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size:40)!,
        NSAttributedString.Key.strokeWidth : -4.0,
        ]
    func configure(textField: UITextField, withText: String) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttribue
        textField.textAlignment = NSTextAlignment.center
        textField.clearsOnBeginEditing = true
        textField.text = withText
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        top.delegate = self
        buttom.delegate = self
        configure(textField: top, withText: "TOP")
        configure(textField: buttom, withText: "BOTTOM")
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            textField.defaultTextAttributes = memeTextAttribue
            textField.textAlignment = .center
            textField.adjustsFontSizeToFitWidth=true
            return true
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        // func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        //    dismiss(animated: true, completion: nil)
        // }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func presentPickerViewController(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        presentPickerViewController(source: .photoLibrary)
    }
    
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentPickerViewController(source: .camera)
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if top.isFirstResponder == false {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func share(_ sender: Any) {
        if share.isEnabled{
            let memeMe = generateMemedImage()
            let activityViewController = UIActivityViewController(activityItems:[memeMe], applicationActivities: nil)
            present(activityViewController, animated: true)
            activityViewController.completionWithItemsHandler = {
                (activity, completed, items, error) in
                if (completed){
                    self.meme1 = self.save()
                }
            }
            
        }
        
    }
    
    func save() -> [meme]{
        
        // Create the meme
        let memeMe = meme(topMeme: top.text!,
                          buttomMeme: buttom.text!,
                          originalImg: imageView.image!,
                          MemeImg: generateMemedImage())
        let m=[memeMe]
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.meme1.append(memeMe)
        
        return m
        
        
    }
    var array:[meme]=[]
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        toolBar.isHidden = true
        toolBarTop.isHidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolBar.isHidden = false
        toolBarTop.isHidden=false
        return memedImage
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="detailed"{
            let meme = sender as? meme
            let vc = segue.destination as? memeDetails
            vc?.detailedImage.image = meme?.MemeImg
            
            
        }
        
    }
    
}
