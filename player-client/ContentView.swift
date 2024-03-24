import SwiftUI
import dmg_player_ios_sdk

struct ContentView: View {
    @StateObject private var playerSDK = DMGPlayerSDK()

    var body: some View {
        VStack {
            DMGPictureLicense(sdk: playerSDK)
            nowPlayingGroup
            controlButtons
        }
    }
    
    var nowPlayingGroup: some View {
        Group {
            Text("Now Playing:")
        }
    }
    
    var controlButtons: some View {
        Group {
            playButton
            queueButton1
            queueButton2
            queueButton3
            printQueueButton
//            resumeButton
//            pauseButton
            nextButton
            stopButton
        }
    }
    
    var playButton: some View {
        Button("Play") {
            let isrc = "FRX202363539"
            playerSDK.playNow(isrc: isrc)
        }
    }
    
    var queueButton1: some View {
        Button("Queue") {
            let isrc = "USQX91402597"
            playerSDK.queue(isrc: isrc)
        }
    }
    
    var queueButton2: some View {
        Button("Queue") {
            let isrc = "USUM70846400"
            playerSDK.queue(isrc: isrc)
        }
    }
    
    var queueButton3: some View {
        Button("Queue") {
            let isrc = "USUYG1001593"
            playerSDK.queue(isrc: isrc)
        }
    }
    
    var printQueueButton: some View {
        Button("Print Queue") {
            playerSDK.printQueue()
        }
    }
    
//    var resumeButton: some View {
//        Button("Resume") {
//            playerSDK.resume()
//        }
//    }
//
//    var pauseButton: some View {
//        Button("Pause") {
//            playerSDK.pause()
//        }
//    }
    
    var nextButton: some View {
        Button("Next") {
            playerSDK.next()
        }
    }
    
    var stopButton: some View {
        Button("Stop") {
            playerSDK.stop()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
