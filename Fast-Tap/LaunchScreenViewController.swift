//
//  LaunchScreenViewController.swift
//  Fast-Tap
//
//  Created by Dylan O'Leary on 2019-08-05.
//  Copyright © 2019 Dylan O'Leary. All rights reserved.
//

import UIKit

extension UILabel {
    func startMenuText() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}

extension UIButton {
    func startButtonStyle() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
        self.titleLabel?.textDropShadow()
    }
}

class LaunchScreenViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set BG Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview((backgroundImage), at: 0)
        // Do any additional setup after loading the view.
        startButton.startButtonStyle()
        titleLabel.startMenuText()
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
