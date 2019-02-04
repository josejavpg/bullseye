//
//  ViewController.swift
//  BullsEye
//
//  Created by Community Manager on 1/30/19.
//  Copyright © 2019 josepabon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
      
      //Setup slider UI
      // thumb (circle)
      let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")
      slider.setThumbImage(thumbImageNormal, for: .normal)
      let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Normal")
      slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
      
      // tracker (line after anb befor thumb)
      let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
      
      let trackLeftImage = UIImage(named: "SliderTrackLeft")!
      let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
      slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    
      let trackRightImage = UIImage(named: "SliderTrackRight")!
      let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
      slider.setMaximumTrackImage(trackRightResizable, for: .normal)
      
  }

    @IBAction func showAlert(_ sender: Any) {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        var title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5{
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        }else if difference < 10{
            title = "Pretty good!"
        }else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        round += 1
        currentValue = 50
        targetValue = Int.random(in: 1...100)
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        crossFadeAnimation()
    }
    
  fileprivate func crossFadeAnimation() {
    // Crossfade Animation
    let transition = CATransition()
    transition.type = CATransitionType.fade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    view.layer.add(transition, forKey: nil)
  }
  
  func startNewGame() {
        score = 0
        round = 0
        startNewRound()
      
    crossFadeAnimation()
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    
}

