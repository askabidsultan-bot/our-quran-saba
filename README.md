# SABA Universal AI Backend

Backend package for SABA Universal AI, including the existing SABA chat/file
system and the SABA Image backend extension.

## Existing capabilities preserved

- General AI chat
- Streaming responses
- File uploads
- Image/document understanding
- Visual memory
- Chat-isolated visual memory
- Projects
- Supabase authentication support
- Web-search capable chat configuration
- Guest chat support

## SABA Image capabilities

- Explicit image-generation intent
- Text-to-image generation
- Single-image editing
- Multiple-image composition
- Reference-image workflows
- Continued conversational editing
- Image-generation streaming/partial-image events where supported
- Configurable image quality, size and output format

## Install

```bash
npm install
```

Create `.env` from `.env.example`, then set your real server-side credentials.

Start:

```bash
npm start
```

## Security

Never expose `OPENAI_API_KEY` in frontend JavaScript.
Never commit `.env` or Supabase service-role credentials.

## Important data-preservation rule

Do not delete or replace an existing production `data/` directory during deployment.
It may contain projects, file indexes, and visual-memory data.

## Recommended repository files

```text
.gitignore
package.json
package-lock.json
saba-server.mjs
.env.example
README.md
SABA_IMAGE_SYSTEM_ARCHITECTURE.md
data/
```

The architecture document describes the intended SABA Image workflow and should
be used as a reference when implementing the frontend.
