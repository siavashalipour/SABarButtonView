//
//  SABarButtonView.swift
//  Pods
//
//  Created by Siavash on 27/09/2015.
//  Copyright © 2015 Siavash. All rights reserved.
//

import UIKit
@IBDesignable

/**
The purpose of this class is to create a custom tabBar view

@param btnsTitles is an array of string that will be the title of the TabBarButtons titles.
@param toggleAbleViews is an IBOutletCollection that hold the views that should be toggeled
@param other params are modifiable via interface builder

@return CustomTabBarView.
*/
public class SABarButtonView: UIView {
    
    ///Keep an array of buttons that are associated views for toggle
    private var btnsArray = Array<UIButton>()
    ///keep an array of views which are related to the tab buttons and highlighted when the tab is selected
    private var underlineViews = Array<UIView>()
    
    ///Should set by the user and should be in order of appearance
    var btnsTitles = Array<String>()
    
    ///hold a collection of views that we want to toggle
    @IBOutlet var toggleAbleViews: [UIView]!
    
    ///identifies the postion of the tabBar Buttons. For now it only supports top(on) and bottom(off) - default is top(on)
    @IBInspectable var isPositionTop:Bool = true
    
    ///Number of tabBar buttons
    @IBInspectable var buttonsNum: Int = 1
    
    ///tabBar buttons size. height is fixed however the width scaled to fill the view appropriately - default is (44, 44)
    @IBInspectable var buttonSize:CGSize = CGSizeMake(44, 44)
    
    ///set the tabBar buttons radious and the underlineView radius
    @IBInspectable var cornerRadius:CGFloat = 0
    
    ///set the tabBarButtons text color - default is white
    @IBInspectable var titleColor:UIColor = UIColor.whiteColor()
    
    ///set the font based on the name string - default is "Helvetica Neue"
    @IBInspectable var fontName:String = "Helvetica Neue"
    
    ///set the font size - default is 17
    @IBInspectable var fontSize:CGFloat = 17
    
    ///set the padding between buttons, also top padding from the view, left and right padding from the view and the bottom padding from the separator if its exists - default is 5
    @IBInspectable var padding: CGFloat = 5
    
    ///tabBar buttons selected state background color - default is UIColor.blueColor()
    @IBInspectable var selectedColor:UIColor = UIColor.blueColor()
    
    ///tabBar buttons normal state background color - default is UIColor.redColor()
    @IBInspectable var normalColor:UIColor = UIColor.redColor()
    
    ///boolean for showing or not showing the separator - default is to show the separator
    @IBInspectable var showSeparator:Bool = true
    
    ///Separator color - defualt is UIColor.lightGrayColor()
    @IBInspectable var separatorColor:UIColor = UIColor.lightGrayColor()
    
    ///Separator height - default is 1.0
    @IBInspectable var separatorHeight:CGFloat = 1.0
    
    ///underlineViews color - default is UIColor.clearColor() . i.e. to enable this functionality you need to set the color in Interface Builder
    @IBInspectable var lineColor:UIColor = UIColor.clearColor()
    
    ///UnderlineViews height - default is 1.0
    @IBInspectable var lineHeight:CGFloat = 1
    
    ///UnderlineViews selected state color - default is UIColor.clearColor()
    @IBInspectable var lineSelectedColor:UIColor = UIColor.clearColor()
    
    // MARK: Live Drawing
    override public func drawRect(rect: CGRect) {
        if self.frame.width > CGFloat(self.buttonsNum) * (self.padding + self.buttonSize.width) {
            let btnWidth = self.frame.width - CGFloat(self.buttonsNum+1)*self.padding
            self.buttonSize.width = btnWidth / CGFloat(self.buttonsNum)
        }
        let y = isPositionTop ? padding : self.frame.height - padding - buttonSize.height
        
        for var i=0; i < buttonsNum; i++ {
            
            let x = CGFloat(i * Int(floor((self.buttonSize.width + self.padding)))) + self.padding
            let frame = CGRectMake(x, y, self.buttonSize.width, self.buttonSize.height)
            let btn = UIButton(frame: frame)
            btn.tag = i
            btn.backgroundColor = self.normalColor
            btn.layer.cornerRadius = cornerRadius
            btn.addTarget(self, action: "toggleView:", forControlEvents: UIControlEvents.TouchUpInside)
            
            let font:UIFont = UIFont(name: fontName, size: fontSize)!
            let titleStr:NSString = "UIButton \(i)"
            let mutableAttrString = NSMutableAttributedString(string: "UIButton \(i)", attributes: [NSFontAttributeName:font])
            mutableAttrString.addAttribute(NSForegroundColorAttributeName, value: titleColor, range: NSRange(location:0,length:titleStr.length))
            btn.setAttributedTitle(mutableAttrString, forState: UIControlState.Normal)
            
            self.addSubview(btn)
            self.btnsArray.append(btn)
            var underlineViewFrame = frame
            underlineViewFrame.size.height = self.lineHeight
            underlineViewFrame.origin.y = frame.origin.y + frame.size.height - self.lineHeight
            underlineViewFrame.origin.x = x
            let underlineView = UIView(frame: underlineViewFrame)
            underlineView.backgroundColor = self.lineColor
            underlineView.tag = i
            underlineView.layer.cornerRadius = cornerRadius > 0 ? lineHeight/2.0 : 0
            self.addSubview(underlineView)
            self.underlineViews.append(underlineView)
            
        }
        if showSeparator {
            let sepratorY = isPositionTop ? self.buttonSize.height+2*self.padding : y - padding
            let separatorFrame = CGRectMake(0, sepratorY, self.frame.width, self.separatorHeight)
            let sepView = UIView(frame: separatorFrame)
            sepView.backgroundColor = self.separatorColor
            self.addSubview(sepView)
        }
        self.btnsArray[0].backgroundColor = self.selectedColor
        self.underlineViews[0].backgroundColor = lineSelectedColor
        #if !TARGET_INTERFACE_BUILDER
            self.setupTitlesAndViews()
        #endif
    }
    
    // MARK: Private Runtime function
    private func setupTitlesAndViews() {
        
        // check to see if we have title for all of the buttons, if not we will crash!
        assert(buttonsNum == self.btnsTitles.count, "Number of Buttons which is \(buttonsNum) does not match the Number of titles \(self.btnsTitles.count) you should have equal number of buttons and btnTitles")
        
        // check to see if we have enough views to toggle
        assert(buttonsNum == self.toggleAbleViews.count, "Number of Buttons which is \(buttonsNum) does not match the Number of toggleAbleViews \(self.btnsTitles.count). You need a view for each buttons. Please make sure that you have connected all of your views to toggleAbleViews IBOutletCollection")
        
        var y = isPositionTop ? padding + buttonSize.height : 0
        y += showSeparator && isPositionTop ? separatorHeight+padding : 0
        
        for var i = 0; i < buttonsNum; i++ {
            let font:UIFont = UIFont(name: fontName, size: fontSize)!
            let height = self.frame.size.height - 2*padding - buttonSize.height
            let viewFrame = CGRectMake(0, y, self.frame.size.width, height)
            let mutableAttrString = NSMutableAttributedString(string: self.btnsTitles[i], attributes: [NSFontAttributeName:font])
            
            mutableAttrString.addAttribute(NSForegroundColorAttributeName, value: titleColor, range: NSRange(location:0,length:(self.btnsTitles[i] as NSString).length))
            self.btnsArray[i].setAttributedTitle(mutableAttrString, forState: UIControlState.Normal)
            self.toggleAbleViews[i].tag = i
            self.toggleAbleViews[i].hidden = true
            self.toggleAbleViews[i].frame = viewFrame
            self.addSubview(self.toggleAbleViews[i])
        }
        self.toggleAbleViews[0].hidden = false
        self.bringSubviewToFront(self.toggleAbleViews[0])
    }
    
    // MARK: UIButtons Actions
    internal func toggleView(sender:UIButton) {
        for btn in self.btnsArray {
            if btn.tag == sender.tag {
                btn.backgroundColor = self.selectedColor
                self.underlineViews[btn.tag].backgroundColor = lineSelectedColor
                self.bringSubviewToFront(self.toggleAbleViews[btn.tag])
                self.toggleAbleViews[btn.tag].hidden = false
            } else {
                btn.backgroundColor = self.normalColor
                self.underlineViews[btn.tag].backgroundColor = lineColor
                self.toggleAbleViews[btn.tag].hidden = false
            }
        }
    }
}
