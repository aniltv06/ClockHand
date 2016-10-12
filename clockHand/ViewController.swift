//
//  ViewController.swift
//  clockHand
//
//  Created by anilkumar thatha. venkatachalapathy on 08/09/16.
//  Copyright © 2016 Anil T V. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate var circle:hand!
    @IBOutlet var label : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circle.layer.cornerRadius = 150
        
        circle.layer.shadowOffset = CGSize(width: 5, height: 5)
        circle.layer.shadowOpacity = 0.7
        circle.layer.shadowRadius = 5
        circle.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        // Applying borders
        circle.layer.borderColor = UIColor(red: 80.0/255.0, green: 20.0/255.0, blue: 60.0/255.0, alpha: 1.0).cgColor
        circle.layer.borderWidth = 5.0
        /*
        // Bankground images
        circle.layer.contents = UIImage(named: "image.jpg")?.CGImage
        circle.layer.masksToBounds = true
        circle.layer.contentsGravity = kCAGravityResize
        */
        
        let r:CGFloat = 10.0
        let c:CGPoint = CGPoint(x: 150.0-r, y: 150.0-r)
        let strokeColor: UIColor = UIColor.black
        let fillColor: UIColor = UIColor.red
        let centreCircle = CAShapeLayer()
        centreCircle.frame = CGRect(origin:c, size:CGSize(width:2*r, height:2*r))
        centreCircle.path = UIBezierPath(ovalIn:centreCircle.bounds).cgPath
        centreCircle.fillColor = fillColor.cgColor
        centreCircle.strokeColor = strokeColor.cgColor
        centreCircle.fillColor = fillColor == UIColor.clear ? nil : fillColor.cgColor
        circle.layer.addSublayer(centreCircle)
        
        _ = Timer.scheduledTimer(timeInterval: 1.0/30.0, target: self, selector: #selector(ViewController.rotateHand), userInfo: nil, repeats: true)
        
        let sliderOrigin = self.view.bounds.size.width/2-280/2
        let sliderYAxis = self.view.bounds.size.height/2+260/2
        let sliderDemo = UISlider(frame:CGRect(x: sliderOrigin, y: sliderYAxis, width: 280, height: 20))
        sliderDemo.minimumValue = 0
        sliderDemo.maximumValue = 100
        sliderDemo.isContinuous = true
        sliderDemo.tintColor = UIColor.red
        sliderDemo.value = 50
        label?.text = "50.0"
        sliderDemo.addTarget(self, action: #selector(ViewController.sliderValueDidChange(_:)), for: .valueChanged)
        self.view.addSubview(sliderDemo)
        
    }
    
    func sliderValueDidChange(_ sender:UISlider!)
    {
        print("value--\(sender.value)")
        label?.text = sender.value.description
        circle.radian = sender.value/100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rotateHand(){
        circle.setNeedsDisplay()
    }
}

class hand : UIView {
 
    var pointX, pointY, pointX1, pointY1 : Float
    var radian : Float
    required init(coder aDecoder: NSCoder) {
            pointX = 150.0
            pointY = 150.0
            pointX1 = 250.0
            pointY1 = 250.0
            radian = 0.5

        super.init(coder: aDecoder)!
    }

    override func draw(_ rect: CGRect) {
        
        let c :CGContext = UIGraphicsGetCurrentContext()!
        let red : [CGFloat] = [1.0, 0.0, 0.0, 1.0]
        let pi = Float(M_PI)
        let degree : Float = (radian * pi) / 180
        
        var x, y : Float
        x = pointX1;
        y = pointY1;
        x -= pointX;
        y -= pointY;
        pointX1 = (x * cos(degree)) - (y * sin(degree));
        pointY1 = (x * sin(degree)) + (y * cos(degree));
        pointX1 += pointX;
        pointY1 += pointY;
        
        c.setStrokeColor(red);
        c.beginPath();
        c.setLineWidth(3.0)
        c.move(to: CGPoint(x: CGFloat(pointX), y: CGFloat(pointY)));
        c.addLine(to: CGPoint(x: CGFloat(pointX1), y: CGFloat(pointY1)));
        c.strokePath();
    }
}
