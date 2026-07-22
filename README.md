# OsmosGAMAdapter

Google Ad Manager mediation adapter for the OSMOS iOS SDK. Ships as a prebuilt, static `.xcframework` binary.

## Installation

**Recommended:** install via SPM using the [osmos-ios-gam-adapter-spm](https://github.com/onlinesales-ai/osmos-ios-gam-adapter-spm) wrapper package, which resolves all required peer dependencies (`GoogleMobileAds`, `OsmosNetworkAdCore`) automatically.

**Manual:** download the latest `OsmosGAMAdapter.xcframework.zip` from [Releases](https://github.com/onlinesales-ai/osmos-ios-gam-adapter/releases), drag it into your Xcode project (**Embed & Sign**), and separately link:
- `GoogleMobileAds` — **v11.x only** (12.x+ is not supported)
- [`OsmosNetworkAdCore`](https://github.com/onlinesales-ai/osmos-ios-network-ad-core/releases)

## Requirements

| OsmosGAMAdapter | Google Mobile Ads SDK |
|---|---|
| 1.0.x | 11.x (11.0.0 minimum) |

## Usage

Requires one runtime setup call — see the OSMOS GAM adapter setup guide for full integration steps, including calling `osmosGAMAdapterKeepLinked()` once alongside your OSMOS SDK setup so the static linker doesn't strip the adapter's mediation entry point.
