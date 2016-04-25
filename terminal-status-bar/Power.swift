import Foundation

import IOKit
import IOKit.ps

func batteries() -> [[NSObject : AnyObject]] {
    guard let sources = IOPSCopyPowerSourcesInfo(),
        let batteries = IOPSCopyPowerSourcesList(sources.takeRetainedValue()),
        let batteriesArray = batteries.takeRetainedValue() as Array?,
        let castArray = batteriesArray as? Array<[NSObject : AnyObject]>  else {
        return []
    }

    return castArray
}
