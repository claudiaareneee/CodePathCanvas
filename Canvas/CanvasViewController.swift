//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Claudia Nelson on 10/20/18.
//  Copyright © 2018 claudia. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 150
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down

        // Do any additional setup after loading the view.
    }

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)

        if sender.state == .began {
            trayOriginalCenter = trayView.center
            print("Gesture began")
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture is changing")
        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp
                }
            }
            print("Gesture ended")
        }
    }

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
//        let velocity = sender.velocity(in: view)

        if sender.state == .began {
            print("face is started")
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center

            // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))

            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)

        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            print("face is changing")
        } else if sender.state == .ended {
            print("face ended")
        }
    }

    @objc func didPan(sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: view)
//        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)

        if sender.state == .began {
            newlyCreatedFace = (sender.view as! UIImageView) // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            print("didpan began")
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

            print("didpan is changing")
        } else if sender.state == .ended {
            print("didpan ended")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
