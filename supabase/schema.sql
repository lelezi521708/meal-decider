-- Run once in Supabase SQL Editor. The four Auth users are created in Dashboard > Authentication > Users.
create extension if not exists pgcrypto;

create table if not exists public.meal_restaurants (
  id uuid primary key default gen_random_uuid(), name text not null check (char_length(name) between 1 and 80), image_url text,
  category text not null default '其他', address text default '', visited boolean not null default false, visited_date date,
  discounts text[] not null default '{}', notes text check (char_length(notes) <= 1000),
  wby_score numeric(3,1) check (wby_score between 0 and 10), sol_score numeric(3,1) check (sol_score between 0 and 10),
  wl_score numeric(3,1) check (wl_score between 0 and 10), wcy_score numeric(3,1) check (wcy_score between 0 and 10),
  created_by text check (created_by in ('wby','sol','wl','wcy')), created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.meal_settings (
  id integer primary key default 1 check (id = 1), wby_avatar text, sol_avatar text, wl_avatar text, wcy_avatar text,
  particles_enabled boolean not null default true, sound_enabled boolean not null default false, updated_at timestamptz not null default now()
);
insert into public.meal_settings(id) values (1) on conflict (id) do nothing;
create or replace function public.meal_touch_updated_at() returns trigger language plpgsql security invoker as $$ begin new.updated_at=now(); return new; end; $$;
drop trigger if exists meal_restaurants_touch on public.meal_restaurants;
create trigger meal_restaurants_touch before update on public.meal_restaurants for each row execute function public.meal_touch_updated_at();
drop trigger if exists meal_settings_touch on public.meal_settings;
create trigger meal_settings_touch before update on public.meal_settings for each row execute function public.meal_touch_updated_at();

alter table public.meal_restaurants enable row level security; alter table public.meal_settings enable row level security;
drop policy if exists "family read restaurants" on public.meal_restaurants; create policy "family read restaurants" on public.meal_restaurants for select to authenticated using (true);
drop policy if exists "family add restaurants" on public.meal_restaurants; create policy "family add restaurants" on public.meal_restaurants for insert to authenticated with check (true);
drop policy if exists "family edit restaurants" on public.meal_restaurants; create policy "family edit restaurants" on public.meal_restaurants for update to authenticated using (true) with check (true);
drop policy if exists "family delete restaurants" on public.meal_restaurants; create policy "family delete restaurants" on public.meal_restaurants for delete to authenticated using (true);
drop policy if exists "family read settings" on public.meal_settings; create policy "family read settings" on public.meal_settings for select to authenticated using (true);
drop policy if exists "family edit settings" on public.meal_settings; create policy "family edit settings" on public.meal_settings for update to authenticated using (true) with check (true);
drop policy if exists "family add settings" on public.meal_settings; create policy "family add settings" on public.meal_settings for insert to authenticated with check (id=1);

insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types) values ('meal-images','meal-images',true,5242880,array['image/jpeg','image/png','image/webp','image/heic','image/heif']) on conflict (id) do update set public=true,file_size_limit=5242880;
drop policy if exists "public view meal images" on storage.objects; create policy "public view meal images" on storage.objects for select to public using (bucket_id='meal-images');
drop policy if exists "family upload meal images" on storage.objects; create policy "family upload meal images" on storage.objects for insert to authenticated with check (bucket_id='meal-images');
drop policy if exists "family update meal images" on storage.objects; create policy "family update meal images" on storage.objects for update to authenticated using (bucket_id='meal-images') with check (bucket_id='meal-images');
drop policy if exists "family delete meal images" on storage.objects; create policy "family delete meal images" on storage.objects for delete to authenticated using (bucket_id='meal-images');

do $$ begin
  if not exists(select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename='meal_restaurants') then alter publication supabase_realtime add table public.meal_restaurants; end if;
  if not exists(select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename='meal_settings') then alter publication supabase_realtime add table public.meal_settings; end if;
end $$;
