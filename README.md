# ~~Project name~~ (iOS)

~~Short project description.~~

## Project info

- Deadline: ~~**--. --. ----**~~
- Next release: ~~**1.0.0**~~
- Deployment target: ~~**12.0**~~
- Bundle identifier: ~~`app.futured.project`~~
- Supports: ~~**Dark mode, landscape orientation, iPadOS, watchOS**~~
- Design: ~~Figma (add link)~~
- ~~Backend: Apiary (add link)~~

### Team:

- ~~Jana Nováková, PM, <jana.novakova@futured.app>~~
- ~~Jan Novák, iOS developer, <jan.novak@futured.app>~~
- ~~John Newman, tester, <john.newman@futured.app>~~

## Configuration management

### Tools

- Language: ~~**Swift 5.0**~~
- IDE: ~~**Xcode 11.0**~~
- Dependency management: ~~**[Swift package manager](https://swift.org/package-manager/)**~~
- Command line tools: **[Fastlane](https://docs.fastlane.tools)**
- Code style:
	- **[SwiftLint](https://swift.org/package-manager/)**
	- **[Danger](https://github.com/futuredapp/danger)**
- ~~Localizations: Czech, English – **[POEditor](https://poeditor.com)**~~

### Dependencies

- ~~**[FTAPIKit](https://github.com/futuredapp/FTAPIKit)** (Declarative access to REST API.)~~
- ~~**[FTTestingKit](https://github.com/futuredapp/FTTestingKit)** (Helpers for testing long-running tasks and generating mockups)~~
- ~~**[FuntastyKit](https://github.com/futuredapp/FuntastyKit)** (Basics of MVVM-C architecture, coordinators, UIKit extensions and helpers.)~~
- ~~**[PromiseKit](https://github.com/mxcl/PromiseKit)** (Functional library for chaining and using backround and long running tasks.)~~

### Security standard

This project complies with ~~Standard (F0), High (F1), Highest (F2)~~ security standard.

~~[Project specific standard](www.notion.so)~~

## Installation

1. Install all required tools:
	- Install ruby: `brew install ruby`
	- In the project folder install all ruby tools: `bundle install`
2. Download development provisioning profiles and certificate: `bundle exec fastlane provisioning`
3. Build using Xcode or using Fastlane:
	- Debug build and run tests: `bundle exec fastlane test`
	- Build for enterprise distribution and submit to App Center: `bundle exec fastlane enterprise`
	- Build and submit to App store connect: `bundle exec fastlane beta`
