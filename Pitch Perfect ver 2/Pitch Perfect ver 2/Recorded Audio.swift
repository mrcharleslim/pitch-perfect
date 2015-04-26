//
//  Recorded Audio.swift
//  Pitch Perfect ver 2
//
//  Created by Charles Lim on 4/23/15.
//  Copyright (c) 2015 Edupolis. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePath: NSURL, titlePath:String) {
     filePathUrl = filePath
     title = titlePath
    }
    
}