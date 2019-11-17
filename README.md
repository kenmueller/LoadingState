# LoadingState

> Declarative loading for Apple's declarative framework, **SwiftUI**

## Download

- File -> Swift Packages -> Add Package Dependency...
- Select your project
- Enter `https://github.com/kenmueller/LoadingState` for the package repository URL
- Select **Branch**: master
- Press **Finish**

## States

- `none`
	- Check with `loadingState.isNone` or `loadingState == .none`
- `loading(startDate: Date)`
	- Check with `loadingState.isLoading` or `loadingState == .loading`
- `success(endDate: Date)`
	- Check with `loadingState.didSucceed` or `loadingState == .success`
- `failure(endDate: Date, error: Error)`
	- Check with `loadingState.didFail` or `loadingState == .failure`

## Methods

- `loadingState.reset()`
	- Sets to `.none`
- `loadingState.startLoading()`
	- Sets to `.loading` with the startDate as the current date
- `loadingState.succeed()`
	- Sets to `.success` with the endDate as the current date
- `loadingState.fail(message: String)`
	- Sets to `.failure` with the endDate as the current date and the error as a BasicError with the message you passed in
- `loadingState.fail(error: Error)`
	- Sets to `.failure` with the end date as the current date and the error you passed in

## Properties

- `loadingState.isNone: Bool`
	- Returns `true` if the `loadingState` is none
- `loadingState.isLoading: Bool`
	- Returns `true` if the `loadingState` is loading
- `loadingState.didSucceed: Bool`
	- Returns `true` if the `loadingState` did succeed
- `loadingState.didFail: Bool`
	- Returns `true` if the `loadingState` did fail
- `loadingState.error: Error?`
	- Returns the error if `loadingState` failed. Otherwise, returns `nil`
- `loadingState.errorMessage: String?`
	- Returns the error message if `loadingState` failed. Otherwise, returns `nil`
- `loadingState.errorCode: Int?`
	- Returns the error code if `loadingState` failed. Otherwise, returns `nil`
- `loadingState.date: Date?`
	- Returns the date associated with the `loadingState`.
	- For example, if the `loadingState` is loading, this is the `startDate`.
	- If the `loadingState` is `.none`, this returns `nil`.

## Example

```swift
import SwiftUI
import LoadingState

struct ContentView: View {
	@State var loadingState = LoadingState()
	
	var body: some View {
		VStack {
			if loadingState.isNone {
				Text("Click the button!")
			} else if loadingState.isLoading {
				Text("Loading...")
			} else if loadingState.didSucceed {
				Text("Success!")
			} else {
				Text("Oh no! An error occurred. \(loadingState.errorMessage!)")
			}
			Button(action: {
				loadingState.startLoading()
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
					loadingState.succeed()
				}
			}) {
				Text("Click me!")
			}
		}
	}
}
```
