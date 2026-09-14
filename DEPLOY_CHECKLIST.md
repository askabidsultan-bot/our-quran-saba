# SABA V25 Backend Deployment Checklist

1. Push these backend files to the GitHub repository.
2. Add `OPENAI_API_KEY` in Render Environment Variables.
3. Set `SABA_IMAGE_MODEL=gpt-image-2` unless another configured image model is intentionally used.
4. Keep `SABA_IMAGE_QUALITY`, `SABA_IMAGE_SIZE`, and `SABA_IMAGE_OUTPUT_FORMAT` as desired.
5. If using Supabase durable image storage, add the Supabase variables and run `SABA_IMAGE_CLOUD_DB_SETUP.sql` once.
6. Deploy with `npm install` and `npm start`.
7. Open `/health` and confirm the backend responds.
8. Test an uploaded photo with a normal question such as `What is this?` — this must use the vision/chat route, not image generation.
9. Test a prompt such as `Create an image of ...` — this must use `/api/saba/image/generate`.
10. Test image editing with an attached reference — this must use `/api/saba/image/edit`.
