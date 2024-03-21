# Chat Mate

Chat Mate is a Flutter AI chatbot app that allows users to interact with two different AI models: Gemini and Claude. Gemini is used in the Gemini tab for responses to user prompts, while Claude, from the Anthropic API, is used in the ChatGPT tab due to ChatGPT API keys not being available for free.

## Features

- Authentication via Google account
- Gemini tab: Uses the Gemini API for AI responses. Responses are received as streams, providing faster interaction.
- ChatGPT tab: Uses Claude from the Anthropic API for AI responses. Note that this option was chosen because the ChatGPT API key was not available for free, unlike the Gemini API.

## Installation

1. Clone the repository
2. Run `flutter pub get`
3. Configure Firebase for authentication and Firestore for database (details in `firebase_core` and `cloud_firestore` packages documentation)
4. Get API keys for Gemini and Anthropic (Claude) and replace them in the code

## Packages Used

- cupertino_icons
- intl
- google_fonts
- animated_text_kit
- flutter_svg
- local_hero
- firebase_core
- cloud_firestore
- firebase_auth
- flutter_glow
- google_sign_in
- flutter_riverpod
- google_generative_ai
- formatted_text
- cached_network_image
- shimmer
- loading_animation_widget
- dio
- flutter_native_splash

## Screenshots

![Authentication Screen](https://github.com/nith-in7/AI-ChatBot/assets/124262214/2c396c11-d571-496d-87bf-2ac76e328d04)
![Start Screen](https://github.com/nith-in7/AI-ChatBot/assets/124262214/327f65fb-fe3c-4c92-b155-377e00f19229)
![Profile Detail](https://github.com/nith-in7/AI-ChatBot/assets/124262214/48a0a8f9-8f8a-4861-b37c-678477528198)
![ChatGPT Tab](https://github.com/nith-in7/AI-ChatBot/assets/124262214/5eab6acb-0983-41a7-aa22-9728beb1514b)
![Gemini Tab](https://github.com/nith-in7/AI-ChatBot/assets/124262214/f7f72faf-dd9a-4276-b000-69d92be3eb2e)

## Demo

![Demo](https://github.com/nith-in7/AI-ChatBot/assets/124262214/b1f1374c-9cbc-40ec-bc23-b38420603ae1)

## Notes

- The formatted_text package is used to format the response received from the AI models.
- Gemini responses are received as streams, providing faster interaction compared to Claude, where responses are returned only after they are completed.
