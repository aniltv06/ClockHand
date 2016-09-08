//
//  ViewController.swift
//  clockHand
//
//  Created by anilkumar thatha. venkatachalapathy on 08/09/16.
//  Copyright © 2016 Anil T V. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var circle:hand!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circle.layer.cornerRadius = 150
        
        circle.layer.shadowOffset = CGSizeMake(5, 5)
        circle.layer.shadowOpacity = 0.7
        circle.layer.shadowRadius = 5
        circle.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor
        
        // Applying borders
        circle.layer.borderColor = UIColor(red: 80.0/255.0, green: 20.0/255.0, blue: 60.0/255.0, alpha: 1.0).CGColor
        circle.layer.borderWidth = 5.0
        /*
        // Bankground images
        circle.layer.contents = UIImage(named: "image.jpg")?.CGImage
        circle.layer.masksToBounds = true
        circle.layer.contentsGravity = kCAGravityResize
        */
        
        let r:CGFloat = 10.0
        let c:CGPoint = CGPointMake(150.0-r, 150.0-r)
        let strokeColor: UIColor = UIColor.blackColor()
        let fillColor: UIColor = UIColor.redColor()
        let centreCircle = CAShapeLayer()
        centreCircle.frame = CGRect(origin:c, size:CGSize(width:2*r, height:2*r))
        centreCircle.path = UIBezierPath(ovalInRect:centreCircle.bounds).CGPath
        centreCircle.fillColor = fillColor.CGColor
        centreCircle.strokeColor = strokeColor.CGColor
        centreCircle.fillColor = fillColor == UIColor.clearColor() ? nil : fillColor.CGColor
        circle.layer.addSublayer(centreCircle)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0/30.0, target: self, selector: #selector(ViewController.rotateHand), userInfo: nil, repeats: true)
        
        let sliderOrigin = self.view.bounds.size.width/2-280/2
        let sliderDemo = UISlider(frame:CGRectMake(sliderOrigin, 550, 280, 20))
        sliderDemo.minimumValue = 0
        sliderDemo.maximumValue = 100
        sliderDemo.continuous = true
        sliderDemo.tintColor = UIColor.redColor()
        sliderDemo.value = 50
        sliderDemo.addTarget(self, action: #selector(ViewController.sliderValueDidChange(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(sliderDemo)
        
    }
    
    func sliderValueDidChange(sender:UISlider!)
    {
        print("value--\(sender.value)")
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

    override func drawRect(rect: CGRect) {
        
        let c :CGContextRef = UIGraphicsGetCurrentContext()!
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
        
        CGContextSetStrokeColor(c, red);
        CGContextBeginPath(c);
        CGContextSetLineWidth(c, 3.0)
        CGContextMoveToPoint(c, CGFloat(pointX), CGFloat(pointY));
        CGContextAddLineToPoint(c, CGFloat(pointX1), CGFloat(pointY1));
        CGContextStrokePath(c);
    }
}