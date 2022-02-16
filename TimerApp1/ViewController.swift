//
//  ViewController.swift
//  TimerApp1
//
//  Created by Reyhaan Alim on 12/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartStopButton.setTitleColor(UIColor.green, for: .normal)
        containerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = CGFloat(10)
    }

    @IBAction func ResetTapped(_ sender: Any)
    {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "CONFIRM", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.StartStopButton.setTitle("START", for: .normal)
            self.StartStopButton.setTitleColor(UIColor.yellow, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func StartStopTapped(_ sender: Any)
    {
    if(timerCounting)
    {
     timerCounting = false
        timer.invalidate()
        //StartStopButton.setTitle("START", for: .normal)
        //StartStopButton.setTitleColor(UIColor.yellow, for: .normal)
        let StartStopButtonattributedtitle = NSAttributedString(string: "START", attributes: [.foregroundColor:UIColor.yellow,.font:UIFont.systemFont(ofSize: 40, weight: .heavy)])
        StartStopButton.setAttributedTitle(StartStopButtonattributedtitle, for: .normal)
    }
      else
      {
          timerCounting = true
          //StartStopButton.setTitle("STOP", for: .normal)
          //StartStopButton.setTitleColor(UIColor.red, for: .normal)
          timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
          let StartStopButtonattributedtitle = NSAttributedString(string: "STOP", attributes: [.foregroundColor:UIColor.red,.font:UIFont.systemFont(ofSize: 40, weight: .heavy)])
          StartStopButton.setAttributedTitle(StartStopButtonattributedtitle, for: .normal)
      }
        
    }
    
    
    
    @objc func timerCounter() -> Void
    {
     count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

