//
//  ViewController.swift
//  DrawShapes
//
//  Created by Mohit Totlani on 04/07/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rectView: UIView!
    private var startPoint, endPoint: CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            startPoint = touch.location(in: view)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endPoint = touch.location(in: view)
            drawRectangle()
            
        }
    }
    
    private func drawRectangle(){
        var topLeft, topRight, bottomLeft, bottomRight: CGPoint!
        
        if self.endPoint!.y == self.startPoint!.y {
            let diff = self.endPoint!.x - self.startPoint!.x
            topLeft = startPoint!
            topRight = endPoint!
            bottomLeft = CGPoint(x: self.startPoint!.x, y: self.startPoint!.y + diff)
            bottomRight = CGPoint(x: self.endPoint!.x, y: self.endPoint!.y + diff)
        } else if self.endPoint!.x == self.startPoint!.x{
            let diff = self.endPoint!.y - self.startPoint!.y
            topLeft = startPoint!
            bottomLeft = endPoint!
            topRight = CGPoint(x: self.startPoint!.x + diff, y: self.startPoint!.y)
            bottomRight = CGPoint(x: self.endPoint!.x + diff, y: self.endPoint!.y)
        } else{
            //            let diff = self.endPoint!.x - self.startPoint!.x
            topLeft = startPoint!
            bottomRight = endPoint!
            bottomLeft = CGPoint(x: self.startPoint!.x, y: self.endPoint!.y)
            topRight = CGPoint(x: self.endPoint!.x, y: self.startPoint!.y)
        }
        
        do {
            let rectangleLayer = try getRectangle(rectPoints: [topLeft, topRight, bottomRight, bottomLeft])
            rectView.layer.addSublayer(rectangleLayer)
        } catch {
            debugPrint(error)
        }
        
        
    }
    
    func getRectangle(rectPoints:[CGPoint]) throws -> CAShapeLayer {
        enum PathError : Error{
            case moreThan2PointsNeeded
        }
        
        guard rectPoints.count > 2 else {
            throw PathError.moreThan2PointsNeeded
        }
        
        let lineColor = UIColor.blue
        let lineWidth: CGFloat = 2
        let path = UIBezierPath()
        let pathLayer = CAShapeLayer()
        
        for (index,pathPoint) in rectPoints.enumerated() {
            switch index {
            //First point
            case 0:
                path.move(to: pathPoint)
                
            //Last point
            case rectPoints.count - 1:
                path.addLine(to: pathPoint)
                path.close()
                
            //Middle Points
            default:
                path.addLine(to: pathPoint)
            }
        }
        
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = lineColor.cgColor
        pathLayer.lineWidth = lineWidth
        pathLayer.fillColor = UIColor.clear.cgColor
        
        return pathLayer
    }
    
    @IBAction func reloadButtonPressed(_ sender: UIButton){
        rectView.layer.sublayers = nil
    }
}

