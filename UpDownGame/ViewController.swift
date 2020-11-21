//
//  ViewController.swift
//  UpDownGame
//
//  Created by 임리나 on 2020/11/20.
//

import UIKit

class ViewController: UIViewController {

    private var currentRound: Int = 0
    private var randomValue: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var currentValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb"), for: .normal)
        reset()
    }

    @IBAction func showSliderValueChanged(sender: UISlider) {
        currentValueLabel.text = "\(Int(sender.value))"
    }

    @IBAction func touchUpHitButton(_ sender: UIButton) {
        currentRound += 1
        changeRoundLabel()
        
        let hitValue = Int(slider.value)
        slider.value = Float(hitValue)

        let currentValue = Int(slider.value)
        currentValueLabel.text = "\(currentValue)"
        
        if currentValue == randomValue {
            showAlert(message: "YOU WIN!")
        } else if currentRound == 5 {
            showAlert(message: "YOU LOSE...")
        } else {
            setValue(by: currentValue)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action) in
                                                        self.reset()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setValue(by currentValue: Int) {
        if currentValue > randomValue {
            slider.maximumValue = Float(currentValue)
            maxValueLabel.text = "\(currentValue)"
        } else {
            slider.minimumValue = Float(currentValue)
            minValueLabel.text = "\(currentValue)"
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        reset()
        
    }
    
    func reset() {
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.setValue(15, animated: true)
    
        maxValueLabel.text = "30"
        minValueLabel.text = "0"
        currentValueLabel.text = "15"
        
        currentRound = 0
        changeRoundLabel()
        
        randomValue = makeRandomValue()
        print(randomValue)
    }
    
    func makeRandomValue() -> Int {
        return Int.random(in: 0...30)
    }
    
    func changeRoundLabel() {
        roundLabel.text = "\(currentRound) / 5"
    }
}
