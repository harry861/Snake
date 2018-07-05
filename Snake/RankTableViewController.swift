//
//  RankTableViewController.swift
//  
//
//  Created by AutumnCAT on 2018/6/27.
//

import UIKit

class RankTableViewController: UITableViewController {

    var users = [User]()
    var checkEdit=false
    @IBOutlet weak var editButtonn: UIBarButtonItem!
    
    @IBAction func goBackToRankTable(segue: UIStoryboardSegue) {
        let controller = segue.source as? EditTableViewController
        
        if let editCheck=controller?.editCheck{
            checkEdit=editCheck
        }
        if let user = controller?.user {
            
            if let row = tableView.indexPathForSelectedRow?.row  {
                users[row] = user
                User.saveToFile(users: users)
            }
            
            tableView.reloadData()
        }
        
    }
    
    @IBAction func editButton(_ sender: Any) {
        if checkEdit{
            editButtonn.title="修改"
            checkEdit=false
        }
        else{
            editButtonn.title="檢視"
            checkEdit=true
        }
    }
    @IBAction func clearUser(_ sender: Any) {
        users.removeAll()
        User.saveToFile(users: users)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userss = User.readLoversFromFile(){
            users=userss
        }
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath) as! RankTableViewCell
        
        let user = users[indexPath.row]
        cell.NOLabel.text = "NO."+String(format: "%02i", user.no)
        cell.pointLabel.text = "分數："+String(format: "%02i", user.point)
        cell.userLabel.text="玩家："+user.user
        cell.descriptionLabel.text="描述："+user.description

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("ssss\n")
        let controller = segue.destination as? EditTableViewController
        
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.user = users[row]
            controller?.editCheck=checkEdit
        }
        print("ssss\n")
    }

}
