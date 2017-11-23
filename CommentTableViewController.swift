//
//  CommentTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/12/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController {
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBAction func MenuButtonClicked(_ sender: Any) {
        revealMenu()
    }
    
    let settingLauncher = SettingLauncher()
    var commentsDS: CommentDataSource?
    var downloadAssistant = DownloadComments(withURLString: "https://blue.cs.sonoma.edu/~dsmith/")
    
    func revealMenu(){
        settingLauncher.revealMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        downloadAssistant.addObserver(self, forKeyPath: "dataFromServer", options: .old, context: nil) //whenever the data changes on this object or it completes its download Observe
        downloadAssistant.download_request() // store the downloaded
        title = "Comments"
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(downloadAssistant.dataFromServer!)
        commentsDS = CommentDataSource(dataSource: downloadAssistant.dataFromServer!) //say that the data has been downloaded and is ready to use
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    
    deinit {
        downloadAssistant.removeObserver(self, forKeyPath: "dataFromServer", context: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cds = commentsDS { //if data source is set, which is checked in the observationValue
            print(cds.numComments())
            return cds.numComments()
            
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        if let theCell = cell as? CommentTableViewCell, let comment = commentsDS?.commentAt(indexPath.row) {
            print("calling useforum()")
            theCell.useComment(comment)
        }
        
        return cell
    }
    
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowForumDetails" {
            /*
             if let row = tableView.indexPathForSelectedRow?.row {
             let artist = artistsDS?.artistAt(row)
             let detailedVC = segue.destinationViewController as! ArtistDetailedViewController
             detailedVC.artistForThisView(artist!)
             }
             */
            // OR
            let cell = sender as! ForumTableViewCell
            if let indexPath = tableView.indexPath(for: cell), let ds = forumsDS {
                let detailedVC = segue.destination as! ForumDetailsViewController
                detailedVC.forumForThisView(ds.forumAt(indexPath.row))
            }
        }
     }
 */
}
