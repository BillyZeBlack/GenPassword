//
//  Meter.swift
//  GenPassword
//
//  Created by williams saadi on 20/09/2022.
//

import SwiftUI

struct MeterView: View {
    let colors = [Color("Color"), Color("Color1")]
    @Binding var progress: CGFloat
    @State var size = UIScreen.main.bounds.width
    
    var body: some View{
        VStack {
            ZStack{
                ZStack{
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.black.opacity(0.1), lineWidth: 55)
                        .frame(width: size/1.5, height: size/1.5)
                    Circle()
                        .trim(from: 0, to: self.setProgress())
                        .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: 180)), lineWidth: 55)
                        .frame(width: size/1.5, height: size/1.5)
                }
                .rotationEffect(.init(degrees: 180))
                .animation(Animation.linear(duration: 1.5))
                
                ZStack(alignment: .bottom){
                    self.colors[0]
                        .frame(width: 2, height: 80)
                    Circle()
                        .fill(self.colors[0])
                        .frame(width: 15, height: 15)
                }
                .offset(y: -35)
                .rotationEffect(.init(degrees: -90))
                .rotationEffect(.init(degrees: self.setArrow()))
                .animation(Animation.linear(duration: 1.5))
            }
            .padding(.bottom, -140)
        }.padding(.bottom)
    }
    
    func setProgress()->CGFloat
    {
        if self.progress != 0 {
            let temp = self.progress / 2
            
            return Double(temp * 0.01)
        }
        return 0
    }
    
    func setArrow()->Double
    {
        if 0 != self.progress {
            let temp = self.progress / 100
            return Double(temp * 180)
        }
        return 0
    }
}

struct Meter_Previews: PreviewProvider {
    static var previews: some View {
        MeterView(progress: .constant(20))
    }
}
