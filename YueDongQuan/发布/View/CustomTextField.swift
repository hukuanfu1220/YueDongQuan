//
//  CustomTextField.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/24.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


protocol CustomTextFieldDelegate {
    func getTextString(text: String)
}

class CustomTextField: UITextField,UITextFieldDelegate {

    var textContentLabel : UILabel!
    var labelFrame : CGRect = CGRectZero
    var textFont : UIFont!
    var textDelegate : CustomTextFieldDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    convenience init(frame: CGRect,placehoder:String,fontSize:UIFont) {
        self.init(frame: frame)
        
        self.labelFrame = frame
        self.textFont = fontSize
        self.placeholder = placehoder
        self.textColor = UIColor.clearColor()
        self.clearButtonMode = .WhileEditing
        self.font = fontSize
        self.delegate = self
        createLabel()
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        
    }
    
    
    func textFieldDidChange(sender:UITextField){
        
        let tempStr = sender.text!
        var texts = ""
        if sender.text?.characters.count > 120 {
            texts = tempStr.substringToIndex(tempStr.startIndex.advancedBy(120))
            
        }else{
            texts = tempStr
        }
        
        
        let rect = self.labelTextWithFondSizeWithWidth(texts, fontSize: self.textFont, width: self.textContentLabel.frame.size.width)
        textContentLabel.frame = CGRectMake(self.textContentLabel.frame.origin.x, self.textContentLabel.frame.origin.y, self.textContentLabel.frame.size.width,rect.height < self.labelFrame.size.height ? self.labelFrame.height : rect.height)
        
        self.frame = CGRectMake(self.labelFrame.origin.x, self.labelFrame.origin.y, self.labelFrame.size.width, rect.height < self.labelFrame.size.height ? self.labelFrame.size.height : rect.height)
        
        if sender.text?.characters.count == 0 {
            self.textContentLabel.text = ""
            sender.tintColor = UIColor.blueColor()
        }else{
            self.tintColor = UIColor.clearColor()
            let text = String(format: "%@|", sender.text!)
            let attString = NSMutableAttributedString(string: text)
            attString.addAttributes([NSForegroundColorAttributeName:UIColor.blueColor()], range: NSMakeRange(text.characters.count - 1, 1))
            textContentLabel.attributedText = attString
            
            
        }
    
    }
    
    func createLabel(){
        textContentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.labelFrame.size.width, height: self.labelFrame.size.height))
        textContentLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        textContentLabel.font = self.textFont
        textContentLabel.numberOfLines = 0
        self.addSubview(textContentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func labelTextWithFondSizeWithWidth(text: String,fontSize:UIFont,width:CGFloat) -> CGRect {
        let attributes = [NSFontAttributeName:fontSize]
        let textSize : CGRect = text.boundingRectWithSize(CGSize(width: width,height: 0), options: [NSStringDrawingOptions.TruncatesLastVisibleLine,NSStringDrawingOptions.UsesLineFragmentOrigin,NSStringDrawingOptions.UsesFontLeading], attributes: attributes, context: nil)
        
        return textSize
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        NSLog("开始编辑")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let tempStr = textField.text!
        var texts = ""
        if textField.text?.characters.count > 120 {
            texts = tempStr.substringToIndex(tempStr.startIndex.advancedBy(120))

        }else{
            texts = tempStr
        }
        
        self.textContentLabel.text = texts
        self.textDelegate?.getTextString(texts)
        NSLog("编辑完成")
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        self.textContentLabel.text = ""
        return true
    }
    

}
