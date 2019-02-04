//
//  ViewController.swift
//  ColorPicker
//
//  Created by David Doswell on 1/8/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func colorChanged(_ sender: ColorWheel) {
        view.backgroundColor = sender.color
    }
    
}

