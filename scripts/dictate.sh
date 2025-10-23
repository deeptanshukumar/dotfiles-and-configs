#!/bin/bash

# Show popup "Listening..."
zenity --info --text="🎤 Listening... Speak now" --timeout=2 &

# Record short audio (5 seconds max, stops early if silence is detected)
rec -q -r 16000 -b 16 -c 1 /tmp/dictation.wav silence 1 0.1 1% 1 1.0 1%

# Run Whisper.cpp to transcribe
TEXT=$(./whisper.cpp/main -m ./whisper.cpp/models/ggml-base.en.bin -f /tmp/dictation.wav -otxt -of /tmp/out 2>/dev/null && cat /tmp/out.txt)

# Type recognized text into active window
xdotool type --clearmodifiers "$TEXT"

