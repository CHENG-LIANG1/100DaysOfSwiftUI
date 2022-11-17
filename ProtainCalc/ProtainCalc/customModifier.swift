//
//  customTextField.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/17.
//

import Foundation
import SwiftUI

struct gradientTextFieldModifier: ViewModifier {
    var radius: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    var textSize: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(radius)
            .foregroundColor(textColor)
            .font(.system(size: textSize, weight: .semibold, design: .rounded))
            .shadow(radius: 10)
            .accentColor(textColor)
    }
}

struct singleColoredTextFieldModifier: ViewModifier {
    var radius: CGFloat
    var bgColor: Color
    var textColor: Color
    var textSize: CGFloat

    func body(content: Content) -> some View {
        content
            .padding()
            .background(bgColor)
            .cornerRadius(radius)
            .foregroundColor(textColor)
            .font(.system(size: textSize, weight: .semibold, design: .rounded))
            .shadow(radius: 10)
            .accentColor(textColor)
    }
}


public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    var forgroundColor: Color

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color.gray)
                .padding(.horizontal, 10)
            }
            content
            .foregroundColor(forgroundColor)
            .padding(5.0)
        }
    }
}
