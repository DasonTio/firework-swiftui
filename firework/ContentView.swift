//
//  ContentView.swift
//  firework
//
//  Created by Dason Tiovino on 16/04/24.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

func random2D()->[String:Double]{
    let angle = CGFloat.random(in: 0.000...1) * Double.pi * 2
    return [
        "x": (Double(cos(angle) * 1 * CGFloat.random(in: 2...5) )),
        "y": (Double(sin(angle) * 1 * CGFloat.random(in: 2...5) ))
    ]
}

let gravity: Double = 0.45

let randomColor: Array<Array<Color>> = [
    [Color(hex: 0xDAC0A3), Color(hex: 0xEADBC8), Color(hex: 0xFEFAF6)],
    [Color(hex: 0xda1610), Color(hex: 0xea7630), Color(hex: 0xfad650)],
    [Color(hex: 0x5e9fff), Color(hex: 0xe82560), Color(hex: 0xfae9ff)],
]

struct ContentView: View {
    
    @State var fireworks:[Firework] = []
    
    var body: some View {
        GeometryReader{ geometry in
            Canvas { context, size in
                context.fill(Path(CGRect(
                    x: 0,
                    y: 0,
                    width: size.width,
                    height: size.height)
                ), with: .color(.black))
                
                for firework in fireworks {
                    firework.draw(context: context)
                }
            }.ignoresSafeArea()
            .onAppear(){
                startAnimation(geometry)
            }
            .onDisappear(){
                endAnimation()
            }
        }
       
    }
    
    func startAnimation(_ geometry:GeometryProxy){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            let x = CGFloat.random(in: geometry.size.width / 8...geometry.size.width - geometry.size.width / 8)
            fireworks.append(Firework(pos: CGPoint(x: x, y: geometry.size.height)))
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: true){ _ in
            let x = CGFloat.random(in: geometry.size.width / 8...geometry.size.width - geometry.size.width / 8)
            fireworks.append(Firework(pos: CGPoint(x: x, y: geometry.size.height)))
        }
    
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            
            for fIndex in fireworks.indices {
                fireworks[fIndex].update()
                if fireworks[fIndex].explode {
                    for pIndex in fireworks[fIndex].particles.indices{
                        fireworks[fIndex].particles[pIndex].update()
                    }
                }
            }
            
            if !fireworks.isEmpty 
                && ((fireworks.first?.particles.first?.opacity) != nil)
                && (fireworks.first?.particles.first!.opacity)! <= 0 {
               fireworks.removeFirst()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func endAnimation(){
        
    }
    
}

#Preview {
    ContentView()
}
