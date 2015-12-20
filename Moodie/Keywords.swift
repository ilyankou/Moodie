//
//  Keywords.swift
//  Class that represents the keyword entries for Views 2 and 3 of ViewController.swift
//  Moodie
//
//  Created by Anastasija Mensikova and Ilya Ilyankou on 11/13/15.
//  Copyright © 2015 Anastasija Mensikova and Ilya Ilyankou. All rights reserved.
//

import UIKit

class Keywords: NSObject {

    /**
        All the Keyword entries (keyword, importance, status)
     */
    var entries = [
        ("long", 3, 0),
        ("short", 3, 0),
        ("average length", 3, 0),
        ("foreign", 3, 0),
        ("silent", 1, 0),
        ("black and white", 3, 0),
        ("cartoon", 3, 0),
        ("1900-1960s", 2, 0),
        ("1970-2000s", 2, 0),
        ("2000-2010s", 2, 0),
        ("2015", 4, 0),
        
        ("friendship", 2, 0),
        ("independent film", 3, 0),
        ("love", 1, 0),
        ("non-fiction", 3, 0),
        ("police", 1, 0),
        ("travel", 1, 0),
        ("revenge", 1, 0),
        ("murder", 1, 0),
        ("fight", 1, 0),
        ("dancing", 2, 0),
        ("party", 2, 0),
        ("satire", 1, 0),
        ("jealousy", 1, 0),
        ("new york city", 3, 0),
        ("kidnapping", 1, 0),
        ("marriage", 1, 0),
        ("kissing", 1, 0),
        ("beach", 1, 0),
        ("explosion", 1, 0),
        ("children", 1, 0),
        ("world war two", 4, 0),
        ("chase", 1, 0),
        ("christmas", 1, 0),
        ("religion", 1, 0),
        ("wedding", 1, 0),
        ("investigation", 1, 0),
        ("torture", 1, 0),
        ("dream", 1, 0),
        ("school", 1, 0),
        ("monster", 1, 0),
        ("food", 1, 0),
        ("student", 1, 0),
        ("nightmare", 2, 0),
        ("fear", 1, 0),
        ("singing", 1, 0),
        ("gun", 1, 0),
        ("teenager", 1, 0),
        ("surrealism", 1, 0),
        ("doctor", 1, 0),
        ("fire", 1, 0),
        ("puzzle", 1, 0),
        ("bar", 1, 0),
        ("hotel", 1, 0),
        ("restaurant", 1, 0),
        ("money", 1, 0),
        ("lawyer", 1, 0),
        ("low-budget film", 10, 0),
        ("airplane", 1, 0),
        ("cemetery", 1, 0),
        ("snow", 1, 0),
        ("island", 1, 0),
        ("zombie", 1, 0),
        ("art", 1, 0),
        ("telephone", 1, 0),
        ("california", 1, 0),
        ("vampire", 1, 0),
        ("farm", 1, 0),
        ("village", 1, 0),
        ("birthday", 1, 0),
        ("college", 1, 0),
        ("guitar", 1, 0),
        ("jewish", 1, 0),
        ("mother", 1, 0),
        ("father", 1, 0),
        ("fall", 1, 0),
        ("summer", 1, 0),
        ("winter", 1, 0),
        ("spring", 1, 0),
        ("vacation", 1, 0),
        ("obsession", 1, 0),
        ("truck", 1, 0),
        ("duel", 1, 0),
        ("alcohol", 1, 0),
        ("avant-garde", 1, 0),
        ("army", 1, 0),
        ("bedroom", 1, 0),
        ("psychopath", 1, 0),
        ("cowboy", 1, 0),
        ("halloween", 1, 0),
        ("science", 1, 0),
        ("time travel", 1, 0),
        ("supernatural", 1, 0),
        ("texas", 1, 0),
        ("cooking", 1, 0),
        ("canada", 1, 0),
        ("band", 1, 0),
        ("tragedy", 1, 0),
        ("mexico", 1, 0),

    ]
    
    
    /**
        Changes the status of the keyword
     
        - Parameter tag: the tag (index) of the keyword
        - Returns: 0 if status was 1; 1 if status was 0
     */
    func changeStatus(tag: Int) -> Int {
        if (self.entries[tag].2 == 0) {
            self.entries[tag].2 = 1
            return 1

        }
        else {
            self.entries[tag].2 = 0
            return 0
        }
    }
    
}
