//
//  ViewController.swift
//  Web Timer
//
//  Created by DS on 12/5/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let picker = UIDatePicker()
    var timer = Timer()
    var webAddress = ""
    var timerSeconds = 900
    var timeSelection = 0
    var timeCount:Int = 0
    var timerStarted = false
    var darkMode = true
    
    let defaults = UserDefaults.standard
    
    var allVisited = [String]()
    var lastVisited = ""
    
    var blackColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    var whiteColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    var darkBlueColor = UIColor(red: 15/255, green: 76/255, blue: 117/255, alpha: 1.0)
    var lightBlueColor = UIColor(red: 50/255, green: 130/255, blue: 184/255, alpha: 1.0)
    var accentColor = UIColor(red: 234/255, green: 84/255, blue: 85/255, alpha: 1.0)
    
    @IBOutlet weak var webTimerTitle: UILabel!
    @IBOutlet weak var webTimerSubtitle: UILabel!
    @IBOutlet weak var webAddressLabel: UILabel!
    @IBOutlet weak var recentBtn: UIButton!
    @IBAction func recentBtnPressed(_ sender: Any) {
        
        getPrefs()
        var newSort = allVisited
        newSort.reverse()
        
        let alert = UIAlertController(title: "Recent Sites", message: nil, preferredStyle: .alert)
        
        for n in 0...(newSort.count - 1) {
            alert.addAction(UIAlertAction(title: String(newSort[n]), style: .default, handler: { action in
                self.webAddressField.text = newSort[n] }))
        }
        
//        alert.addAction(UIAlertAction(title: String(newSort[0]), style: .default, handler: { action in
//            self.webAddressField.text = newSort[0] }))
//
//        alert.addAction(UIAlertAction(title: String(newSort[1]), style: .default, handler: { action in
//            self.webAddressField.text = newSort[1] }))
//
//        alert.addAction(UIAlertAction(title: String(newSort[2]), style: .default, handler: { action in
//            self.webAddressField.text = newSort[2] }))
//
//        alert.addAction(UIAlertAction(title: String(newSort[3]), style: .default, handler: { action in
//            self.webAddressField.text = newSort[3] }))
//
//        alert.addAction(UIAlertAction(title: String(newSort[4]), style: .default, handler: { action in
//            self.webAddressField.text = newSort[4] }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func webAddressAction(_ sender: Any) {
    }
    @IBOutlet weak var webAddressField: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBAction func timePickerSelected(_ sender: Any) {
        timeSelection = Int(timePicker.countDownDuration / 60)
        print(timeSelection)
//        if !timerStarted {
//            timerSeconds = Int(timePicker.countDownDuration)
//            print(timerSeconds)
//        }
        timerSeconds = Int(timePicker.countDownDuration)
    }
    
    @IBOutlet weak var startBtn: UIButton!
    @IBAction func startBtnPressed(_ sender: Any) {

//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStarted = true
        
        webAddress = webAddressField.text!
        setPrefs()
        
        if webAddress == "" {
            webAddress = lastVisited
        }
        
        print("Web Address: \(webAddress)")
        print("Time: \(timerSeconds)")
        print("Timer started")
        
        let secondVC = ModalController()
        secondVC.webAddress = webAddress
        secondVC.timerSeconds = timerSeconds
        self.present(secondVC, animated: true, completion: nil)
    }

    @IBOutlet weak var quickStartBtn1: UIButton!
    @IBOutlet weak var quickStartBtn2: UIButton!
    @IBOutlet weak var quickStartBtn3: UIButton!
    
    @IBAction func quickStartBtnsPressed(_ sender: UIButton) {
        
        if webAddress == "" {
            webAddress = lastVisited
        }
        
        print(sender.tag)
        switch sender.tag {
        case 0: timerSeconds = 30 * 60
        case 1: timerSeconds = 60 * 60
        case 3: timerSeconds = 120 * 60
        default: print("No tag received.")
        }
        timerStarted = true
        webAddress = webAddressField.text!
        setPrefs()
        print("Web Address: \(webAddress)")
        print("Time: \(timerSeconds)")
        print("Timer started")
        let secondVC = ModalController()
        secondVC.webAddress = webAddress
        secondVC.timerSeconds = timerSeconds
        self.present(secondVC, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var stopTimerBtn: UIButton!
    @IBAction func stopTimerPressed(_ sender: Any) {
        timer.invalidate()
        timerEnd()
    }
    
    @IBOutlet weak var timerView: UILabel!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var darkModeToggle: UISwitch!
    
    @IBAction func darkModeToggleAction(_ sender: Any) {
        if darkMode {
            darkMode = false
        } else {
            darkMode = true
        }
        defaults.set(darkMode, forKey: "darkModePref")
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPrefs()
        updateUI()
        
        self.hideKeyboardWhenTappedAround()
        self.webAddressField.delegate = self
        
        webAddressField.layer.borderWidth = 1
        webAddressField.layer.cornerRadius = 4
        
        timePicker.countDownDuration = 900
        
        UISwitch.appearance().onTintColor = lightBlueColor
        
        stopTimerBtn.isHidden = true
        timerView.isHidden = true
        
//        timer.tolerance = 0.2
        
//        timer.invalidate()
          
//        timePicker.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
//        timePicker.setValue(UIColor(red: 50/255, green: 130/255, blue: 184/255, alpha: 1.0), forKeyPath: "textColor")
//        
//        startBtn.backgroundColor = .darkGray
        startBtn.layer.cornerRadius = 5
        quickStartBtn1.layer.cornerRadius = 5
        quickStartBtn2.layer.cornerRadius = 5
        quickStartBtn3.layer.cornerRadius = 5
//        startBtn.layer.borderWidth = 1
//        startBtn.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func updateTimer() {
        if timerSeconds < 0 {
            timerEnd()
        } else {
            timerView.text = timeString(time: TimeInterval(timerSeconds))
            timerSeconds -= 1
            print(timeString(time: TimeInterval(timerSeconds)))
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @objc func timerEnd(){
           print("Timer Ended!")
        timerView.text = "Stopped"
        timer.invalidate()
        }
    
    func updateUI() {
        if darkMode {
            
            self.view.backgroundColor = .black
            
            webTimerTitle.textColor = lightBlueColor
            webTimerSubtitle.textColor = lightBlueColor
            webAddressLabel.textColor = lightBlueColor
            recentBtn.tintColor = lightBlueColor
            webAddressField.textColor = lightBlueColor
            webAddressField.attributedPlaceholder = NSAttributedString(string:"www.website.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            webAddressField.layer.borderColor = CGColor(red: 50/255, green: 130/255, blue: 184/255, alpha: 1.0)
            timePicker.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            timePicker.setValue(UIColor(red: 50/255, green: 130/255, blue: 184/255, alpha: 1.0), forKeyPath: "textColor")
            
            startBtn.setTitleColor(.black, for: .normal)
            quickStartBtn1.setTitleColor(.black, for: .normal)
            quickStartBtn2.setTitleColor(.black, for: .normal)
            quickStartBtn3.setTitleColor(.black, for: .normal)
            
            darkModeLabel.textColor = lightBlueColor
            darkModeToggle.setOn(true, animated: true)
            defaults.set(true, forKey: "Mode")
            
        } else {

            self.view.backgroundColor = .white
            
            webTimerTitle.textColor = darkBlueColor
            webTimerSubtitle.textColor = darkBlueColor
            webAddressLabel.textColor = darkBlueColor
            recentBtn.tintColor = lightBlueColor
            webAddressField.textColor = darkBlueColor
            webAddressField.attributedPlaceholder = NSAttributedString(string:"www.website.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            webAddressField.layer.borderColor = CGColor(red: 15/255, green: 76/255, blue: 117/255, alpha: 1.0)
            timePicker.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            timePicker.setValue(UIColor(red: 15/255, green: 76/255, blue: 117/255, alpha: 1.0), forKeyPath: "textColor")
            
            startBtn.setTitleColor(.white, for: .normal)
            quickStartBtn1.setTitleColor(.white, for: .normal)
            quickStartBtn2.setTitleColor(.white, for: .normal)
            quickStartBtn3.setTitleColor(.white, for: .normal)
            
            darkModeLabel.textColor = darkBlueColor
            darkModeToggle.setOn(false, animated: true)
            defaults.set(false, forKey: "Mode")
            
        }
    }
    
    func getPrefs() {
        allVisited = defaults.stringArray(forKey: "History") ?? [""]
        darkMode = defaults.bool(forKey: "Mode")
        
        if let ind = allVisited.firstIndex(of:"") {
          allVisited.remove(at:ind)
        }
        
        lastVisited = String(describing: allVisited.last!)
        
        print(allVisited)
        
        print("All websites visited: \(String(describing: allVisited))")
        print("Last website visited: \(String(describing: lastVisited))")
        print("Dark Mode preference: \(darkMode)")
    }
    
    func setPrefs() {
        
        if let ind = allVisited.firstIndex(of:"") {
          allVisited.remove(at:ind)
        }
        
        if let ind = allVisited.firstIndex(of:webAddress) {
          allVisited.remove(at:ind)
        }
        
        allVisited.append(webAddress)
        if allVisited.count > 5 {
            allVisited = allVisited.suffix(5)
        }
        defaults.set(allVisited, forKey: "History")
        defaults.set(darkMode, forKey: "Mode")
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
