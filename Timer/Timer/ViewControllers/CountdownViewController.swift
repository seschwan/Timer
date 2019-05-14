//
//  ViewController.swift
//  Timer
//
//  Created by Seschwan on 5/13/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    @IBOutlet weak var countDownPickerView: CountdownPicker!
    @IBOutlet weak var countDownLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    private let countdown: Countdown = Countdown()

    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.layer.cornerRadius = 10
        resetBtn.layer.cornerRadius = 10
        self.countdown.duration = countDownPickerView.duration
        self.countdown.delegate = self
        
        self.countDownPickerView.countdownDelegate = self
        
        // Use a fixed width font.
        
        self.countDownLbl.font = UIFont.monospacedDigitSystemFont(ofSize: self.countDownLbl.font.pointSize, weight: .medium)
        updateViews()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SS"
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        return formatter
    }()
    
    func string(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
    
    @IBAction func startBtnTapped(_ sender: UIButton) {
        //let timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: false, block: timerFinished(time:))
        
        self.countdown.start()
        
        //self.showAlert()
    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        self.countdown.reset()
        self.updateViews()
    
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Timer Finished", message: "Your Countdown is Over", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func timerFinished(time: Timer) {
        self.updateViews()
        self.showAlert()
    }
    
}

extension CountdownViewController: CountdownDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
    
    func countdownDidFinish() {
        updateViews()
        self.showAlert()
    }
    
    
    private func updateViews() {
        self.countDownLbl.text = string(from: countdown.timeRemaining)
        
        switch self.countdown.state {
        case .started:
            self.countDownLbl.text = string(from: countdown.timeRemaining)
        case .finished:
            self.countDownLbl.text = string(from: 0)
        case .reset:
            self.countDownLbl.text = string(from: self.countdown.duration)
        }
    }
}

extension CountdownViewController: CountdownPickerDelegate {
    func countdownPickerDidSelect(duration: TimeInterval) {
        //Update countdown
        self.countdown.duration = duration
        self.updateViews()
    }
    
    
    
}
