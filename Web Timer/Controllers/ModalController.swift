//
//  ModalController.swift
//  Web Timer
//
//  Created by DS on 12/5/20.
//

import UIKit
import WebKit
class ModalController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var label: UILabel!
    var button: UIButton!
    let currentBrightness = UIScreen.main.brightness

    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    var webAddress = ""
    var timerSeconds = 0
    var timer = Timer()
    
    var history = [String]()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func cancelBtnPressed(_ sender: Any) {
    }
    @IBOutlet weak var timeLeft: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 50/255, green: 130/255, blue: 184/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        label = UILabel(frame: CGRect(x: view.frame.width - 92, y: 0, width: 100, height: 20))
        label.translatesAutoresizingMaskIntoConstraints = true
        label.textColor = .white
        label.text = "00:00:00"
        view.addSubview(label)
        
        _ = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y:40, width: view.frame.width, height : view.frame.height - 40))
        view.addSubview(webView)
        
//        UIApplication.shared.isIdleTimerDisabled = true
        UIScreen.main.brightness = CGFloat(0.15)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        print("Web Address: \(webAddress)")
        print("Time: \(timerSeconds)")
        print("Timer started")
        
        let myURL = URL(string:"https://\(webAddress)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
//        view.addSubview(label)
//        view.addSubview(webView)
//
//        // horizontal constraints
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|[label]|", options: [], metrics: nil, views: ["label": label!]))
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|[webView]|", options: [], metrics: nil, views: ["webView": webView!]))
//
//        // vertical constraints
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label][webView]|", options: [], metrics: nil, views: ["label": label!, "webView": webView!]))
    }
    
    @objc func buttonAction(sender: UIButton!) {
        timerEnd()
    }
    
    @objc func updateTimer() {
        if timerSeconds < 0 {
            timerEnd()
        } else {
            timerSeconds -= 1
            label.text = timeString(time: TimeInterval(timerSeconds))
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
        timer.invalidate()
//        exit(-1)
        UIScreen.main.brightness = currentBrightness
        self.presentingViewController?.dismiss(animated: false, completion:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            print("Closing modal.")
        }
    }
    
}


