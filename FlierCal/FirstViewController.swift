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
        
        if shouldShowAlert() {
            showAlert()
        }
        
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var imagePicked: UIImage?
    var imageSource: String?

    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imageSource = "Camera"
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            imageSource = "Library"
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if imageSource! == "Camera" {
            var imageData: NSData = UIImageJPEGRepresentation(imagePicked, 0.8)
            var compressedImage = UIImage(data: imageData)
            UIImageWriteToSavedPhotosAlbum(compressedImage, nil, nil, nil)
        }
        
        performSegueWithIdentifier("showConfirm", sender: nil)
    }
    
    func shouldShowAlert() -> Bool {
        let n: Int! = self.navigationController?.viewControllers?.count
        if n == 1 {
            return false
        }
        let viewController = self.navigationController?.viewControllers[n - 2] as! UIViewController
        return (viewController.navigationItem.title! == "Create Event")
    }
    
    func showAlert() {
        var alert: UIAlertView = UIAlertView(title: "Success", message: "Event has been added to your calendar", delegate: nil, cancelButtonTitle: "Dismiss")
        alert.show()
        
        // delay dismissal by 5 seconds
        let delay = 5.0 * Double(NSEC_PER_SEC)
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alert.dismissWithClickedButtonIndex(-1, animated: true)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showConfirm" {
            let showConfirm: ConfirmViewController = segue.destinationViewController as! ConfirmViewController
            showConfirm.imagePicked = self.imagePicked!
        }
    }
    
}
