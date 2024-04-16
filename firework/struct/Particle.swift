//
//  Particle.swift
//  firework
//
//  Created by Dason Tiovino on 16/04/24.
//

import Foundation
import SwiftUI

struct Particle{
    
    var pos: CGPoint
    var acc: Dictionary<String, Double> = random2D()
    var size: CGFloat = 10.5
    var opacity = 1.0
    
    var pallete: [Color]
    var color: Color = .white
    
    init(pos: CGPoint, pallete: [Color]) {
        self.pos = pos
        self.pallete = pallete
        self.color = pallete.randomElement()!

    }
    
    func draw(context: GraphicsContext){
        let rect = CGRect(x: pos.x, y: pos.y, width: size, height: size)
        context.fill(Circle().path(in: rect), with: .color(color.opacity(opacity)))
    }
    
    mutating func update(){
        // Opacity
        opacity -= 0.0175
        
        // Move
        acc["y"]! += gravity / 10
        pos.x += acc["x"]!
        pos.y += acc["y"]!
    }
}
