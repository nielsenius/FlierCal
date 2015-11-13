//
//  WebOCR.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/12/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import Foundation

let url = "http://www.ocrwebservice.com/restservices/processDocument?gettext=true"
let username = "FLIERCAL"
let license = "AFA3F3AF-7B48-4583-A52D-820EE7232CFB"

class WebOCR {
    
    class func getTextFromImage(image: NSData) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let userPasswordString = "\(username):\(license)"
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        let authString = "Basic \(base64EncodedCredential)"
        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        let boundary = "14737809831466499882746641449"
        let fileName = "image.jpg"
        let fullData = imageDataToFormData(image, boundary: boundary, fileName: fileName)
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(String(fullData.length), forHTTPHeaderField: "Content-Length")
        request.HTTPBody = fullData
        request.HTTPShouldHandleCookies = false
        
        //var jsonResponse: NSDictionary = ["success": "false"]
        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    //let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    //println(dataString)
                    println(self.parseJSON(data))
                }
            }
        }
        
        task.resume()
    }
    
    class func imageDataToFormData(data: NSData, boundary: String, fileName: String) -> NSData {
        let fullData = NSMutableData()
        
        let lineOne = "--" + boundary + "\r\n"
        fullData.appendData(lineOne.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        NSLog(lineTwo)
        fullData.appendData(lineTwo.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        let lineThree = "Content-Type: image/jpg\r\n\r\n"
        fullData.appendData(lineThree.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        fullData.appendData(data)
        
        let lineFive = "\r\n"
        fullData.appendData(lineFive.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        let lineSix = "--" + boundary + "--\r\n"
        fullData.appendData(lineSix.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        return fullData
    }
    
    class func parseJSON(inputData: NSData) -> NSDictionary {
        var error: NSError?
        var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return dict
    }
    
}
