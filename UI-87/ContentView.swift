//
//  ContentView.swift
//  UI-87
//
//  Created by にゃんにゃん丸 on 2020/12/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var bill : CGFloat =  750
    
    @State var payers = [
        
        Payer(image: "p1", name: "ベロマン", bgcolor: Color("p1c")),
        Payer(image: "p2", name: "サンタマン", bgcolor: Color("p2c")),
        Payer(image: "p3", name: "のっぺ", bgcolor: Color("p3c")),
        
        
        
    ]
    
    
    
    @State var pay = false
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack{
                
                HStack{
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color("card"))
                            .padding()
                            .background(Color.black.opacity(0.25))
                            .cornerRadius(10)
                    })
                    
                    Spacer()
                }
                .padding()
                
                VStack(spacing:15){
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Recip")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,20)
                            .background(Color("bg"))
                            .cornerRadius(10)
                    })
                    
                    LinShape()
                        .stroke(Color.black,style: StrokeStyle(lineWidth: 1, lineCap: .butt, lineJoin: .miter,dash: [10]))
                        .frame(height: 1)
                        .padding(.horizontal)
                        .padding(.top,10)
                    
                    
                    HStack{
                        VStack(alignment:.leading){
                            
                            Text("Title")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            Text("Team Emoji")
                                .font(.title2)
                                .fontWeight(.heavy)
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        
                        VStack(alignment:.leading){
                            
                            Text("Total Bill")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            Text("$\(Int(bill))")
                                .font(.title2)
                                .fontWeight(.heavy)
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding(.top,10)
                        
                    }
                    
                    VStack{
                        
                        
                        HStack(spacing: -20){
                            
                            
                            ForEach(payers){payer in
                                
                                Image(payer.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .background(payer.bgcolor)
                                    .clipShape(Circle())
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                        }
                        Text("Spliting With")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("bg"))
                    .cornerRadius(25)
                    
                    
                    
                    
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("card").clipShape(BillShape()).cornerRadius(15))
                
                .padding(.horizontal)
                
                
                ForEach(payers.indices){index in
                    
                    PriceView(payer: $payers[index], totalAmount: bill)
                    
                }
                
                
                
                Spacer(minLength: 40)
                
                HStack{
                    HStack{
                        
                        ForEach(1...6,id:\.self){index in
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Color.white.opacity(Double(index) * 0.06))
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    .padding(.leading,50)
                    
                    Spacer()
                    
                    
                    Button(action: {pay.toggle()}, label: {
                        Text("Sprit")
                            .fontWeight(.bold)
                            .foregroundColor(Color("card"))
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            .background(Color("bg"))
                            .clipShape(Capsule())
                    })
                    
                    
                    
                }
                .padding()
                .background(Color.black.opacity(0.25))
                .clipShape(Capsule())
                .padding(.horizontal)
                
                
                
                
            }
        })
        
        
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
        .alert(isPresented: $pay, content: {
            
            Alert(title: Text("Alert"), message: Text("Sprit"), primaryButton: .default(Text("pay"), action: {
                
            }), secondaryButton: .destructive(Text("Cancel"), action: {
                
            }))
            
        })
    }
    
}

struct PriceView : View {
    
    @Binding var payer : Payer
    
    var totalAmount : CGFloat
    var body: some View{
        
        VStack(spacing:15){
            
            
            HStack{
                
                
                Image(payer.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .padding(5)
                    .background(payer.bgcolor)
                    .clipShape(Circle())
                
                Text(payer.name)
                    .font(.title2)
                    .foregroundColor(payer.bgcolor)
                
                Spacer()
                
                Text(getprice())
                    .fontWeight(.bold)
                    .foregroundColor(payer.bgcolor)
                
                
            }
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                
                
                Capsule()
                    .fill(Color.black.opacity(0.25))
                    .frame(height: 30)
                
                Capsule()
                    .fill(payer.bgcolor)
                    .frame(width : payer.offset + 20, height: 30)
                
                
                HStack(spacing:(UIScreen.main.bounds.width - 100) / 12){
                    
                    ForEach(0..<12){index in
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: index % 4 == 0 ? 7 : 4, height:index % 4 == 0 ? 7 : 4)
                        
                        
                    }
                    
                    
                }
                .padding(.leading)
                
                
                
                
                
                Circle()
                    .fill(Color("card"))
                    .frame(width: 35, height: 35)
                    .background(Circle().stroke(Color.white,lineWidth: 5))
                    .offset(x: payer.offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        
                        if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.width - 50{
                            
                            
                            payer.offset = value.location.x - 20
                        }
                        
                    }))
                
                
                
                
                
            })
            
            .padding(.top,33)
            
            
            
            
        }
        .padding()
        
    }
    
    func getprice() -> String{
        
        let parcent = payer.offset / (UIScreen.main.bounds.width - 70)
        let amount = parcent * (totalAmount / 3)
        
        return String(format: "%.0f",amount)
    }
}


struct LinShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path {path in
            
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

struct BillShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            path.move(to: CGPoint(x: 0, y: 80))
            path.addArc(center: CGPoint(x: 0, y: 80), radius: 20, startAngle: .init(degrees: -90), endAngle: .init(degrees: 90), clockwise: false)
            
            path.move(to: CGPoint(x: rect.width, y: 80))
            path.addArc(center: CGPoint(x: rect.width, y: 80), radius: 20, startAngle: .init(degrees: 90), endAngle: .init(degrees: -90), clockwise: false)
            
        }
    }
}

struct Payer : Identifiable {
    var id = UUID().uuidString
    var image : String
    var name : String
    var bgcolor : Color
    var offset : CGFloat = 0
}





