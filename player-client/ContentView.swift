import SwiftUI
import dmg_player_ios_sdk

struct SearchResult: Identifiable {
    let id = UUID() // Automatically generate a unique ID for each instance
    let image: String
    let title: String
    let artist: String
    let isrc: String
}

struct MusicData: Codable {
    let artist: String
    let title: String
    let thumbnail: String
    let isrc: String
    let apple_music: MusicService?
    let genius: MusicService?
    let soundcloud: MusicService?
    let spotify: MusicService?
    let youtube: MusicService?

    struct MusicService: Codable {
        let id: String?
        let url: String?
    }
}

struct ContentView: View {
    @StateObject private var playerSDK = DMGPlayerSDK()
    
    @State private var searchText: String = ""
    @State private var searchResults: [SearchResult] = []

    var body: some View {
        VStack {
            DMGPictureLicense(sdk: playerSDK).frame(height: 0)
            searchBar
            queryList
        }
    }
    
    var searchBar: some View {
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.trailing, 8)
                Button(action: {
                    performSearch(query: searchText)
                }) {
                    Text("Search")
                }
            }
            .padding()
        }
    
    var queryList: some View {
            List(searchResults) { result in
                Button(action: {
                    playerSDK.playNow(isrc: result.isrc)
                }) {
                    HStack {
                        AsyncImage(url: URL(string: result.image)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if phase.error != nil {
                                Color.red // Indicates an error
                                    .frame(width: 50, height: 50)
                            } else {
                                Color.gray // Indicates loading
                                    .frame(width: 50, height: 50)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(result.title)
                            Text(result.artist)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    
    func performSearch(query: String) {
        let apiService = APIService.shared
        let urlString = "https://europe-west1-trx-traklist.cloudfunctions.net/TRX_DEVELOPER/trx/music/search/\(query)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        print(url)
        
        apiService.fetchData(from: url) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        // Decode JSON data
                        let musicDataArray = try JSONDecoder().decode([MusicData].self, from: data)
                        
                        print(musicDataArray, "here are the search results")
                        
                        // Map to SearchResult
                        searchResults = musicDataArray.map { musicData in
                            SearchResult(
                                image: musicData.thumbnail,
                                title: musicData.title,
                                artist: musicData.artist,
                                isrc: musicData.isrc
                            )
                        }

                        // Use searchResults as needed
                        
                        print(musicDataArray, "here are the search results")
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }

                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
        
        
            // Perform the search using searchText
            // Update searchResults with the results
            // Example:
            
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
