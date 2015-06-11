//
//  ViewCustomizada.swift
//  BrincandoComSwift2
//
//  Created by Amanda Guimaraes Campos on 10/04/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class ViewCustomizada: UIView {

    var background: CAShapeLayer!
    var lineWidth: Double = 0.0
    
    var pieOverLayer: CAShapeLayer!
    
        @IBInspectable
    var piePercent:Double = 20{
            willSet(newPiePercent) { updatePiePercent(newPiePercent) }
    }
    var pieColor = UIColor(red: 49/255, green: 209/255, blue: 102/255, alpha: 1)
    //var pieColor = UIImage(named: "1.png")
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineWidth = Double(self.frame.size.width)/2
        
        if !(background != nil) {
            background = CAShapeLayer()
            layer.addSublayer(background)
            
            let rect = CGRectInset(bounds, CGFloat(lineWidth / 2.0) ,CGFloat(lineWidth / 2.0))
            let path = UIBezierPath(ovalInRect: rect)
            
            background.path = path.CGPath
            
            background.fillColor = nil
            background.lineWidth = CGFloat(lineWidth)
            background.strokeColor = UIColor(white: 0.5, alpha: 0.3).CGColor
            
        }
        
        background.frame = layer.bounds
        
        if !(pieOverLayer != nil) {
            pieOverLayer = CAShapeLayer()
            layer.addSublayer(pieOverLayer)
            
            let rect = CGRectInset(bounds, CGFloat(lineWidth/2), CGFloat(lineWidth/2))
            let path = UIBezierPath(ovalInRect: rect)
            
            pieOverLayer.path = path.CGPath
            pieOverLayer.fillColor = nil
            pieOverLayer.lineWidth = CGFloat(lineWidth)
            pieOverLayer.strokeColor = UIColor(red: 49/255, green: 209/255, blue: 102/255, alpha: 1).CGColor
            pieOverLayer.anchorPoint = CGPointMake(0.5, 0.5)
            pieOverLayer.transform = CATransform3DRotate(pieOverLayer.transform, CGFloat(-M_PI/2), 0, 0, 1)
        }
        
       pieOverLayer.frame = layer.bounds
       self.updateLayerProperties()
    }

    func updateLayerProperties() {
        if (pieOverLayer != nil){
           self.pieOverLayer.strokeEnd = CGFloat(piePercent/100)
        }
    }
    
    func updatePiePercent(newPiePercent:Double){
        if(pieOverLayer != nil){
            CATransaction.begin()
            var animacao = CABasicAnimation(keyPath: "strokeEnd")
            animacao.duration = ((newPiePercent/100)-(self.piePercent/100)) * 3
            animacao.fromValue = self.piePercent/100
            animacao.toValue = newPiePercent / 100
            animacao.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            CATransaction.setCompletionBlock({() -> Void in
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                self.pieOverLayer.strokeEnd = CGFloat(newPiePercent/100)
                CATransaction.commit()
            })
            
            self.pieOverLayer.addAnimation(animacao, forKey: "animateStrokeEnd")
            CATransaction.commit()
        }
    }
}

