//
//  ColorWheel.swift
//  ColorPicker
//
//  Created by David Doswell on 1/8/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

class ColorWheel: UIControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
    }
    
    override func draw(_ rect: CGRect) {
        // loop through every y pixel
        for y in 0...Int(bounds.maxY) {
            // loop through every x pixel
            for x in 0...Int(bounds.maxX) {
                // get every pixel location
                let pixelLocation = CGPoint(x: x, y: y)
                let color = self.colorFor(location: pixelLocation)
                let pixel = CGRect(x: x, y: y, width: 1, height: 1)
                
                // fill every pixel with the color at x-y location
                color.set()
                UIRectFill(pixel)
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        color = self.colorFor(location: touchPoint)
        sendActions(for: [.touchDown, .valueChanged])
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            color = self.colorFor(location: touchPoint)
            sendActions(for: [.valueChanged, .touchDragInside])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event) }
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            color = self.colorFor(location: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
    }
    
    private func colorFor(location: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let yDistanceFromCenter = location.y - center.y
        let xDistanceFromCenter = location.x - center.x
        let offset = CGSize(width: xDistanceFromCenter / center.x, height: yDistanceFromCenter / center.y)
        let (hue, saturation) = Color.getHueSaturation(at: offset)
        return UIColor(hue: hue, saturation: saturation, brightness: 0.8, alpha: 1.0)
    }
    
    var color: UIColor = .white
    
}
