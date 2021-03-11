//
//  ContentView.swift
//  Sample20-Rotation
//
//  Created by keiji yamaki on 2021/03/11.
//

import SwiftUI

struct ContentView: View {
    @State private var orientation = UIDeviceOrientation.unknown

     var body: some View {
         Group {
             if orientation.isPortrait {
                 Text("Portrait")
             } else if orientation.isLandscape {
                 Text("Landscape")
             } else if orientation.isFlat {
                 Text("Flat")
             } else {
                 Text("Unknown")
             }
         }
         .onRotate { newOrientation in
             orientation = newOrientation
         }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
