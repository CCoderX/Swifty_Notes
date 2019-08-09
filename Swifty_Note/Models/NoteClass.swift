//
//  noteClass.swift
//  Swifty_Note
//
//  Created by user on 8/2/19.
//  Copyright © 2019 user. All rights reserved.
//
import UIKit
import Realm
import  RealmSwift
import Foundation

class Note : Object
{
    @objc internal dynamic var noteImage : String? , noteDescription : String? , noteTitle : String?
    
}
