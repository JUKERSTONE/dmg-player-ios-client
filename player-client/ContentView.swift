import SwiftUI
import dmg_player_ios_sdk

struct ContentView: View {
    // Assuming your TrackPlayerSDK is designed to be used as an ObservableObject
    @StateObject private var playerSDK = TrackPlayerSDK()

    var body: some View {
        VStack {
            
            Text("Now Playing:")
            Button("Play") {
                // Example ISRC to play. This should be replaced with actual ISRC values.
                let isrc = "GBARL2001236"
                playerSDK.playNow(isrc: isrc)
            }
            Button("Queue") {
                // Example ISRC to play. This should be replaced with actual ISRC values.
                let isrc = "USANG2208486"
                playerSDK.queue(isrc: isrc)
            }
            Button("Print Queue") {
                playerSDK.printQueue()
            }
            WebViewWrapper(sdk: playerSDK)
        }
        .onAppear {
            // Setup or initial calls can be made here
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
