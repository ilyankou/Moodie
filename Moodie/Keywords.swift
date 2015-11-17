//
//  Keywords.swift
//  Moodie
//
//  Created by Ilya Ilyankou on 11/13/15.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class Keywords: NSObject {

    var entries = [
        ("20th century", 1, 0),
        ("independent film", 1, 0),
        ("love", 1, 0),
        ("non-fiction", 1, 0),
        ("friendship", 1, 0),
        ("revenge", 1, 0),
        ("fight", 1, 0),
        ("dancing", 1, 0),
        ("party", 1, 0),
        ("jealousy", 1, 0),
        ("new york city", 1, 0),
        ("kidnapping", 1, 0),
        ("marriage", 1, 0),
        ("kissing", 1, 0),
        ("beach", 1, 0),
        ("explosion", 1, 0),
        ("children", 1, 0),
        ("love", 1, 0),
        ("world war two", 1, 0),
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
        ("nightmare", 1, 0),
        ("fear", 1, 0),
        ("singing", 1, 0),
        ("gun", 1, 0),
        ("teenager", 1, 0),
        
    
    ]
    
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
