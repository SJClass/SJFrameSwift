//
//  SJView.swift
//  LIST&SEEK
//
//  Created by Arun SJ on 04/07/18.
//  Copyright © 2018 Arun SJ. All rights reserved.
//

import UIKit

@IBDesignable
open class SJView: UIView {
    
    var isHaveCircle:Bool = false;
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        if(isHaveCircle){
            if(self.frame.size.width>self.frame.size.height){
                self.layer.cornerRadius = self.frame.size.height/2;
            }else{
                self.layer.cornerRadius = self.frame.size.width/2;
            }
            
            self.clipsToBounds = true;
        }
        
        self.layer.shadowRadius = 3.0;
        self.layer.shadowColor = UIColor.red.cgColor;
        self.layer.shadowOffset = CGSize(width: 5, height: 5);
    }
    
    @IBInspectable public var radious :CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = radious;
            if(radious>0.0){
                self.clipsToBounds = true;
            }
        }
    }
    
    @IBInspectable public var borderWidth :CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth;
        }
    }
    
    @IBInspectable public var borderColor :UIColor = UIColor.gray {
        didSet{
            self.layer.borderColor = borderColor.cgColor;
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}


@IBDesignable
class SJViewCircle: SJView {
    
    
    @IBInspectable public var clipToCircle:Bool = false{
        didSet{
            if(self.frame.size.width>self.frame.size.height){
                self.layer.cornerRadius = self.frame.size.height/2;
            }else{
                self.layer.cornerRadius = self.frame.size.width/2;
            }
            self.clipsToBounds = true;
            isHaveCircle = true;
        }
    }
}

class SJViewShadow:SJViewCircle{
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        
        self.layer.shadowPath = UIBezierPath(roundedRect:
            self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    
    @IBInspectable public var ShadowRadius:CGFloat = 0.0 {
        didSet{
            self.layer.shadowRadius = ShadowRadius;
        }
    }
    
    @IBInspectable public var ShadowColour:UIColor = UIColor.gray{
        didSet{
            self.layer.shadowColor = ShadowColour.cgColor;
        }
    }
    
    @IBInspectable public var ShadowOffset:CGSize = CGSize(width: 0, height: 0){
        didSet{
            self.layer.shadowOffset = ShadowOffset;
        }
    }
    
}

class SJViewGradient: SJView {
    var colourStart:UIColor = UIColor.gray;
    var colourEnd:UIColor = UIColor.darkGray;
    var startPoint:CGPoint = CGPoint(x: 0, y: 0);
    var endPoint:CGPoint = CGPoint(x: 0, y: 0);
    var layerTopGradient:CAGradientLayer?;
    override open func draw(_ rect: CGRect) {
        // Drawing code
        
        if let layerGra = layerTopGradient{
            layerGra.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height);
            layerGra.startPoint = startPoint;
            layerGra.endPoint = endPoint;
            layerGra.colors = [colourStart.cgColor,colourEnd.cgColor]
        }else{
            layerTopGradient = CAGradientLayer();
            layerTopGradient?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height);
            layerTopGradient?.startPoint = startPoint;
            layerTopGradient?.endPoint = endPoint;
            layerTopGradient?.colors = [colourStart.cgColor,colourEnd.cgColor];
            self.layer.insertSublayer(layerTopGradient!, at: 0);
        }
        /*
         layerTopGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height);
         layerTopGradient.startPoint = startPoint;
         layerTopGradient.endPoint = endPoint;
         layerTopGradient.colors = [colourStart.cgColor,colourEnd.cgColor]
         //self.layer.addSublayer(layerTopGradient)
         self.layer.insertSublayer(layerTopGradient, at: 0);
         */
    }
    
    @IBInspectable public var ColourStart:UIColor = UIColor.gray{
        didSet{
            colourStart = ColourStart;
        }
    }
    
    @IBInspectable public var ColourEnd:UIColor = UIColor.darkGray{
        didSet{
            colourEnd = ColourEnd;
        }
    }
    
    @IBInspectable public var StartPoint:CGPoint = CGPoint(x: 0.5, y: 0){
        didSet{
            startPoint = StartPoint;
        }
    }
    
    @IBInspectable public var EndPoint:CGPoint = CGPoint(x: 0.5, y: 1){
        didSet{
            endPoint = EndPoint;
        }
    }
}

class SJViewWithParallax:UIView{
    var _magnitudeX:Int = 0;
    var _magnitudeY:Int = 0;
    @IBInspectable public var magnitudeX:Int = 0{
        didSet{
            _magnitudeX = magnitudeX;
            addParallelx();
        }
    }
    
    @IBInspectable public var magnitudeY:Int = 0{
        didSet{
            _magnitudeY = magnitudeY;
            addParallelx();
        }
    }
    
    func addParallelx() -> Void {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -_magnitudeX;
        xMotion.maximumRelativeValue = _magnitudeX;
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -_magnitudeY;
        yMotion.maximumRelativeValue = _magnitudeY;
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        self.addMotionEffect(motionEffectGroup)
        
    }
}


open class SJViewLocal: UIView {
    
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        
        if let objLocalLanguage:SJLocale = SJLocalisedString.getSelectedLocale(){
            if(objLocalLanguage.languageCode?.lowercased() == "ar"){
                semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft;
            }else{
                semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight;
            }
        }else {
            semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight;
        }
    }
    
}

extension UIImageView/*:URLSessionDelegate, URLSessionDownloadDelegate*/{
    
    /*
     public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
     if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
     DispatchQueue.main.async {
     self.image = image
     }
     } else {
     fatalError("Cannot load the image")
     }
     }
     
     public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
     DispatchQueue.main.async {
     let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
     print("Progress - \(progress)");
     //self.progressView.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
     }
     }
     */
    
    func downloadImage(url:String) -> Void {
        //let url = "http://www.intrawallpaper.com/static/images/hd-wallpapers-8_FY4tW4s.jpg";
        guard let URlImage = URL(string: url) else {
            return;
        }
        print("Image checked URL:" + url)
        if(SJDataCache.fileExists(url, in: SJDataCache.Directory.caches)){
            if let imageCacheData = SJDataCache.retrieve(url, from: SJDataCache.Directory.caches) as Data?{
                if let image:UIImage = UIImage(data: imageCacheData){
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.image = image;
                    })
                }
                return;
            }
        }
        
        //let url:URL! = URL(string: "https://itunes.apple.com/search?term=flappy&entity=software")
        var task: URLSessionDownloadTask!
        var session: URLSession!
        session = URLSession.shared
        task = URLSessionDownloadTask()
        task = session.downloadTask(with: URlImage, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
            
            if location != nil{
                let data:Data! = try? Data(contentsOf: location!)
                SJDataCache.store(data, to: .caches, as: url)
                print("Image saved URL:" + url)
                let image = UIImage(data: data)
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = image;
                    
                })
            }else{
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = nil;
                    
                })
            }
        })
        task.resume()
        
        /*
         let config = URLSessionConfiguration.default
         let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
         
         // Don't specify a completion handler here or the delegate won't be called
         session.downloadTask(with: URlImage).resume()
         */
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension NSMutableAttributedString{
    public func addString(str:String){
        self.append(NSAttributedString(string: str))
    }
    
    public func addStringStyle(Style:[NSAttributedString.Key:Any]){
        self.addAttributes(Style, range: NSRange(location: 0, length: self.length-1));
    }
    
    public func addStringWithStyle(str:String,properties:[[NSAttributedString.Key:Any]]){
        
        //            let strokeTextAttributes: [NSAttributedStringKey: Any] = [
        //                .strokeColor : UIColor.black,
        //                .foregroundColor : UIColor.white,
        //                .strokeWidth : -2.0,
        //                .font : UIFont.boldSystemFont(ofSize: 18)
        //            ]
        
        var strokeTextAttributes = [NSAttributedString.Key: Any]();
        for prop in properties {
            for key in prop.keys  {
                strokeTextAttributes[key] = prop[key];
            }
        }
        
        self.append(NSAttributedString(string: str, attributes: strokeTextAttributes));
    }
    
    public func addImage(image:UIImage){
        if let imageObj = image as UIImage? {
            let imageAttachment : NSTextAttachment = NSTextAttachment()
            imageAttachment.image = imageObj;
            imageAttachment.bounds = CGRect(x: 0, y: -3, width: imageObj.size.width, height: imageObj.size.height);
            self.append(NSAttributedString(attachment: imageAttachment))
        }
    }
    
    public func addImage(image:UIImage,point:CGPoint){
        
        if let imageObj = image as UIImage? {
            let imageAttachment : NSTextAttachment = NSTextAttachment()
            imageAttachment.image = imageObj;
            imageAttachment.bounds = CGRect(x: point.x, y: point.y, width: imageObj.size.width, height: imageObj.size.height);
            self.append(NSAttributedString(attachment: imageAttachment))
        }
    }
}

extension UILabel {
    public func addString(str:String){
        if let attribText = self.attributedText as? NSMutableAttributedString{
            attribText.addString(str: str);//.append(NSAttributedString(string: str))
            self.attributedText = attribText;
        }
    }
    
    public func addStringStyle(Style:[NSAttributedString.Key:Any]){
        if let attribText = self.attributedText as? NSMutableAttributedString{
            attribText.addStringStyle(Style: Style)//.addAttributes(Style, range: NSRange(location: 0, length: attribText.length-1));
            self.attributedText = attribText;
        }
    }
    
    public func addStringWithStyle(str:String,properties:[[NSAttributedString.Key:Any]]){
        if let attribText = self.attributedText as? NSMutableAttributedString{
            /*
             var strokeTextAttributes = [NSAttributedStringKey: Any]();
             for prop in properties {
             for key in prop.keys  {
             strokeTextAttributes[key] = prop[key];
             }
             }
             */
            attribText.addStringWithStyle(str: str, properties: properties);//.append(NSAttributedString(string: str, attributes: strokeTextAttributes));
            
            self.attributedText = attribText;
        }
    }
    
    public func addImage(image:UIImage){
        if let attribText = self.attributedText as? NSMutableAttributedString{
            if let imageObj = image as UIImage? {
                /*
                 let imageAttachment : NSTextAttachment = NSTextAttachment()
                 imageAttachment.image = imageObj;
                 imageAttachment.bounds = CGRect(x: 0, y: -3, width: imageObj.size.width, height: imageObj.size.height);
                 attribText.append(NSAttributedString(attachment: imageAttachment))
                 */
                attribText.addImage(image: imageObj);
                self.attributedText = attribText;
            }
        }
    }
    
    public func addImage(image:UIImage,point:CGPoint){
        if let attribText = self.attributedText as? NSMutableAttributedString{
            if let imageObj = image as UIImage? {
                /*
                 let imageAttachment : NSTextAttachment = NSTextAttachment()
                 imageAttachment.image = imageObj;
                 imageAttachment.bounds = CGRect(x: point.x, y: point.y, width: imageObj.size.width, height: imageObj.size.height);
                 attribText.append(NSAttributedString(attachment: imageAttachment))
                 */
                attribText.addImage(image: imageObj, point: point);
                self.attributedText = attribText;
            }
        }
    }
}

public class SJStringStyle {
   public static func Font(font:UIFont)->[NSAttributedString.Key:Any]{
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .font : font
        ]
        return strokeTextAttributes;
    }
    
   public static func Color(color:UIColor)->[NSAttributedString.Key:Any]{
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : color
        ]
        return strokeTextAttributes;
    }
    
   public static func LineSpace(space:Float)->[NSAttributedString.Key:Any]{
        let objParagraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
        objParagraphStyle.alignment = NSTextAlignment.left;
        objParagraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping;
        //    objParagraphStyle.lineSpacing = lineSpace;
        objParagraphStyle.lineHeightMultiple = CGFloat(space);
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle : objParagraphStyle
        ]
        return strokeTextAttributes;
    }
    
   public static func LineSpace(space:Float,Alignment:NSTextAlignment)->[NSAttributedString.Key:Any]{
        let objParagraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
        objParagraphStyle.alignment = Alignment;
        objParagraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping;
        //    objParagraphStyle.lineSpacing = lineSpace;
        objParagraphStyle.lineHeightMultiple = CGFloat(space);
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle : objParagraphStyle
        ]
        return strokeTextAttributes;
    }
    
    public static func SuperScript(value:NSNumber) -> [NSAttributedString.Key:Any]{
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            ((kCTSuperscriptAttributeName as CFString) as NSAttributedString.Key ) : value
        ]
        return strokeTextAttributes;
    }
    /*
     
     +(instancetype)initWithSuperScriptValue:(NSNumber*)value ofFont:(UIFont*)font{
     SJStringStyle * tmpObj =(SJStringStyle*)[[NSDictionary alloc] init];
     if(value && font){
     tmpObj = (SJStringStyle*)@{((NSString*)kCTSuperscriptAttributeName):value,((NSString*)kCTFontAttributeName):font};
     }
     return tmpObj;
     }
     
     */
}


class SJTabBar:UITabBar{
    //    -(CGSize)sizeThatFits:(CGSize)size
    //    {
    //    CGSize sizeThatFits = [super sizeThatFits:size];
    //    if(_height){
    //    sizeThatFits.height = _height;
    //    }
    //    return sizeThatFits;
    //    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits:CGSize = super.sizeThatFits(size);
        sizeThatFits.height = 56;
        return sizeThatFits;
    }
}


open class SJViewController: UIViewController {
    
    private var viewLoader:UIView?;
    lazy var slideInTransitioningDelegate = SlideInPresentationManager();
    var isKeyboardNotificationRegister:Bool = false;
    
    override open func viewDidDisappear(_ animated: Bool) {
        if(isKeyboardNotificationRegister){
            self.removeKeyboardNotifications();
        }
    }
    
    func setPresentStyle(direction:PresentationDirection) -> Void {
        slideInTransitioningDelegate.direction = direction
        slideInTransitioningDelegate.disableCompactHeight = true
        self.transitioningDelegate = slideInTransitioningDelegate
        self.modalPresentationStyle = .custom
    }
    
    public func showMessage(message :String) -> Void {
        let alert:UIAlertController = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { (alertAction) in
            //self.dismiss(animated: true, completion: nil);
        }))
        self.present(alert, animated: true) {
            //
        };
    }
    
    
    
    public func registerForKeyboardNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(sjkeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sjkeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sjkeyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        isKeyboardNotificationRegister = true;
    }
    
    public func removeKeyboardNotifications() -> Void {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func sjkeyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
    }
    
    @objc func sjkeyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
        self.keyboardWillBeHidden();
    }
    @objc func sjkeyboardWillChange(notification: NSNotification) {
        /*
         let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
         let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
         let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
         let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
         let deltaY = targetFrame.origin.y - curFrame.origin.y
         */
        
        let targetFrame = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue)
        self.keyboardWasUpdatedVisibleSize(size: targetFrame.size);
        
    }
    
    func keyboardWillBeHidden() -> Void {
        //
    }
    
    func keyboardWasUpdatedVisibleSize(size:CGSize) -> Void {
        //
    }
    
    public func showLoader() -> Void {
        DispatchQueue.main.async {
            if let view = self.viewLoader{
                view.frame = view.bounds;
            }else{
                self.viewLoader = SJAPILoader(frame: self.view.bounds);
            }
            self.view.addSubview(self.viewLoader!);
        }
    }
    
    public func hideLoader() -> Void {
        DispatchQueue.main.async {
            if let view = self.viewLoader{
                UIView.animate(withDuration: 0.3, animations: {
                    view.layer.opacity = 0;
                }, completion: { (status) in
                    view.removeFromSuperview();
                    self.viewLoader = nil;
                });
                
            }
        }
    }
}

