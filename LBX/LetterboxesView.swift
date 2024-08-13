import SwiftUI
import SQLite3
import CoreLocation

// Data Model Struct
struct Letterbox: Identifiable, Codable {
    var id: String { boxName }
    let boxName: String
    let owner: String
    let foundBy: String
    let plantDate: String
    let lastFound: String
    let location: String
    let status: String
    let city: String
    let county: String
    let state: String
    let lastEdited: String
    let numBoxes: Int
    let notes: String
    let difficulty: String
    let distance: Double
}

// SwiftUI View Struct
struct LetterboxesView: View {
    @State private var letterboxes: [Letterbox] = []
    @State private var searchText = ""
    @State private var searchCategory = "Name"
    @State private var filteredLetterboxes: [Letterbox] = []
    @State private var isLoading = false
    @State private var useCurrentLocation = false

    @StateObject private var locationManager = AppLocationManager()

    var body: some View {
        NavigationStack {
            VStack {
                // Picker for search category
                Picker("Search By", selection: $searchCategory) {
                    Text("Name").tag("Name")
                    Text("Distance").tag("Distance")
                    Text("City").tag("City")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(8)

                VStack {
                    // TextField for search input
                    TextField("Search", text: $searchText, onCommit: {
                        filterLetterboxes()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)

                    // Toggle for using current location
                    Toggle(isOn: $useCurrentLocation) {
                        Text("Use Current Location")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }

                // List of filtered letterboxes
                List(filteredLetterboxes) { letterbox in
                    NavigationLink(destination: LetterboxDetailView(letterbox: letterbox)) {
                        VStack(alignment: .leading) {
                            Text(letterbox.boxName)
                                .font(.headline)
                                .foregroundColor(.black) // Text color for white background
                            Text("Distance: \(letterbox.distance, specifier: "%.2f") miles")
                                .foregroundColor(.gray) // Subtext color
                            Text("Difficulty: \(letterbox.difficulty)")
                                .foregroundColor(.gray) // Subtext color
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2) // Subtle shadow for depth
                    }
                    .listRowBackground(Color.white)
                }
                .listStyle(PlainListStyle())
                .background(Color.white)
            }
            .onAppear {
                print("Letterboxes view appeared!")
                print("Loading database...")
                copyDatabaseIfNeeded()
                loadLetterboxesFromDatabase() // Load initial data from SQLite database
                filterLetterboxes()
            }
            .onChange(of: useCurrentLocation) { _ in
                filterLetterboxes()
            }
            .navigationTitle("Letterboxes")
            .background(Color.white.edgesIgnoringSafeArea(.all)) // White background for the entire view
        }
    }

    // Function to load letterboxes from the SQLite database with a limit
    private func loadLetterboxesFromDatabase() {
        let fileManager = FileManager.default

        guard let documentsURL = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            print("Failed to retrieve documents directory.")
            return
        }

        let databasePath = documentsURL.appendingPathComponent("lbx.db").path
        print("Database path: \(databasePath)")

        if !FileManager.default.fileExists(atPath: databasePath) {
            print("Database file does NOT exist at path: \(databasePath)")
            return
        } else {
            print("Database file exists at path: \(databasePath)")
        }

        var db: OpaquePointer?

        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            print("Error opening database: \(String(cString: sqlite3_errmsg(db)!))")
            return
        }

        let queryString = "SELECT * FROM letterbox LIMIT 100"  // Adjust limit as needed
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryString, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement: \(String(cString: sqlite3_errmsg(db)!))")
            return
        }

        var loadedLetterboxes: [Letterbox] = []

        while sqlite3_step(statement) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(statement, 0))
            let boxName = String(cString: sqlite3_column_text(statement, 1))
            let owner = String(cString: sqlite3_column_text(statement, 2))
            let foundBy = String(cString: sqlite3_column_text(statement, 3))
            let plantDate = String(cString: sqlite3_column_text(statement, 4))
            let lastFound = String(cString: sqlite3_column_text(statement, 5))
            let location = String(cString: sqlite3_column_text(statement, 6))
            let status = String(cString: sqlite3_column_text(statement, 7))
            let city = String(cString: sqlite3_column_text(statement, 8))
            let county = String(cString: sqlite3_column_text(statement, 9))
            let state = String(cString: sqlite3_column_text(statement, 10))
            let lastEdited = String(cString: sqlite3_column_text(statement, 11))
            let numBoxes = Int(sqlite3_column_int(statement, 12))
            let notes = String(cString: sqlite3_column_text(statement, 13))

            let letterbox = Letterbox(
                boxName: boxName,
                owner: owner,
                foundBy: foundBy,
                plantDate: plantDate,
                lastFound: lastFound,
                location: location,
                status: status,
                city: city,
                county: county,
                state: state,
                lastEdited: lastEdited,
                numBoxes: numBoxes,
                notes: notes,
                difficulty: "", // Placeholder since difficulty isn't in your schema
                distance: 0.0  // Placeholder since distance isn't in your schema
            )

            loadedLetterboxes.append(letterbox)
        }

        sqlite3_finalize(statement)
        sqlite3_close(db)

        self.letterboxes = loadedLetterboxes
        self.filteredLetterboxes = self.letterboxes

        print("Loaded letterboxes: \(self.letterboxes.count)")
    }

    // Function to filter letterboxes based on search criteria
    private func filterLetterboxes() {
        if useCurrentLocation, let userLocation = locationManager.location {
            filteredLetterboxes = letterboxes.filter { letterbox in
                guard let coordinate = getCoordinate(from: letterbox.location) else { return false }
                let letterboxLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let distanceInMiles = userLocation.distance(from: letterboxLocation) / 1609.34 // Convert meters to miles
                return distanceInMiles <= 15.0 // Filter within 15 miles
            }
        } else if searchText.isEmpty {
            filteredLetterboxes = letterboxes
        } else {
            switch searchCategory {
            case "Name":
                filteredLetterboxes = letterboxes.filter { $0.boxName.localizedCaseInsensitiveContains(searchText) }
            case "Distance":
                if let searchDistance = Double(searchText) {
                    filteredLetterboxes = letterboxes.filter { $0.distance <= searchDistance }
                } else {
                    filteredLetterboxes = letterboxes
                }
            case "City":
                filteredLetterboxes = letterboxes.filter { $0.city.localizedCaseInsensitiveContains(searchText) }
            default:
                filteredLetterboxes = letterboxes
            }
        }

        print("Filtered letterboxes: \(filteredLetterboxes.count)")
    }

    private func getCoordinate(from location: String) -> CLLocationCoordinate2D? {
        let components = location.split(separator: ",")
        guard components.count == 2,
              let latitude = Double(components[0].trimmingCharacters(in: .whitespaces)),
              let longitude = Double(components[1].trimmingCharacters(in: .whitespaces)) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    private func copyDatabaseIfNeeded() {
        let fileManager = FileManager.default

        guard let documentsURL = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            print("Failed to retrieve documents directory.")
            return
        }

        let databaseURL = documentsURL.appendingPathComponent("lbx.db")

        if !fileManager.fileExists(atPath: databaseURL.path) {
            print("Database file does not exist, attempting to copy from bundle...")

            guard let bundleURL = Bundle.main.url(forResource: "lbx", withExtension: "db") else {
                print("Database file not found in bundle.")
                return
            }

            do {
                try fileManager.copyItem(at: bundleURL, to: databaseURL)
                print("Database copied to documents directory.")
            } catch {
                print("Error copying database: \(error)")
            }
        } else {
            print("Database file already exists at path: \(databaseURL.path)")
        }
    }
}

// Location manager to get user location
class AppLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var location: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

// Detail view for a selected letterbox
struct LetterboxDetailView: View {
    var letterbox: Letterbox

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text(letterbox.boxName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
                
                // Divider
                Divider()
                
                // Owner and Finder Information
                Group {
                    DetailRowView(label: "Owner", value: letterbox.owner)
                    DetailRowView(label: "Found By", value: letterbox.foundBy)
                }
                
                // Divider
                Divider()
                
                // Date Information
                Group {
                    DetailRowView(label: "Plant Date", value: letterbox.plantDate)
                    DetailRowView(label: "Last Found", value: letterbox.lastFound)
                    DetailRowView(label: "Last Edited", value: letterbox.lastEdited)
                }
                
                // Divider
                Divider()
                
                // Location Information
                Group {
                    DetailRowView(label: "Location", value: letterbox.location)
                    DetailRowView(label: "City", value: letterbox.city)
                    DetailRowView(label: "County", value: letterbox.county)
                    DetailRowView(label: "State", value: letterbox.state)
                }
                
                // Divider
                Divider()
                
                // Number of Boxes
                DetailRowView(label: "Number of Boxes", value: "\(letterbox.numBoxes)")
                
                // Divider
                Divider()
                
                // Notes Section
                Text("Notes")
                    .font(.headline)
                    .padding(.top, 8)
                Text(stripHTMLTagsAndFormat(from: letterbox.notes))
                    .padding()
                    .background(Color(white: 0.95))
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationTitle("Letterbox Details")
    }
    
    // Helper to standardize and strip HTML tags
    private func stripHTMLTagsAndFormat(from string: String) -> String {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [])
        let range = NSRange(location: 0, length: string.utf16.count)
        let htmlLessString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "")
        let standardizedString = htmlLessString.replacingOccurrences(of: "\\n", with: "\n")
        return standardizedString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// Reusable Detail Row View
struct DetailRowView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding(.vertical, 4)
    }
}

// Preview
struct LetterboxesView_Previews: PreviewProvider {
    static var previews: some View {
        LetterboxesView()
    }
}
