//
//  Firework.swift
//  firework
//
//  Created by Dason Tiovino on 16/04/24.
//

import Foundation
import SwiftUI

struct Firework{
    var pos: CGPoint

    let size: CGFloat = 10.0
    var acc: [String: Double] = [
//        "x": CGFloat.random(in: -2.5...2.5),
        "x": 0,
        "y": CGFloat.random(in: -25.0...(-15.0))
    ]

    var explode: Bool = false
    var particles: [Particle] = []
    var trace: [CGPoint] = []
    var pallete: [Color] = randomColor.randomElement()!
    
    func draw(context: GraphicsContext){
        if(!explode){
            let rect = CGRect(x: pos.x, y: pos.y, width: size, height: size)
            context.fill(Circle().path(in: rect), with: .color(.white))
        
            
            for (i,bit) in trace.enumerated(){
                let rect = CGRect(x: bit.x, y: bit.y, width: size, height: size)
                context.fill(Circle().path(in: rect), with: .color(.white.opacity(Double((1 - i/50)) / 10)))
            }
        }
        
        
        for particle in particles {
            particle.draw(context: context)
        }
    }
    
    
    mutating func isExploded(){
        for _ in 0...100{
            particles.append(Particle(
                pos: pos,
                pallete: pallete)
            )
        }
    }
    
    mutating func update(){
        if(explode) {return}
        
        // Moving Firework
        acc["y"]! += gravity
        pos.y += acc["y"]!
        pos.x += acc["x"]!
        
        trace.append(pos)
        
        // Check Explode
        if (acc["y"]! > 1.5 && !explode){
            explode = true
            isExploded()
        }
    }
}
