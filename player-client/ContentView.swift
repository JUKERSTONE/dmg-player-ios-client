import SwiftUI
import dmg_player_ios_sdk

struct ContentView: View {
    @StateObject private var playerSDK = DMGPlayerSDK()

    var body: some View {
        VStack {
            DMGPictureLicense(sdk: playerSDK)
            Group {
                Text("Now Playing:")
                Button("Play") {
                    let isrc = "GBARL2001236"
                    playerSDK.playNow(isrc: isrc)
                }
                Button("Queue") {
                    let isrc = "USANG2208486"
                    playerSDK.queue(isrc: isrc)
                }
                Button("Queue") {
                    let isrc = "USUM71714139"
                    playerSDK.queue(isrc: isrc)
                }
                Button("Queue") {
                    let isrc = "USWB10002407"
                    playerSDK.queue(isrc: isrc)
                }
                Button("Print Queue") {
                    playerSDK.printQueue()
                }
                Button("Resume") {
                    playerSDK.resume()
                }
                Button("Pause") {
                    playerSDK.pause()
                }
                Button("Next") {
                    playerSDK.next()
                }
                Button("Stop") {
                    playerSDK.stop()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
