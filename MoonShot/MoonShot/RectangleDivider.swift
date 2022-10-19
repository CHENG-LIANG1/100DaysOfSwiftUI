//
//  RectangleDivider.swift
//  MoonShot
//
//  Created by Cheng Liang(Louis) on 2022/9/8.
//

import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(height:6)
            .foregroundColor(.lightBackground)
            .padding()
    }
}

struct RectangleDivider_Previews: PreviewProvider {
    static var previews: some View {
        RectangleDivider()
    }
}
