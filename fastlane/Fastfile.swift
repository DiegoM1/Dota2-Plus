// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
	func customLane() {
	desc("Description of what the lane does")
		// add actions here: https://docs.fastlane.tools/actions
	}
    
    func swiftLintLane() {
            desc("Run SwiftLint")
            swiftlint(configFile: ".swiftlint.yml",
                      strict: true,
                      ignoreExitStatus: false,
                      raiseIfSwiftlintError: true,
                      executable: "Pods/SwiftLint/swiftlint"
            )
        }
    
    func buildLane() {
            desc("Build for testing")
            scan(workspace: "Dota2 plus.xcworkspace",
                 derivedDataPath: "derivedData",
                 buildForTesting: .userDefined(false),
                 xcargs: "CI=true")
        }
    
    func unitTestLane() {
            desc("Run unit tests")
            scan(workspace: "Dota2 plus.xcworkspace",
                 onlyTesting: ["Dota2 plusTests"],
                 derivedDataPath: "derivedData",
                 testWithoutBuilding: .userDefined(true))
        }
    
}
