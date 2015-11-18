//
//  Properties.swift
//  Moodie
//
//  Created by Anastasia Menshikova on 16/11/2015.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class Properties: NSObject {
    
    var entries = [
        ("long", 1, 0, 3),
        ("short", 1, 0, 3),
        ("average length", 1, 0, 3),
        ("foreign", 1, 0, 3),
        ("silent", 1, 0, 1),
        ("black and white", 1, 0, 1),
        ("before 1900", 1, 0, 2),
        ("1900-1960s", 1, 0, 2),
        ("1970-2000s", 1, 0, 2),
        ("2000-2010s", 1, 0, 2),
        ("2015", 1, 0, 3)
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
    
    func propertyValue(word: String, index: Int) -> Int {
        var value = 0
        //for var i = 0; i < words.count; i++ {
            let importance = self.entries[index].3
            
            switch(importance) {
                case 3:
                    value += 100
                case 2:
                    value += 70
                case 1:
                    value += 40
                default:
                    value += 0
            }
        //}
        return value
    }
}
