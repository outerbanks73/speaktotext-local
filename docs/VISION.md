# SpeakToText Local - Vision

## Mission

Provide a privacy-first, locally-run audio transcription tool that gives users complete control over their data while delivering professional-quality transcriptions with speaker identification.

## Core Principles

### 1. Privacy by Design
Audio data is sensitive. Meeting recordings, personal notes, interviews, and conversations contain information that users rightfully want to keep private. SpeakToText Local processes everything on the user's machine—no cloud uploads, no third-party servers, no data retention concerns.

### 2. Accessibility
Professional transcription services are expensive. By leveraging open-source models (OpenAI Whisper, pyannote.audio), we make high-quality transcription available to everyone with a computer capable of running the models.

### 3. Simplicity
Complex developer tools shouldn't require a PhD to use. A Chrome extension provides a familiar interface, and the local server handles the heavy lifting transparently.

### 4. Flexibility
Users have different needs:
- Quick drafts need speed (tiny model)
- Important transcriptions need accuracy (large model)
- Some need speaker identification, others don't
- Input sources vary: files, URLs, live recordings

## Target Users

1. **Journalists & Researchers** - Transcribing interviews while protecting source confidentiality
2. **Content Creators** - Converting podcasts/videos to text for show notes or repurposing
3. **Students & Educators** - Transcribing lectures and study materials
4. **Professionals** - Meeting notes, call transcriptions, voice memos
5. **Privacy-Conscious Users** - Anyone who wants transcription without cloud dependency

## Long-Term Vision

SpeakToText Local aims to be the go-to solution for anyone who needs transcription but doesn't want to—or can't—send audio to cloud services. As local AI capabilities improve, the tool will evolve to offer:

- Real-time transcription
- Multiple language support
- Custom vocabulary training
- Integration with note-taking apps
- Cross-platform desktop applications

## What We Don't Do

- **Collect user data** - We have no analytics, no telemetry, no tracking
- **Require accounts** - The tool works out of the box (Hugging Face token is optional for speaker diarization)
- **Phone home** - The only external connections are model downloads (one-time) and URL audio fetching (user-initiated)
- **Lock users in** - All transcripts are plain text, easily exportable

## Version 1.1.0 Milestone

This release establishes the foundation:
- Stable transcription pipeline with subprocess isolation
- Three input methods: file upload, URL, tab recording
- Speaker diarization support
- Smart URL detection for streaming sites
- Clean, intuitive Chrome extension UI
