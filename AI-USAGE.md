# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

At least six entries. One per real use. Every entry needs a commit link.

### 2026-09-29 - chore: migrate existing project

- **Tool:** Claude
- **What I asked for:** I asked for help in the dungeon section of the code, as well as with map and `quest_sheet.dart`
- **What it gave back:** Most of the content in the aforementioned sections of code are what it gave back.
- **What I kept, what I changed, and why:** I changed some names around for me to understand better and I made changes mostly in `quest_sheet.dart` and map for aesthetic/artstyle integration reasons. For the dungeon section of the code, the whole bit with type assignment and RoomType in general were commented out since they were complexity that I have yet to jump into.
- **Commit:** https://github.com/RalSz/TodoHero/commit/3d547bacfb8c99e1ec8e2c1a3845e4f678150933

### 2026-10-03 - feat: add quest-type-specific adding

- **Tool:** Claude
- **What I asked for:** I asked for some implementations of different selection types that were applicable to my app
- **What it gave back:** It gave me what I asked for
- **What I kept, what I changed, and why:** I changed the values, mostly, as I don't like to leave all the coding to AI so I gave it only enough to teach me how new stuff like CupertinoPicker is used.
- **Commit:** https://github.com/RalSz/TodoHero/commit/06b042807d2a1ee675373f8cab6014452c3018ae

### 2026-10-04 - feat: add quest completion checks

- **Tool:** Claude
- **What I asked for:** I asked for improvements in some ideas that I had, as well as some new stuff.
- **What it gave back:** It gave me what I asked for, but the `_createCompleteRequirement()` had a duplicate in its code
- **What I kept, what I changed, and why:** I changed values and names, mostly, to help me understand things. The aforementioned method, I also collapsed into just one, renamed method, as the AI gave me two methods that did the same thing but under different names.
- **Commit:** https://github.com/RalSz/TodoHero/commit/325e836b88a5530dcadbe890c0cfbbe1ab3d76ee

### 2026-10-04 - feat: add room-based visuals

- **Tool:** Claude
- **What I asked for:** I asked for help in updating the files under `dungeon/` as well as help in creating room-based visuals
- **What it gave back:** It gave me what I asked for, if a bit overenthusiastic. It gave me some extra stuff and implementations of classes that I also didn't need.
- **What I kept, what I changed, and why:** I kept the stuff under `dungeon/`, as they were simple but required stuff. I changed out a lot in `home_screen.dart` as it gave me a bunch of stuff like a custom `_RoomTile` class that I didn't need.
- **Commit:** https://github.com/RalSz/TodoHero/commit/c995fdc61e7b6249451a213782ba2dde11dd1ee9

### 2026-10-04 - feat: add completion feedback

- **Tool:** Claude
- **What I asked for:** I asked for help in system integration
- **What it gave back:** It gave me what I needed, as well as some corrections in my code.
- **What I kept, what I changed, and why:** I kept most, if not all, of what it gave. After some testing, it really was all needed so I kept them.
- **Commit:** https://github.com/RalSz/TodoHero/commit/22e07a6cd8a0fcc45b219180aefd490f7ce7cc8e

## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

### Case 1 - room visuals

- **What it gave me:** It gave me some code that had a lot of text, even had a whole custom class for the displaying of different stuff.
- **What was wrong with it:** Text is not what I wanted, I wanted images to be displayed.
- **What I did instead:** I copied what was useful and replaced the whole custom class with just some Image objects.
- **Commit:** https://github.com/RalSz/TodoHero/commit/c995fdc61e7b6249451a213782ba2dde11dd1ee9

## 3. Who wrote what

At least a fifth of this project is code you wrote yourself. Name it, and explain
it in your own words.

### Written by me

- **File:** `dropdown_menu_type.dart`
- **Commit:** https://github.com/RalSz/TodoHero/commit/3d547bacfb8c99e1ec8e2c1a3845e4f678150933
- **What it does and why it is built this way:** It is a dropdown menu that selects a type from an enum from `TodoItem`. It was chosen as it is an intuitive single-choice selection and it was built like this as it was mostly structured like so in the page that I saw from the flutter website.

### The AI-written part I understand best

- **File:** `add_screen`
- **Commit:** https://github.com/RalSz/TodoHero/commit/06b042807d2a1ee675373f8cab6014452c3018ae
- **What it does and why I kept it:** It adds a quest depending on the type of quest. It was half-written by me and the AI stuff are just selection implementations like `CupertinoPicker`.
