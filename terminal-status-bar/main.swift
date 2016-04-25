import Foundation

guard let battery = batteries().first else {
    print("Failed to identify power sources")
    exit(-1)
}

print(battery)