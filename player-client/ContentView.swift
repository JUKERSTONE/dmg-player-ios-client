import SwiftUI
import dmg_player_ios_sdk

struct ContentView: View {
    let sdk = TrackPlayerSDK()
    @State private var showWebView = false
    
    var body: some View {
        VStack {
            Button("Play Video") {
                sdk.playNow(isrc: "CA5KR2269973")
                showWebView = true
            }
            
            if showWebView {
                WebView(sdk: sdk)
                    .frame(height: 300) // Set the frame height for the web view
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
