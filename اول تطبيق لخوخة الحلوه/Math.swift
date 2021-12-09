//
//  Math.swift
//  اول تطبيق لخوخة الحلوه
//
//  Created by khuloud alshammari on 28/04/1443 AH.
//

import Foundation
import UIKit
class Math{
    class DivBy0Error : Error{
        
    }
    func divid(num:Int, num2: Int)throws ->Int{
        if num2 == 0{
          let error = DivBy0Error()
            throw error
        }
    return num/num2

        }
        

}
