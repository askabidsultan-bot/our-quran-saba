-- SABA Image durable cloud storage (V18)
-- Run once in the Supabase SQL Editor for the project used by SABA.

create table if not exists public.saba_image_assets (
  asset_id text primary key,
  client_id text not null,
  chat_id text not null default '',
  cloud_key text not null,
  openai_file_id text,
  kind text not null default 'generated',
  mime_type text not null default 'image/png',
  output_format text not null default 'png',
  size bigint not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists saba_image_assets_client_chat_idx
  on public.saba_image_assets (client_id, chat_id, created_at desc);

create index if not exists saba_image_assets_cloud_key_idx
  on public.saba_image_assets (cloud_key);

alter table public.saba_image_assets enable row level security;

-- The SABA server uses the Supabase service-role key for these writes/reads,
-- so no client-side policy is required for the server workflow.

-- The server automatically creates the private Storage bucket named
-- "saba-images" (or SABA_IMAGE_BUCKET if configured) when first used.
