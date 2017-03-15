//
//  ViewController.swift
//  SwiftWave
//
//  Created by Ceair on 17/3/15.
//  Copyright © 2017年 ceair-imac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let wave = WaveView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        wave.center = view.center
        view.addSubview(wave)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

