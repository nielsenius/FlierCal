//
//  FirstViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/12/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func makeRequest(sender: AnyObject) {
        var imageData: NSData = UIImageJPEGRepresentation(imagePicked.image, 0.7)
        //var compressedImage = UIImage(data: imageData)
        
        WebOCR.getTextFromImage(imageData)
        //UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
//        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//        let imageName = imageURL.path!.lastPathComponent
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as! String
//        let localPath = documentDirectory.stringByAppendingPathComponent(imageName)
//        
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let data = UIImageJPEGRepresentation(image, 0.7)
//        data.writeToFile(localPath, atomically: true)
//        
//        let imageData = NSData(contentsOfFile: localPath)!
//        let photoURL = NSURL(fileURLWithPath: localPath)
//        println(photoURL)
//        let imageWithData = UIImage(data: imageData)!
//        
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }
    
}

