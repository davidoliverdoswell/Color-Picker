//
//  Color.swift
//  ColorPicker
//
//  Created by David Doswell on 1/8/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

struct Color {
    
    static func getHueSaturation(at offset: CGSize) -> (hue: CGFloat, saturation: CGFloat) {
        let saturation = sqrt(offset.width * offset.width + offset.height * offset.height)
        var hue = acos(offset.width / saturation) / (2.0 * CGFloat.pi)
        
        if offset.height < 0 { hue = 1.0 - hue }
        return (hue: hue, saturation: saturation)
    }
}
