import Foundation
import IOKit
import IOKit.ps

enum IconStatus {
  case Ok
  case Warn
  case Error
}

struct IconOutput {
  let okIcon: String
  let warnIcon: String
  let errorIcon: String

  var status: IconStatus
  var prefix: String?
}

typealias IconFunction = () -> IconOutput

struct Options {
  var name: String
  var icons: [IconFunction]
  var quiet: Bool
}

func main() {
  let options = parseArguments(Process.arguments)

  var stdout: [String] = []

  for icon in options.icons {
    let output = icon()
    switch output.status {
    case .Error:
      if let prefix = output.prefix { stdout.append(prefix) }
      stdout.append(output.errorIcon)
    case .Warn:
      if let prefix = output.prefix { stdout.append(prefix) }
      stdout.append(output.warnIcon)
    case .Ok:
      if !options.quiet {
        if let prefix = output.prefix { stdout.append(prefix) }
        stdout.append(output.okIcon)
      }
    }
  }

  print(stdout.joinWithSeparator(" "))
}

func parseArguments(arguments: [String]) -> Options {
  var args = arguments
  var options = Options(name: "", icons: [], quiet: false)
  options.name = args.removeAtIndex(0)

  for arg in args {
    switch arg{
    case "-q", "--quiet":
      options.quiet = true
    case "-p", "--power", "power":
      options.icons.append(iconPower)
    case "-n", "--network", "network":
      options.icons.append(iconNetwork)
    case "-h", "--help", "help":
      printHelp()
      exit(EXIT_SUCCESS)
    default:
      print("Unknown argument \(arg)")
      printHelp()
      exit(EXIT_FAILURE)
    }
  }

  return options
}

func printHelp() {
  print("halp")
}

func iconNetwork() -> IconOutput {
  var output = IconOutput(
    okIcon: "📶",
    warnIcon: "📶",
    errorIcon: "❗📶",
    status: IconStatus.Ok,
    prefix: nil
  )

  output.status = IconStatus.Error
  return output
}

func iconPower() -> IconOutput {
  var output = IconOutput(
    okIcon: "🔌",
    warnIcon: "🔋",
    errorIcon: "❗🔋",
    status: IconStatus.Ok,
    prefix: nil
  )

  let powerSources = IOPSCopyPowerSourcesInfo().takeRetainedValue()
  let batteries = IOPSCopyPowerSourcesList(powerSources).takeRetainedValue() as Array

  guard batteries.count == 1 else {
    return output
  }

  let battery = batteries[0]
  print(battery)

  let isCharging = battery["Is Charging"] as! Bool

  if isCharging {
    if let minutes = battery["Time to Full Charge"] as! Int {
      if minutes != 0 { output.prefix = formatDuration(minutes) }
    }
  } else {
    output.status = IconStatus.Warn

    if let minutes = battery["Time to Empty"] as! Int {
      output.prefix = formatDuration(minutes)
      if minutes < 60 { output.status = IconStatus.Error }
    }
  }

  return output
}

func formatDuration(minutes: Int) -> String {
  return "\(minutes / 60):\(String(format: "%02d", minutes % 60))"
}

main()
