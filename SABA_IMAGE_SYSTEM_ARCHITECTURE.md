# SABA Image System Architecture

## 1. Core rule

SABA must NOT generate an image merely because an image could be useful.

In normal chat, image generation/editing starts only when the user's instruction
clearly requests image creation, photo generation, image editing, modification,
transformation, combination, or a similar image action.

Examples:

- "How is the weather?" -> normal text answer
- "Explain this problem." -> normal text answer
- "Create an image of a futuristic city." -> image generation
- "Edit this photo and remove the background." -> image editing
- "Combine these two images." -> multi-image composition

## 2. High-level flow

```text
User
  |
  v
SABA Frontend
  |
  +--> Normal text intent ------> Existing /api/saba flow
  |
  +--> Explicit image intent ---> SABA Image Engine
                                    |
                                    +--> Generate
                                    +--> Edit
                                    +--> Multi-image compose
                                    +--> Continue editing
                                    |
                                    v
                               OpenAI Image API
                                    |
                                    v
                              Image result/events
                                    |
                                    v
                               SABA Frontend
```

## 3. SABA Image mode

The dedicated mode is named:

**SABA image**

It is an image-focused workspace. Its primary output is the image rather than
a conventional text answer.

The interface should provide:

- Prompt input
- Image upload
- Multiple image upload
- Generation state
- Image preview
- Download
- Share
- Edit
- Regenerate
- Use as reference
- Follow-up editing prompt

## 4. Text-to-image

```text
Prompt
  -> backend validation
  -> image model request
  -> generation events (when supported)
  -> completed image
  -> immediate preview
```

The completed image should be visible to the user before download.

## 5. Image editing

```text
Existing image
      +
New instruction
      |
      v
Image edit request
      |
      v
Updated image
```

Examples:

- Change the sky
- Remove an object
- Change clothing
- Replace the background
- Make the image more realistic
- Improve lighting

## 6. Multiple-image composition

```text
Image A
Image B
Image C (optional)
   +
User instruction
   |
   v
Composition/edit request
   |
   v
New combined image
```

The system should preserve the user's intended subjects and relationships as much
as the image model allows.

## 7. Conversational editing

Each generated/edited image can become the reference for the next instruction.

```text
Image 1
  |
  +-- "Change the sky"
  v
Image 2
  |
  +-- "Change the clothes"
  v
Image 3
  |
  +-- "Make it cinematic"
  v
Image 4
```

The frontend/backend should retain the appropriate image reference for the active
image conversation without mixing images from unrelated chats.

## 8. Generation visualization

The frontend should show a clear generation state immediately after the request.

Where the API supplies partial-image events, the frontend can progressively update
the visual preview. When generation completes, the final image replaces/updates
the preview.

Important states:

```text
idle
  -> preparing
  -> generating
  -> previewing/intermediate (when available)
  -> completed
```

Error state:

```text
generating -> failed -> clear error + retry option
```

## 9. Final image actions

After completion, provide:

- Full image preview
- Download
- Share
- Edit
- Regenerate
- Use as reference
- Continue editing

Download must not be required before preview.

## 10. File handling

Uploaded images should be validated by the backend.

Do not trust a browser-provided MIME type alone. Validate file size/type and reject
unsupported input cleanly.

Keep existing SABA file handling and visual-memory behavior intact unless a future
explicit change requires otherwise.

## 11. Security

The OpenAI API key stays on the server.

Never put:

```text
OPENAI_API_KEY
SUPABASE_SERVICE_ROLE_KEY
```

into frontend JavaScript or committed source.

## 12. Performance principles

- Keep normal text requests on the existing text path.
- Route image requests only when image intent is explicit.
- Stream events where supported.
- Avoid unnecessary image conversions.
- Reuse uploaded/reference file IDs where appropriate.
- Do not repeatedly upload the same image when a reusable server-side reference
  is already available.
- Keep image generation independent from unrelated chat processing.

## 13. Chat isolation

Image references must belong to the active conversation/session.

An image from one chat must not automatically become available to another chat.

This follows the existing SABA visual-memory isolation principle.

## 14. Error handling

The backend should return useful machine-readable errors for:

- Missing prompt
- Missing image
- Invalid image
- Unsupported image format
- File too large
- OpenAI authentication failure
- Model/API failure
- Timeout
- Rate/usage limitation
- Empty image result

The frontend should convert these into user-friendly messages.

## 15. Future extensibility

The architecture should allow later additions such as:

- Image variations
- Higher-quality generation modes
- More output sizes
- More reference-image controls
- Background removal
- Inpainting/outpainting
- Image history/version selection
- Image metadata
- Gallery/history
- Project-based image collections

These should be added without removing existing SABA functionality.

## 16. Preservation requirement

This architecture is additive.

Existing SABA chat, streaming, authentication, files, projects, visual memory,
configuration and other working functionality must remain unless the user
explicitly authorizes a change.
