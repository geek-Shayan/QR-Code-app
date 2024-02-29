//
//  ViewController.swift
//  QR Code app
//
//  Created by SHAYANUL HAQ SADI on 2/7/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var QRImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dictionary: [String: String] = [
            "message" : "some message string here",
            "link" : "https://google.com"
        ]

//        QRImage.image = generateQRCode(from: dictionary)
        
        QRImage.image = generateQRCode(from: "regeydeye")
//        QRImage.image = generateQRCode(from: ["link" : "https://mydeeplinkurlhere"])
    }

    func generateQRCode(from string: String) -> UIImage? {
        
        var jsonDict = [String: Any]()
        
//        let url = "https://mydeeplinkurlhere"
        let url = "https://google.com"
//        let url = "https://toffeelive.com?routing=internal&page=kabbik"
//        let url = "https://staging-web.toffeelive.com/share/index.php?share_url=aee1bc7fa5da061b752d0efddbd16495&title=%E0%A6%AC%E0%A6%BE%E0%A6%82%E0%A6%B2%E0%A6%BE%E0%A6%A6%E0%A7%87%E0%A6%B6%E0%A6%95%E0%A7%87+%E0%A6%B6%E0%A7%81%E0%A6%AD+%E0%A6%95%E0%A6%BE%E0%A6%AE%E0%A6%A8%E0%A6%BE+%E0%A6%9C%E0%A6%BE%E0%A6%A8%E0%A6%BE%E0%A6%B2%E0%A7%87%E0%A6%A8+%E0%A6%93%E0%A6%AE%E0%A6%BE%E0%A6%A8%E0%A7%87%E0%A6%B0+%E0%A6%A6%E0%A7%81%E0%A6%87+%E0%A6%95%E0%A7%8D%E0%A6%B0%E0%A6%BF%E0%A6%95%E0%A7%87%E0%A6%9F%E0%A6%BE%E0%A6%B0+%7C+BDCricTime&image_url=https://images-mstag.toffeelive.com/images/program/4535/logo/1280x720/landscape_original_707249001635075115.png"
        jsonDict.updateValue(url, forKey: "url")
//        jsonDict.updateValue(string, forKey: "xyz")
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: [.withoutEscapingSlashes]) else {
            return nil
        }
        
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
            
        
        // Input the data
        qrFilter.setValue(jsonData, forKey: "inputMessage")
        
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil}
        
        // Scale the image
        let transform = CGAffineTransform(scaleX: 12, y: 12)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        let processedImage = UIImage(cgImage: cgImage)
        
        return processedImage
    }

    
    func generateQRCode(from dictionary: [String: String]) -> UIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: dictionary, requiringSecureCoding: false) else { return nil }
        qrFilter.setValue(data, forKey: "inputMessage")

        guard let qrImage = qrFilter.outputImage else { return nil}

        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        let processedImage = UIImage(cgImage: cgImage)

        return processedImage
    }
}

