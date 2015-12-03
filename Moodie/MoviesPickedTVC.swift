//
//  MoviesPickedTVC.swift
//  Moodie
//
//  Created by Anastasia Menshikova on 19/11/2015.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class MoviesPickedTVC: UITableViewController {
    
    var keywords: Keywords?
    var mood = 0
    var moodieRanking : [Double] = [0.0]
    var moodieFinal : [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("movies", ofType:"db")
        let database = FMDatabase(path: path)
        
        if !database.open() {
            print("Unable to open database")
            return
        }
        
        var sql = "SELECT * FROM MOVIES;"
        var rs = database.executeQuery(sql, withArgumentsInArray: nil)
        
        while rs.next() {
            
            let id = Int(rs.intForColumn("ID"))
            let dbKeywords = String(rs.stringForColumn("KEYWORDS"))
            let dbRating = Double(rs.doubleForColumn("RATING"))
            
            moodieRanking.append(100.0)
            
            
            for kword in keywords!.entries {
                if kword.2 == 0 {continue}
                
                let selectedKeyword = kword.0.stringByReplacingOccurrencesOfString(" ", withString:"-")
                
                if dbKeywords.rangeOfString(selectedKeyword) != nil {
                    moodieRanking[id] += 100.0
                    
                }
            }
            
            moodieRanking[id] *= dbRating
            
        }


        
        
        for _ in 0...9 {
            var max = 0.0
            var maxIndex = 0
            
            for j in 1...(moodieRanking.count-1) {
                if moodieRanking[j] > max {
                    max = moodieRanking[j]
                    maxIndex = j
                }
            }
            
            sql = "SELECT * FROM MOVIES WHERE ID = \(maxIndex);"
            rs = database.executeQuery(sql, withArgumentsInArray: nil)
            
            rs.next()
            let myTitle = String(rs.stringForColumn("TITLE"))
            let myYear = String(rs.intForColumn("YEAR"))
            
            moodieFinal.append(["title": myTitle, "year": myYear])
            
            moodieRanking[maxIndex] = 0.0
            
        }
        
        for k in moodieFinal {
            print("\(k) \n")
        }

        
        database.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodieFinal.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        
        // Not adding new subviews if cell was created before
        for sbvw in cell.subviews {
            if (sbvw.tag == 99) {
                return cell
            }
        }
        
        print("====== \(indexPath.row) ========== \n")
        
        let movieTitle = moodieFinal[indexPath.row]["title"]
        //let movieYear = moodieFinal[indexPath.row]["year"]
        
        let title = UILabel(frame: CGRectMake(18, 0, 350, 100))
        title.text = movieTitle
        title.tag = 99
        title.textAlignment = NSTextAlignment.Center
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        title.numberOfLines = 0
        cell.addSubview(title)
        
        /*
        var ss : UILabel = UILabel(frame: CGRectMake(38, 298, 300, 200))
        ss.text = description
        ss.font = UIFont(name: ss.font.fontName, size: 13)
        ss.textAlignment = NSTextAlignment.Center
        ss.numberOfLines = 0
        cell.addSubview(ss)
        */
        
        /*
        var cellImg : UIImageView = UIImageView(frame: CGRectMake(95, 80, 180, 260))
        cellImg.image = UIImage(named: poster)
        cellImg.layer.cornerRadius = 8.0
        cell.imageView!.clipsToBounds = true
        cell.addSubview(cellImg) */
        

        return cell
    }
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) ->CGFloat {
        return tableView.frame.size.height;
    }*/

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
