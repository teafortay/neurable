# Coding Task

We would like you to build a simple app that mimics the behavior of the live data sync from our headphones.

## Intro

1. Create the Xcode project and make use of both attached Swift files:

- `session.pb.swift` - data model
- `ProtobufValidator.swift` - offering a method to validate the correctness of the created data object

2. Please also add the SwiftProtobuf library (https://github.com/apple/swift-protobuf)

## AC

1. As a User
I want to be able to start the focus session 
So that I can start tracking my focus level.

2. As a User, during the focus session
I want to see the focus plot chart presenting the focus level in the last 30 seconds
So that I can check my focus level on the plot.

3. As a User, during the focus session
I want to see the gaps in the plot when data is missing or the data quality of the sample is under 30%
So that I can track the absence or low-quality data.

4. As a User
I want to be able to stop the focus session
So that I can prepare my session data to be uploaded to the backend.

## Assumptions

1. In real life scenario, we are transferring the data from our headphones using BLE, however for the sake of the challenge please create a mock of the headset generating new random samples each second with some chance of dropping values due to “connection issues”.

2. Each sample should contain two values - focus level (0-100%) and data quality (0-100%).

3. Please use SwiftCharts to draw the plot looking similar to the attached `focus_plot.png`.

4. Use the `sessions.pb.swift` model to create a data object with session info.

5. Use the validation method from `ProtobufValidator.swift` to validate if the session data model is correct.

## Further Notes

1. Consider things you may have learned about the technology stack so far, eg. the use of the specific technologies or architecture patterns, eg. SwiftUI for UI & plot.

2. Although you don’t need to upload the data anywhere, please include some details about how you might do this in the real product.

3. It’s perfectly fine to use third-party libraries and, in some cases, it’s even better to, but please be as fussy as we are, and please let us know why you decided to choose any libraries.

4. Please let us know if you choose a third-party library for time-saving when doing this challenge.

5. Feel free also to note down all other simplifications you decided to introduce compared to the real-world scenario.

6. Please use the project README.md file to describe your solution.

7. You can share the solution with us via GitHub - please invite <TODO: add GitHub handles>
recruiting@neurable.com

Taylor Shaw

The ContentView has a simple view which displays the data. I generate the data in the ContentViewModel, using the DataGenerator. The FocusDataGenerator file has a public function which generates a random sample. I use the `toggleButton` function in the view model to generate data, send the data to the view, and validate the data using the ProtobufValidator.
