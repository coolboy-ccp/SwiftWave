//
//  WaveView.swift
//  SwiftWave
//
//  Created by Ceair on 17/3/15.
//  Copyright © 2017年 ceair-imac. All rights reserved.
//

import UIKit

class WaveView: UIView {

    var waveAmplitude : CGFloat = 3.0
    var wavePalstance : CGFloat = 0.12
    var waveOx : CGFloat = 0.0
    var waveOy : CGFloat = 0.0
    var waveSpeed : CGFloat = 0.0
    let backImgV = UIImageView()
    let beforeImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
        initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        self.layer.cornerRadius = self.bounds.width / 2.0
        self.layer.masksToBounds = true
        
        backImgV.frame = self.bounds
        backImgV.image = UIImage(named: "demo")?.withRenderingMode(.alwaysTemplate)
        backImgV.tintColor = UIColor.red
        self.addSubview(backImgV)
        let v = UIView(frame: backImgV.bounds)
        v.backgroundColor = UIColor.red
        
        beforeImgV.frame = self.bounds
        beforeImgV.image = UIImage(named: "demo")?.withRenderingMode(.alwaysTemplate)
        beforeImgV.tintColor = UIColor.white
        beforeImgV.backgroundColor = UIColor.red
        self.addSubview(beforeImgV)
    }
    
    private struct environment {
        //判断是真机还是模拟器
        static let isSimulator : Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
            isSim = true
            #endif
            return isSim
        }()
    }
    
    private func initData() {
        waveOy = self.bounds.height / 2.0
        if environment.isSimulator {
            waveSpeed = 0.3
        }
        else {
            waveSpeed = 0.15
        }
        let disPL = CADisplayLink(target: self, selector: #selector(updataWave))
        disPL.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    func updataWave() {
        waveOx -= waveSpeed
        topWave()
        bottomWave()
    }
    
    private func topWave() {
        let waveWidth = self.bounds.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: waveOy))
        var y = waveOy
        for i in 0 ... Int(waveWidth) {
            let x = CGFloat(i)
            y = waveAmplitude * sin(wavePalstance * x + waveOx + 1.0) + waveOy
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: waveWidth, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.closeSubpath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        beforeImgV.layer.mask = shapeLayer
    }
    
    private func bottomWave() {
        let waveWidth = self.bounds.width
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: waveOy))
        var y = waveOy
        for i in 0 ... Int(waveWidth) {
            let x = CGFloat(i)
            y = waveAmplitude * sin(wavePalstance * x + waveOx) + waveOy
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: waveWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        backImgV.layer.mask = shapeLayer
    }

}
