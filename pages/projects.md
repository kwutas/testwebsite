---
title: Our Projects
pagetitle: Projects
---

The Club mantains a series of programming projects to encourage learning and help students gain experience working in terms to create real software.
Organised from the bottom up, these projects are a way to apply skills and concepts from classes as well as knowledge gained outside university in a friendly and supportive environment.
We aim to design projects that are accessible for people of varying skill levels and abilities.

We only accept contributions to our projects from members so if you are interested but have not yet then please visit our Rubric page today.

<!-- TODO: Add pictures of projects -->

### Untitled Text Adventure
A yet unnamed classic text adventure that started development in early 2024 in C but is currently being rewritten in [Haxe](https://haxe.org/), a blend of Java and Python used mostly for game development which we hope will make the game more approachable to work on.
Like similar text adventures from the 80s and 90s, the game features password based saving rather than modern save files, this forces us to be creative when introducing new features as to avoid bloating the password and so making it hard to use.  

A key focus of this project is having it be compatible with a wide variety of unusual targets including Discord, our Website and the [Pimoroni PicoVision](https://shop.pimoroni.com/products/picovision), an embedded Raspberry PI RP2040 based computer with an HDMI output.
We started in C for it's near universal adoption on both new and old devices going back decades, but it turns out that Haxe fits this niche even better as it can be converted into a number of other languages including C++, JavaScript and Python making it easy to use almost anywhere.
Once the rewrite is done, we have plans to develop a map editor and possibly make use on other Tassie made projects like [Yarn Spinner](https://www.yarnspinner.dev/) for narrative and progression management since a partial [Haxe port](https://github.com/cxsquared/hxyarn) already exists.

<p class="mb-0">Links:</p>
 * [Original game's source code](https://github.com/UTAS-Programming-Club/UntitledTextAdventure)
 * [Haxe rewrite's source code](https://github.com/UTAS-Programming-Club/UntitledTextAdventure/tree/haxe-rewrite)
 * [Some ideas and a partial development history](https://github.com/UTAS-Programming-Club/UntitledTextAdventure/wiki)
 * [Discord bot plugin to use original game](https://github.com/UTAS-Programming-Club/DiscordBot/blob/main/PCBot/plugins/textadventure.py)
 * [Discord bot plugin to use haxe rewrite](https://github.com/UTAS-Programming-Club/DiscordBot/blob/main/PCBot/plugins/textadventurenew.py)
 * [Web build](https://programmingclub.com.au/game/webfrontend.html), note that this is on our old website

### Discord Bot
Developed for our Discord server, the Club's own Discord bot comes with a variety of minigames supporting both singleplayer and multiplayer including tictactoe and minesweeper.
The bot is written in Python using [hikari](https://github.com/hikari-py/hikari), [hikari-crescent](https://github.com/hikari-crescent/hikari-crescent), and [hikari-miru](https://github.com/hypergonial/hikari-miru) to handle communication with Discord, basic user interaction and button menus respectively.
On top of this, we have developed custom methods of reloading and debugging plugins during development with plans to improve these features even further to allow people to work on the bot simulatiously without risking impacting each other.

We have previously included partial support for hangman and classic DECtalk based TTS.
If anyone is interested in these features and would like to help finish support for them, then please let us know.
Recently, we used the bot to list scores from our private Advent of Code 2024 leaderboard to make it easy to compare scores with other members.

<p class="mb-0">Links:</p>
 * [Our bot's source code](https://github.com/UTAS-Programming-Club/DiscordBot)

### Minecraft Mod/Server
Mid last year we soft launched our new modded Minecraft server with [Terralith](https://modrinth.com/mod/terralith) for more interesting terrain generation and [CC: Tweaked](https://modrinth.com/mod/cc-tweaked) i.e updated Computer Craft so we can program with Lua inside the game.
Shortly after starting the server, we began to further mod the game with changes of our own design. 
Currently, our mod just adds explosion proof glass but we welcome suggestions for more features.

If there is interest, we plan to get back into playing during the holidays before semester 1 starts.

<p class="mb-0">Links:</p>
 * [Our mod's source code](https://github.com/UTAS-Programming-Club/HardenedGlass)

### This Website
What you are seeing now is a a major redesign of our original website.
Both are static websites hosted on GitHub but the updated site allows us to write pages in Markdown and then convert to HTML using [Pandoc](https://pandoc.org/) which should be much easier to maintain.
Additionally, major sections of the site like the top nav bar are generated entirely automatically to avoid having to modify every page whenever something changes.
We also used the opportunity to rewrite most pages to cover way more of what we do and how students can get involved as well as add cool new features like dark mode.

Check out the info page with the button in the bottom right to see some more infomation about the website and how it is designed and mantained.
We have plans to add even more content, improve the integration with the text adventure and possibly add alternate themes.
Let us know what you would like to see!

<p class="mb-0">Links:</p>
 * [Our updated website's source code](https://github.com/UTAS-Programming-Club/testwebsite)
 * [Our legacy website's source code](https://github.com/UTAS-Programming-Club/UTAS-Programming-Club.github.io), while it still exists
