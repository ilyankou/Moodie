//
//  MoviesPickedTVC.swift
//  Moodie
//
//  Created by Anastasia Menshikova on 19/11/2015.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class MoviesPickedTVC: UITableViewController {
    
    //@IBOutlet weak var filmTitle: UILabel!
    
    //@IBOutlet weak var filmTitle: UILabel!
    
    //@IBOutlet weak var filmDescription: UILabel!
    
    
    //@IBOutlet var titleLabel: UILabel!
    //@IBOutlet var subtitleLabel: UILabel!
    
    //var movieCell = MovieCell()
    
    let testTable = [("Harry Potter and the Philosopher's Stone", "Rescued from the outrageous neglect of his aunt and uncle, a young boy with a great destiny proves his worth while attending Hogwarts School of Witchcraft and Wizardry.", "Philostone.jpg"), ("Harry Potter and the Chamber of Secrets", "Harry ignores warnings not to return to Hogwarts, only to find the school plagued by a series of mysterious attacks and a strange voice haunting him.", "Philostone.jpg"), ("Harry Potter and the Prizoner of Azkaban", "It's Harry's third year at Hogwarts; not only does he have a new Defense Against the Dark Arts teacher, but there is also trouble brewing. Convicted murderer Sirius Black has escaped the Wizards' Prison and is coming after Harry.", "Philostone.jpg")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 180
        
        
        
        //tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testTable.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = movieCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        
        let (title, description, poster) = testTable[indexPath.row]
        
        
        
        
        var imageView = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
        let image = UIImage(named: "maxresdefault.jpg")
        imageView.image = image
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
        /*if cell.textLabel?.tag == 1 {
            cell.textLabel?.text = title
        }
        else {
            cell.textLabel?.text = description
        }*/
        //filmTitle.text = title
        //filmDescription.text = description
        //cell.textLabel?.text = title
        //cell.textLabel?.text = description
        
        //retrieve an image
        
        /*cell.textLabel?.text = title
        cell.detailTextLabel?.text = description*/
        
        //cell.titleLabel.text = title
        //cell.subtitleLabel.text = description
        
        //cell.setTitle(title)
        //cell.setSubtitle(description)
        
        /*var myImage = UIImage(named: poster)
        cell.imageView?.image = myImage*/
        
        var tt : UILabel = UILabel(frame: CGRectMake(18, 0, 350, 100))
        tt.text = title
        tt.textAlignment = NSTextAlignment.Center
        tt.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        tt.numberOfLines = 0
        cell.addSubview(tt)
        
        var ss : UILabel = UILabel(frame: CGRectMake(38, 298, 300, 200))
        ss.text = description
        ss.font = UIFont(name: ss.font.fontName, size: 13)
        ss.textAlignment = NSTextAlignment.Center
        ss.numberOfLines = 0
        cell.addSubview(ss)
        
        var cellImg : UIImageView = UIImageView(frame: CGRectMake(95, 80, 180, 260))
        cellImg.image = UIImage(named: poster)
        cellImg.layer.cornerRadius = 8.0
        cell.imageView!.clipsToBounds = true
        cell.addSubview(cellImg)
        
        /*var frame = cell.imageView!.frame
        let imageSize = 20 as CGFloat
        cell.imageView!.frame = frame
        cell.imageView!.layer.cornerRadius = imageSize / 2.0
        cell.imageView!.clipsToBounds = true*/
        
        
        
        
        
        
        /*var cellImg : UIImageView = UIImageView(frame: CGRectMake(5, 5, 50, 50))
        cellImg.image = UIImage(named: poster)
        cell.addSubview(cellImg)*/
        
        //var itemSize:CGSize = CGSizeMake(20, 20)
        //UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.mainScreen().scale)
        //var imageRect : CGRect = CGRectMake(0, 0, itemSize.width, itemSize.height)
        /*var frame = cell.imageView!.frame
        let imageSize = 20 as CGFloat
        frame.size.height = imageSize
        frame.size.width  = imageSize
        cell.imageView!.frame = frame
        cell.imageView!.layer.cornerRadius = imageSize / 2.0
        cell.imageView!.clipsToBounds = true*/
        //cell.imageView?.frame = CGRectMake(5,5,32,32);

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
