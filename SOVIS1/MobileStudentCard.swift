//
//  MobileStudentCard.swift
//  SOVIS1
//
//  Created by JJ on 2016. 7. 11..
//  Copyright © 2016년 JJ. All rights reserved.
//

import Foundation

class MobileStudentCard : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var studentPhoto: UIImageView!
    @IBOutlet weak var barcodeView: UIImageView!
    @IBOutlet weak var barcodeNumLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    let codeGeneraotr = FCBBarCodeGenerator()
    var size = CGSize()
    let cgFloat: CGFloat = 3.14159
    var width : CGFloat?
    var height : CGFloat?
    
    
    
    let userSetting = NSUserDefaults.standardUserDefaults()
    let imagePicker = UIImagePickerController()
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            studentPhoto.frame = CGRect(x: 0,y: 0,width: 200,height: 200)
            studentPhoto.layer.borderWidth = 1.0
            studentPhoto.layer.masksToBounds = false
            studentPhoto.layer.borderColor = UIColor.blackColor().CGColor
            studentPhoto.layer.cornerRadius = studentPhoto.frame.width/2
            studentPhoto.clipsToBounds = true
            studentPhoto.layer.backgroundColor = UIColor.blueColor().CGColor
            if pickedImage.size.width > pickedImage.size.height
            {
            studentPhoto.contentMode = .ScaleAspectFit
            }
            else
            {
            studentPhoto.contentMode = .ScaleAspectFill
            }
            studentPhoto.image = pickedImage
            
            print(pickedImage)
            /*
            let imageData = UIImagePNGRepresentation(pickedImage)
            let myEncodedImageData = NSKeyedArchiver.archivedDataWithRootObject(imageData!)
            userSetting.setObject(myEncodedImageData, forKey: "ProfilePhoto")*/
            //NSUserDefaults.standardUserDefaults().setObject(pickedImage, forKey: "ProfilePhoro")
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageTapped(img : AnyObject){
        print("tapped")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker,animated : true, completion : nil)
        
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        //let profilePhoto = userSetting.objectForKey("ProfilePhoto")
        let image = UIImage(named: "Sogang")
        imagePicker.delegate = self
        studentPhoto.frame = CGRect(x: 0,y: 0,width: 200,height: 200)
        studentPhoto.layer.borderWidth = 1.0
        studentPhoto.layer.masksToBounds = false
        studentPhoto.layer.borderColor = UIColor.blackColor().CGColor
        studentPhoto.layer.cornerRadius = studentPhoto.frame.width/2
        studentPhoto.clipsToBounds = true
        studentPhoto.layer.backgroundColor = UIColor.blueColor().CGColor
        if image!.size.width > image!.size.height
        {
            studentPhoto.contentMode = .ScaleAspectFit
        }
        else
        {
            studentPhoto.contentMode = .ScaleAspectFill
        }

        studentPhoto.image = image
        width = barcodeView.frame.width
        height = barcodeView.frame.height
        
        majorLabel.text = String!(userSetting.stringForKey("Major"))
        
        print(String!(userSetting.stringForKey("Major")))
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        studentPhoto.addGestureRecognizer(singleTap)
        

    }
    
    override func viewDidAppear(animated: Bool) {
        let barcodeInfo = NSUserDefaults.standardUserDefaults().stringForKey("barcode")
        barcodeView.image = Code39.code39ImageFromString(barcodeInfo, width: width!, height: height!)
        //barcodeView.contentMode = UIViewContentMode.Center
        /*
        
        barcodeView.layer.borderWidth = 1.0
        barcodeView.layer.borderColor = UIColor.blackColor().CGColor*/
        barcodeNumLabel.text = barcodeInfo
        print(barcodeInfo)
        /*
        if barcodeInfo == nil
        {
            barcodeInfo = ""
        }
        else {
            let barcode = codeGeneraotr.barcodeWithCode(barcodeInfo!, type: FCBBarcodeType.code39code , size: size)
            barcodeView.image = barcode
            barcodeNumLabel.text = barcodeInfo
            print(barcode,barcodeInfo)
            
        }
        */
    }
    override func viewWillAppear(animated: Bool) {
        

        
    }
    
  
    
    
    
    
}
