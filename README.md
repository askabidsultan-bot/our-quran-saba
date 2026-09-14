# SABA Universal AI — V25 Backend

This is the backend package intended for the SABA Universal AI V25 Vision Restore frontend.
The `saba-server.mjs` file is the restored V25 backend source used by the V25 frontend.

## Main capabilities

- Normal SABA chat and streaming
- Uploaded image/document understanding (vision)
- File upload through `/api/saba/file`
- Persistent visual memory scoped to a chat
- SABA Image text-to-image generation
- Single-image editing
- Multi-image editing / combination
- Continued image editing using previous image references
- Image streaming / partial image events
- Durable image persistence with optional Supabase Storage + metadata
- Image download and retrieval routes
- Voice transcription
- Tools: chat / image / coding / research
- Luis 1.2 model alias

## Required files

- `saba-server.mjs`
- `package.json`
- `.env` created from `.env.example`
- `SABA_IMAGE_CLOUD_DB_SETUP.sql` — only required if Supabase durable image persistence is wanted

## Install

```bash
npm install
npm start
```

`package.json` starts `saba-server.mjs`.

## Required environment variable

```text
OPENAI_API_KEY=...
```

Keep the OpenAI API key only on the server. Never place it in the HTML/frontend or GitHub repository.

## Image generation settings

Defaults in `.env.example`:

```text
SABA_IMAGE_MODEL=gpt-image-2
SABA_IMAGE_QUALITY=medium
SABA_IMAGE_SIZE=auto
SABA_IMAGE_OUTPUT_FORMAT=png
SABA_IMAGE_PARTIALS=2
```

## Supabase durable image storage

If durable cloud persistence is enabled, configure:

```text
SUPABASE_URL=...
SUPABASE_SERVICE_ROLE_KEY=...
SABA_IMAGE_BUCKET=saba-images
```

Run `SABA_IMAGE_CLOUD_DB_SETUP.sql` once in the Supabase SQL Editor. The server creates the private Storage bucket automatically when it first needs it.

`SUPABASE_SERVICE_ROLE_KEY` must never be exposed to the frontend or committed to GitHub.

## Render / GitHub deployment

Use this repository as the backend service:

- Build command: `npm install`
- Start command: `npm start`
- Add the environment variables in Render's Environment settings.

Do not commit `.env` or real API keys.

## Frontend compatibility

The V25 Vision Restore frontend expects the existing routes including:

```text
POST /api/saba
POST /api/saba/stream
POST /api/saba/file
POST /api/saba/transcribe
POST /api/saba/image/generate
POST /api/saba/image/reference
POST /api/saba/image/edit
POST /api/saba/image/intent
POST /api/saba/image/stream
GET  /api/saba/image/file/:id
GET  /api/saba/image/file/:id/download
GET  /api/saba/image/cloud
GET  /api/saba/image/cloud/download
GET  /api/saba/image/asset/:assetId
GET  /api/saba/image/asset/:assetId/download
```

Do not remove or rename these routes when deploying the V25 frontend.

## Important

The backend source is kept as a restored snapshot. Do not independently refactor, replace, or redesign working image/vision routing when integrating it with the V25 frontend.
