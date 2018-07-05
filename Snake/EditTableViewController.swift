//
//  EditTableViewController.swift
//  
//
//  Created by AutumnCAT on 2018/6/27.
//

import UIKit

class EditTableViewController: UITableViewController {

    var user: User?
    var editCheck: Bool?
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goBackToRankTableWithSegue", sender: nil)
    }
    
    
    

    @IBOutlet weak var NOLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionn: UITextField!
    @IBOutlet weak var pointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user != nil{
            if let user = user {
                descriptionn.text = user.description
                NOLabel.text="名次：NO."+String(format: "%02i", user.no)
                userLabel.text="玩家名稱："+user.user
                pointLabel.text="分數："+String(format: "%02i", user.point)
            }
            if let editCheck=editCheck{
                if editCheck{
                    descriptionn.isEnabled=true
                }
                else{
                    descriptionn.isEnabled=false
                }
            }
        }
    }

   
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if user == nil {
            user = User(no:0,point:0, user:"s" ,description: descriptionn.text!)
        } else {
            user?.description = descriptionn.text!
        }
    }
    

    

    

}
