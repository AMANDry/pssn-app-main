fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android build_apk

```sh
[bundle exec] fastlane android build_apk
```

Create a new APK build

### android build_aab

```sh
[bundle exec] fastlane android build_aab
```

Create a new AAB build

### android deploy_to_firebase

```sh
[bundle exec] fastlane android deploy_to_firebase
```

Submit a new build to Firebase App Distribution

### android deploy_to_play_console

```sh
[bundle exec] fastlane android deploy_to_play_console
```

Submit a new build to Google Play internal testing track

### android promote_to_production

```sh
[bundle exec] fastlane android promote_to_production
```

Promote internal track build to production

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
