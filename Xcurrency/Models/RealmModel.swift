//
//  RealmModel.swift
//  Xcurrency
//
//  Created by MacBook AIR on 17/07/2023.
//

import Foundation
import Realm
import RealmSwift

class person:Object {
    
    @objc dynamic var Rate: String = ""
    @objc dynamic var baseCurrency: String  = ""
    @objc dynamic var ConvertCurency:String  = ""
    @objc dynamic var date:String = ""
    
    
}
