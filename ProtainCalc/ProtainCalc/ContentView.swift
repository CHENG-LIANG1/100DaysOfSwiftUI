//
//  ContentView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/11/12.
//

import SwiftUI

struct ContentView: View {
    
    @State private var protain = ""
    @State private var fat = ""
    @State private var water = ""
    @State private var resultFat: Float = 0
    @State private var resultProtain: Float = 0
    @State private var showingMissingAlert = false
    
    var horizontalPadding: CGFloat = 36
    var verticalPadding: CGFloat = 24
    
    var screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 50) {
                

                
                HStack(){
                    
                    VStack(spacing: 10){
                        Text("蛋白质含量")
                        Text(String(format: "%.2f", resultProtain * 100) + "%")
                    }
                    .font(.headline)
                    .frame(width: (screenWidth - horizontalPadding * 3) / 2, height: 120)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Spacer()
                    
                    VStack(spacing: 10){
                        Text("脂肪含量")
                        Text(String(format: "%.2f", resultFat * 100) + "%")
                    }
                    .font(.headline)
                    .frame(width: (screenWidth - horizontalPadding * 3) / 2, height: 120)
                    .background(.indigo)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    


                }
                .padding(.top, 80)
                

        
                VStack(spacing: verticalPadding){
                    TextField("", text: $water)
                        .keyboardType(.numberPad)

                        .modifier(PlaceholderStyle(showPlaceHolder: water.isEmpty,
                                                   placeholder: "输入水分(%)", forgroundColor: Color.white))
                        .modifier(
                            
                            gradientTextFieldModifier(radius: 15, startColor: Color.TextColorPrimary, endColor: Color.TextColorPrimary , textColor: Color.BackgroundColor, textSize: 18)

                        )


                    
                    
                    TextField("", text: $protain)
                        .keyboardType(.numberPad)

                        .modifier(PlaceholderStyle(showPlaceHolder: protain.isEmpty,
                                                   placeholder: "输入蛋白质(%)", forgroundColor: Color.white))
                        .modifier(
                            
                            gradientTextFieldModifier(radius: 15, startColor: Color.TextColorPrimary, endColor: Color.TextColorPrimary , textColor: Color.BackgroundColor, textSize: 18)

                        )

                    
                    TextField("", text: $fat)
                        .keyboardType(.numberPad)
            
                        

                        .modifier(PlaceholderStyle(showPlaceHolder: fat.isEmpty,
                                                   placeholder: "输入脂肪(%)", forgroundColor: Color.white))
                        .modifier(
                            
                            gradientTextFieldModifier(radius: 15, startColor: Color.TextColorPrimary, endColor: Color.TextColorPrimary , textColor: Color.BackgroundColor, textSize: 18)

                        )

                    

                }
                
                Button{
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)

                    
                    if (water == "" || protain == "" || fat == ""){
                        showingMissingAlert = true
                    }else {
                        var dry: Float = 100 - (Float(water) ?? 0.0)
                        
                        resultFat = Float(fat)! / dry
                        
                        resultProtain = Float(protain)! / dry
                    }
                } label: {
                    Text("计算")
                        .frame(width: screenWidth - horizontalPadding * 2, height: 60)
                        .font(.headline)
                        .foregroundColor(.black)
                        .background(.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                }

                Spacer()
                

            }
            .alert("请输入必填项", isPresented: $showingMissingAlert, actions: {
                Button("OK", role:.cancel){}
            })
            
            .padding(EdgeInsets(top: 0, leading: horizontalPadding, bottom: 0, trailing: horizontalPadding))
            .navigationBarTitle("🐱猫猫计算器", displayMode: .inline)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
