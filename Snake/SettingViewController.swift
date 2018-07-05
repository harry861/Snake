//
//  SettingViewController.swift
//  Snake
//
//  Created by AutumnCAT on 2018/6/27.
//  Copyright © 2018年 AutumnCAT. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    var setting=Setting.readLoversFromFile()
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var speedLabel: UITextField!

    
    
    
    @IBAction func nameChange(_ sender: Any) {
        setting?.name=nameLabel.text!
    }
   
    @IBAction func speedChange(_ sender: UIButton) {
        if sender.titleLabel?.text=="+"{
            if let sp=setting?.speed{
                if sp != 20{
                    setting?.speed+=1
                }
            }
        }
        if sender.titleLabel?.text=="-"{
            if let sp=setting?.speed{
                if sp != 0{
                    setting?.speed-=1
                }
            }
        }
        speedLabel.text=String(format: "%02i", (setting?.speed)!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let setting = setting{
            nameLabel.text=setting.name
            speedLabel.text=String(format: "%02i", setting.speed)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Show the navigation bar on other view controllers
        Setting.saveToFile(setting: setting!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
