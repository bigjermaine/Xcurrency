//
//  Extension.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import Foundation
import UIKit

//Image
extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        if let resizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            return resizedImage
        }
        return self
    }
}


//Color Constant

let skyDarkBlueColor = UIColor(red: 0/255, green: 102/255, blue: 204/255, alpha: 1.0)





//Date formatetter to only time
extension Date {
    func formattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
}




//Views extension
extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
        
    }
    public var height: CGFloat {
        return frame.size.height
        
    }
    public var top: CGFloat {
        return frame.origin.y
        
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
        
    }
    
    
    public var left: CGFloat {
        return frame.origin.x
        
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
        
    }
    
}
