# meal-decider

**今天全家吃什么？** is a mobile-first family restaurant decision tool for WBY, SOL, WL and WCY. It is a static HTML + Tailwind CSS + JavaScript app backed by Supabase Auth, Postgres, Storage and Realtime.

## Features

- Four fixed Supabase accounts: WBY, SOL, WL and WCY (no public registration).
- Shared restaurant library with visited / not-yet-visited groups.
- Shenyang area/address fields, custom categories and discount tags.
- Four independent 0–10 scores. The average uses only completed scores.
- Compressed restaurant photos and family avatars in Supabase Storage.
- Realtime updates for adds, edits, scores, deletes and settings.
- A filterable wheel: all restaurants, visited restaurants or not-yet-visited restaurants.
- Average-score labels: 很美味, 还不错, 一般, 别吃了.
- JSON backup export and optional PWA installation.

## Folder layout

```text
dist/                 deploy this folder
  index.html          UI shell
  app.js              application logic and Supabase calls
  styles.css          warm family theme
  config.js           Supabase URL + publishable key
supabase/schema.sql   database, RLS, Storage and Realtime setup
USER_GUIDE.md         complete English user guide
```

## Supabase setup

1. Create or open a Supabase project.
2. In **SQL Editor**, run [`supabase/schema.sql`](supabase/schema.sql).
3. In **Authentication → Users**, create exactly four confirmed users. Use these emails (or keep the same prefixes):
   - `wby@meal-decider.app`
   - `sol@meal-decider.app`
   - `wl@meal-decider.app`
   - `wcy@meal-decider.app`
4. Set a password for each user and confirm the accounts.
5. Copy the project URL and publishable key from **Project Settings → API** into `dist/config.js`.

The publishable key is intended for browser use. Never put a Supabase secret/service-role key in this repository. RLS policies limit data access to authenticated users.

## Local preview

```bash
cd meal-decider/dist
python3 -m http.server 8080
```

Open <http://localhost:8080>. Without Supabase configuration, the app automatically uses a local demo mode.

## GitHub Pages deployment

1. Push the repository to GitHub (the repository may be public for Pages).
2. Open **Settings → Pages**.
3. Choose **Deploy from a branch**.
4. Select `main` and the `/dist` folder, then save.
5. GitHub will publish a URL similar to `https://YOUR_USERNAME.github.io/meal-decider/`.

If you prefer GitHub Actions, point the workflow artifact at the contents of `dist/`. The app is buildless: no npm install or build command is required.

## Security notes

- The frontend exposes only a publishable key.
- Supabase Auth and RLS protect restaurant rows and settings.
- Storage images are public URLs by design; the image URL is not a database permission bypass.
- Review the RLS policies before adding any additional tables.

## Updating the app

Edit files under `dist/`, then commit and push:

```bash
git add .
git commit -m "update meal-decider"
git push origin main
```

GitHub Pages will redeploy after the push.
