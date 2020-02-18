//
//  MenuView.swift
//  IIITB
//
//  Created by Generic Generic on 18/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class MenuView: UIView {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var slideAnimatedView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
      //  let touchTest = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector(("handleTap:")))
       swipeGesture.direction = .left
       // slideAnimatedView.addGestureRecognizer(touchTest)
        slideAnimatedView.addGestureRecognizer(swipeGesture)
    }
    private func setupView() {
        // backgroundColor = .white
    }
    
    class func instanceFromNib() -> UIView {
        

        return UINib(nibName: "MenuView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
         NotificationCenter.default.post(name: Notification.Name("BackButtonAction"), object: nil)
    }
    @IBAction func buttonAction(_ sender: Any) {
        
         NotificationCenter.default.post(name: Notification.Name("BackButtonAction"), object: nil)
    }
    
}
