# Coach.ai

Coach.ai is a mobile application built using Flutter that uses TensorFlow's MoveNet model for pose detection to help users count their reps and detect the correctness of their pose. In addition to this, the app has additional modules for BMI calculation, nutrition tracking, and user authentication using Firebase.

## Features

The following are the key features of the Coach.ai app:

- **Reps counter**: The app uses the MoveNet model to detect the user's pose and count the number of reps they perform for a specific exercise.
- **Pose correctness detection**: The app also checks the correctness of the user's pose and provides feedback on how to improve their form. The app uses custom machine learning models trained on MoveNet keypoints as input to classify the correctness of the user's pose.
- **BMI calculator**: The app has a module for calculating the user's BMI (Body Mass Index), based on their height and weight inputs.
- **Nutrition tracker**: The app allows users to track their daily food intake and provides insights into their nutrient consumption.
- **User authentication**: The app uses Firebase for user authentication, allowing users to securely create an account, sign in, and manage their profile.

## Technologies Used

The following technologies were used to build the Coach.ai app:

- **Flutter**: Flutter is an open-source UI software development kit created by Google. It is used for building high-performance, high-fidelity apps for Android, iOS, web, and desktop from a single codebase.
- **TensorFlow**: TensorFlow is an open-source software library for dataflow and differentiable programming across a range of tasks. It is used for building and training machine learning models.
- **MoveNet**: MoveNet is a lightweight and efficient neural network architecture for human pose estimation that can run on mobile devices.
- **Firebase**: Firebase is a mobile and web application development platform that provides a suite of services to help developers build, grow, and monetize their apps.

## Getting Started

To get started with the Coach.ai app, follow these steps:

1. Clone the repository to your local machine.

```bash
git clone https://github.com/MohEsmail143/coach-ai.git
```

2. Navigate to the root directory of the project and run the following command to install the dependencies:

```bash
flutter pub get
```

3. Launch the app on an emulator or a physical device

```bash
flutter run
```

## Contributing

If you would like to contribute to the development of Coach.ai, please follow these guidelines:

1. Fork the repository and create a new branch for your feature or bug fix.

2. Write clean and concise code that adheres to the project's coding standards.

3. Test your changes thoroughly and ensure that they do not break any existing functionality.

4. Submit a pull request with a detailed description of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
