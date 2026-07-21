// swift-tools-version: 6.0
import PackageDescription

// Distribution package for OsmosGAM — mirrors the osmos-ios-sdk-spm pattern.
//
// Why two targets instead of one binaryTarget?
// SPM binaryTarget cannot declare dependencies. OsmosGAM.xcframework was built
// against GoogleMobileAds AND OsmosNetworkAdCore (its .swiftinterface imports
// both), so the app must also link both. The wrapper target does nothing
// except pull in the binary plus those two peer dependencies — exactly the
// same trick Firebase and AppLovin use for their binary SDKs.
//
// OsmosNetworkAdCore comes from osmos-ios-network-ad-core-spm rather than a
// second inline binaryTarget here — osmos-ios-sdk-spm needs the identical
// module, and two independent inline binaryTargets both named
// "OsmosNetworkAdCore" would conflict ("multiple similar targets") the moment
// an app depends on both this package and osmos-ios-sdk-spm together.
// Pointing both at the same upstream package lets SPM dedupe it instead —
// this also makes this package self-contained regardless of how osmos itself
// was installed (SPM, CocoaPods, or manual).
//
// Workflow:
//   1. Build OsmosGAM.xcframework from osmos-ios-sdk-gam using build-xcframework.sh
//   2. Zip it: zip -r OsmosGAM-x.y.z.xcframework.zip OsmosGAM.xcframework
//   3. Upload zip to a GitHub release
//   4. swift package compute-checksum OsmosGAM-x.y.z.xcframework.zip
//   5. Update url + checksum in OsmosGAMBinary below
//   6. Tag and push this repo

let package = Package(
    name: "osmos-gam-adapter-spm",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "OsmosGAMAdapter",
            targets: ["osmos_gam_adapter"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads",
            from: "11.0.0"
        ),
        .package(
            url: "https://github.com/onlinesales-ai/osmos-ios-network-ad-core-spm",
            from: "1.0.0"
        )
    ],
    targets: [
        // Wrapper: declares GoogleMobileAds + OsmosNetworkAdCore dependencies so SPM
        // pulls both in automatically. Contains no source — it's a pure dependency bridge.
        //
        // Named "osmos_gam_adapter", NOT "OsmosGAMAdapter": the binaryTarget below
        // wraps a compiled xcframework whose own Swift module is already named
        // "OsmosGAMAdapter" (see osmos-gam-adapter-ios's build-xcframework.sh
        // MODULE_NAME). Naming this wrapper target the same would compile a second,
        // empty module under the identical name, colliding with the real one.
        .target(
            name: "osmos_gam_adapter",
            dependencies: [
                "OsmosGAMAdapterBinary",
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
                .product(name: "OsmosNetworkAdCore", package: "osmos-ios-network-ad-core-spm")
            ],
            path: "Sources/osmos_gam_adapter"
        ),

        // The compiled xcframework — update url + checksum on every release.
        .binaryTarget(
            name: "OsmosGAMAdapterBinary",
            url: "https://github.com/onlinesales-ai/osmos-ios-gam-adapter/releases/download/1.0.0/OsmosGAMAdapter-1.0.0.zip",
            checksum: "8557f3e68f9e380086b6699d8ad20ec83510997240bd371f8a02e7169a2d7e64"
        )
    ]
)
