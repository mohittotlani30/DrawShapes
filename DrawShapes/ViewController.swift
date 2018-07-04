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
            if startPoint == nil{
                startPoint = touch.location(in: rectView)
                endPoint = touch.location(in: rectView)
            } else{
                startPoint = endPoint
                endPoint = touch.location(in: rectView)
                addLine(fromPoint: startPoint!, toPoint: endPoint!)
            }
        }
    }
 
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.blue.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.rectView.layer.addSublayer(line)
    }
    
    
    @IBAction func reloadButtonPressed(_ sender: UIButton){
        self.rectView.layer.sublayers = nil
        self.startPoint = nil
        self.endPoint = nil
    }
}

