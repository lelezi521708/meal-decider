# meal-decider — User Guide

## 1. Sign in

Open the GitHub Pages URL and choose one of the four accounts. Enter that account's Supabase password and press. The session is retained by the browser, so a refresh does not require another login.

Only the four created Supabase users can access the shared database. There is no registration form.

## 2. Browse the restaurant library

The tab contains three filters:

-every saved restaurant.
 — restaurants with the visited switch enabled.
 — restaurants that are still on the family wish list.

Use the search field to find a name, category, Shenyang area or note. Tap a card to expand the complete record. The card shows each family member's score and the current average.

## 3. Add or edit a restaurant

1. Open 
2. Choose a photo from the phone or computer. The browser compresses it before uploading.
3. Enter the restaurant name, category and Shenyang area/address.
4. Turn onand choose a date when appropriate.
5. Add discount tags and notes such as recommended dishes or warnings.
6. Set any of the four scores: WBY, SOL, WL and WCY. Leaving a person blank is allowed.
7. Press .

The average is calculated from the completed scores only. For example, scores 8 and 6 display an average of 7; blank scores are not treated as zero.

To edit, press the pencil button on a card or open the card and choose . To delete, use the trash button and confirm.

## 4. Use the food wheel

1. Open .
2. Select one mode: all restaurants, visited restaurants or not-yet-visited restaurants.
3. Optionally choose a category and a minimum average score.
4. Confirm the eligible count.
5. Press .

The wheel accelerates, slows down and stops on one restaurant. The result says  and includes the photo, four scores, average, rating label, tags and notes.

Rating labels are:

- 8–10: 
- 6–under 8:
- 4–under 6: 
- 0–under 4: 

Use to spin again or  to open the restaurant record. If no restaurant meets the filters, loosen the category or score requirement.

## 5. Settings and backups

In **设置 & 数据** you can:

- Upload a WBY, SOL, WL or WCY avatar.
- Enable or disable the small color-confetti result effect.
- Enable or disable wheel sound (reserved for future sound additions).
- View collection, visited and not-yet-visited counts.
- View a simple rating distribution.
- Export every restaurant as a JSON backup file.
- Log out of the current account.

Keep a JSON backup before large edits. The backup is local to the device that downloads it; it is not automatically uploaded to Supabase.

## 6. Realtime behavior

When one family member adds, edits, scores or deletes a restaurant, Supabase Realtime broadcasts the change to the other open sessions. If a tab looks stale, refresh once and check the small sync dot beside the current user.

## 7. Mobile tips

- Add the GitHub Pages URL to the iPhone home screen using Safari's Share menu.
- Use landscape orientation for a larger wheel on small phones.
- Images are compressed in the browser before upload to reduce storage use.
