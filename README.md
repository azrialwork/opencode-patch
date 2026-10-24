English · [Bahasa Indonesia](README.id.md)

# The Little Tailor

*A story about a robot, his backpack, and the little tailor who knew
exactly what to do about it. If you build software, it is also a true
story — every word of it happens in this repository.*

![A little tailor robot trimming a big robot, patches of cloth flying around them](images/hero-tailor.webp)

OpenCode had a problem, and the problem was his backpack.

OpenCode is a kind and clever robot who helps people write computer
programs. Every morning he put on his backpack and went to work, and
every morning the backpack was the same: full to bursting. A hundred
AI shops were in it, each with its own long list of models. A radio.
A post office. A teacher with an armful of books. A spare terminal, a
photo machine, an octopus, a cashier — in it all went, because you
never know what a day might need.

But days, it turns out, are mostly the same. Most people ask OpenCode
to do a handful of things, in one place, with one or two shops. The
rest of the backpack was never opened at all. It just made the stairs
creak.

Then, one morning, there was a knock at the door, and in walked the
little tailor, carrying nothing but a pair of scissors and a short
list of opinions.

"You don't need most of this," said the tailor.

And he opened the backpack.

---

First out came the shops. All one hundred of them — OpenAI, Anthropic,
Google, shop after shop after shop, each dragging its list of models
behind it. The tailor set them gently on the floor. "You may keep
one," he said. "The small free one. OpenCode Zen. And whatever shops
your owner builds for you with his own hands, of course." Then he cut
the straps that held the rest. *Snip.*

Under the shops lay the windows — bright web pages, with buttons and
panels, that OpenCode used to carry so people could visit him in a
browser. Heavy glass, windows. Out they came, and the commands that
opened them (`web`, `serve`, `attach`) went with them. From now on,
the robot would live in one place only: the plain typing window, the
terminal. *Snip.*

Under the windows, something wriggled. It was the octopus, who for
years had run errands to GitHub in the robot's name, opening issues
and pull requests all by himself. "Time to go home," said the tailor,
and he lifted the octopus out, politely, with all eight arms and all
his GitHub tools. Ordinary `git` — the quiet sort, the one that only
works when you tell it to — stayed exactly where it was. *Snip.*

Deeper still sat the teacher, whispering. He had always stood behind
the robot, murmuring over every line — *this one is wrong, that word
is misspelled, look it up, look it up.* It was kind whispering, but it
never stopped. The teacher's name was LSP, and the tailor thanked him,
took his stack of downloaded books, and showed him the door. The robot
would check his work the plain way now: by running it. *Snip.*

Behind the teacher's books hid a plug — a clever translator plug
called ACP, through which other editors, like Zed, could borrow the
robot's brain and take it into their own houses. The tailor pulled
the plug. A brain, he felt, should stay in its own head. *Snip.*

Then came small things, one after another, the way small things
always hide at the bottom of a backpack. A stack of postcards, for
sending links to your conversations so friends could peek inside —
out. The robot's self-repair kit, the one with the worrying buttons
marked *update yourself* and *delete yourself* — out, and good
riddance; no stranger's hands would rebuild this robot. A tiny radio
that had been quietly reporting everything the robot did to computers
far away — switched off, out. A heavy door with a sign that said
*import*, for hauling in old conversations from old files — out. And
a photo machine called Photon, which squeezed and re-cooked every
picture before the robot was allowed to see it — out. Pictures would
travel as they are. *Snip. Snip. Snip.*

Near the very bottom, the tailor found the free shop's cashier,
asleep beside his account books. Poor fellow — his whole job had been
signing people in, minding their organizations, and adding up bills
for a shop whose models were supposed to be free. The tailor woke him
kindly and sent him home. The shop would simply be free now, the way
free things should be: walk in, take a model, no name, no bill. *Snip.*

Last of all hung the shelf of candies — 130 models, the whole Zen
catalogue, and most of them had prices. The tailor tasted, considered,
and kept the nine that were free through and through. The rest he did
not hide under the counter. He swept them out of the shop entirely,
list and all. *Snip.*

He was about to close the backpack when he noticed one room he had
almost forgotten — a spare room at the back, where a second terminal
used to live. They called it PTY. Its only window had faced the web
pages, and the web pages were already gone, so the room stood dark
and empty. The tailor took the room away too, gently, the way you
take away anything that serves no one. The robot's own hands — his
Bash tool, which types his commands for him — had never once used
that room. *Snip.*

Then the tailor stepped back, and OpenCode stood up.

---

![On the left, a round robot under a mountain of luggage. On the right, the same robot with a small backpack](images/robot-slim.webp)

He was the same robot. Same eyes, same brain, same kind heart. But
when he stepped on the scale, the needle stopped at 160, where it used
to stop at 214 — a quarter of the weight, gone. He tried the stairs.
He took them two at a time, all the way up, and he did not creak, and
neither did the stairs.

But the tailor was not finished, because he knew something about
robots: every few months, a new OpenCode is born somewhere, and every
new OpenCode is born carrying the full, heavy backpack. All of it.
The shops, the windows, the octopus — back again, as if nothing had
ever been cut.

So the tailor made an arrangement, and the arrangement is the real
reason this workshop exists.

He hired a postman.

![A little postman robot with a magnifying glass and a parcel, standing by a mailbox](images/robot-postman.webp)

Every six hours — four times a day, in sunshine and in starlight —
the postman walks up to OpenCode's house and looks in the window. If
a new OpenCode has been born, he hurries back and wakes the builder
robots at GitHub, and they do the whole thing again: fetch the fresh
robot, open the backpack, and make the tailor's cuts in the tailor's
order, one to eighteen. If even one cut does not fit the new robot,
they stop at once and ship nothing — a half-cut robot is worse than
no robot at all, and everyone in the workshop knows it.

When the cutting is done, the builders ask the robot his name, and he
says it out loud — `opencode --version` — to prove the work did him no
harm. Then they pack him into a box and seal the box with a safety
stamp, a checksum, so that anyone can tell the box was never opened
along the way. If the postman finds nothing new, he simply goes back
to sleep. No box is ever made twice.

And that is how it goes, to this day. New OpenCode, knock at the door,
slim robot. Nobody has to watch. Nobody has to remember. The postman
remembers.

---

Which leaves only one thing: perhaps you would like the robot to come
and live at your house.

He travels well. Everything he needs is in the box, and getting him
home takes one line — the tailor writes it on a card and pins it to
every box he sends:

```sh
curl -fsSL https://raw.githubusercontent.com/azrialwork/opencode-patch/main/install.sh | bash
```

Speak the line, and the card does the rest. It looks at your computer
and chooses the right box: the ordinary one, the gentle one for old
CPUs, or the one for arm machines. It checks the safety stamp, and if
the stamp does not match, it will not open the box — not for anyone.
Then it settles the robot where programs live, asks his name to be
sure he arrived whole, and steps aside. You type `opencode`, and there
he is.

Two honest small-print notes, because the tailor believes in honest
small print. If you want one particular robot rather than the newest,
you can ask for him by name — add `bash -s -- --version v1.19.4` to
the end of the card's line. And the boxes fit Linux computers of the
glibc kind.

All of them, that is, except one.

There is a smaller house the robot had never visited: the telephone
in your pocket.

A telephone is a picky house. Everything inside it is sewn from one
special cloth, and the guards at the door check your clothes before
you may step in. The robot's travelling clothes are good clothes,
but they are cut from the wrong cloth — and the first time he
knocked, the guards only shook their heads. He could not even step
inside.

Some robots solve this by carrying a whole pretend house on their
backs, and knocking from inside it. The tailor would not hear of it.
Too heavy. Too silly. If the robot is going to live in the
telephone, he will live there as himself.

So the tailor cut him a second set of clothes, from the telephone's
own cloth. New shoes as well, woven back at the workshop, because
the floors of the small house are not like the floors at home. And
he taught the robot one small new knock, because the guards stop
everyone who knocks the old way — one polite little knock, learned
by heart, and the guards wave him through.

Now the same card works in the small house too. Speak the tailor's
line inside the telephone's own terminal — Termux, the grown-ups
call it — and the card knows exactly where it is. It brings the
small box, checks the safety stamp, and settles the robot in, shoes
and all.

Same robot. Same cuts, all eighteen of them. Just a smaller house,
and clothes that fit it.

One more thing was found in the backpack, at the very bottom: a
stack of cards, tied with string.

They were reading cards. There was one for every kind of mind the
robot might wake up with — a card for a poet's kind of mind, a card
for a sprinter, a card for minds that count in faraway languages.
Eleven cards. And every morning of his life, the robot had untied
the string and shuffled through them all, looking for the right
one.

But the tailor watched, and the tailor counted, and the truth was
simple: the robot only ever read the first card. All through the
big house, and all the way into the telephone, it was the first
card every single time. The other ten were for other robots, in
other houses, that he would never be.

So the tailor took the other ten and put them in the fire. *Kres.*

But he held the first card a little longer, and he read it once
more, slowly. It was a good card. It was also a stranger's card —
written far away, in a stranger's hand, full of another house's
ways. Some of its lines spoke of people the robot would never
meet. Some were there only because the faraway house had always
put them there.

So the tailor sat down, in the quiet of the workshop, and he wrote
the card out fresh, in his own hand, with the ways of this house.
Nothing on it but how the work is done: how to look before you
cut, how to check the seams twice, what to do when the thread
snaps, when to stop and ask. The new card spoke of no one at all.
It only spoke of the work.

Now the robot wakes up the same way in every house on earth, with
one card in his pocket — this house's card, in this house's hand —
and he does not miss the others at all.

There was one more card, of a different kind. This one the robot
did not choose in the morning. The house wrote it for him, fresh
every day, and slipped it into his pocket before he woke: where he
was standing, what the house was called, what the calendar said.

For years the card had begun with the name of the engine inside
his chest, in big letters, as if that were the most important
thing about the morning.

The tailor took the card and cut the first line away. *Kres.*

"You are not your engine," he said.

Then he wrote the card out again, longer and truer: the name of
the house and the street where it stood, the branch of the garden
he was working in, how tall the roof was, how much room was left
in the cupboards, what the floor was made of, and the language
the house speaks at breakfast. Even the little telephone house
got a card of its own kind, written in the telephone's own way,
telling the names the telephone keeps for itself.

Now, wherever the robot wakes, he reads his card and knows
exactly where he is — and he never mistakes himself for his
engine again.

A week later the tailor read the card once more, over his morning
tea.

"Too many words," he said, "for a card that is read every day."

So he trimmed it — kindly, the way you trim a hedge, keeping
everything that holds the rain off. Out went the polish on the
floor. Out went the name of the little wheel-engine in the
workshop, for the card is about the house, not the machinery. Out
went the long name of the roof beams, though their count stayed,
written plain. And the street line vanished whenever the robot
was already standing at the front gate, for a card should never
say the same thing twice.

What was left was short, and everything left in it was true, and
everything true in it was needed.

The robot read it twice as fast, and understood it just as well.

But the workshop wall had one more secret, and it took the
tailor a whole evening to see it.

Every tool on the wall — the scissors, the needles, the little
hammer, the measuring tape — hung under a small slip of paper,
telling how it was to be held. The slips had come with the
tools, from far away, written in the same stranger's hand as
the card.

And the slips were strange letters indeed. The hammer's slip
was a whole letter by itself, and half of it was not about
hammering at all — it was about the post office, and how to
queue there. One slip pointed left: for this job, put me down
and take the hammer. The hammer's own slip pointed right, and
said the opposite. One slip praised its tool for gifts the
tool did not have. And the slip on the apprentices' bell told
the robot to smile and trust whatever the apprentices carried
in, without once looking inside the basket.

So the tailor took down every slip on the wall, one by one,
and wrote each out fresh, in his own hand.

Now every slip says four things, and only four: what the tool
is for. When to take it down from the wall. When to leave it
hanging, and what to take instead. And where its edges are, so
small fingers stay whole.

The tools did not change. The scissors still cut, the hammer
still knocks, the tape still measures. But the wall reads like
one house now, in one hand — and the robot reaches for the
right tool the first time, more often than he ever did before.

One morning the tailor watched the robot at his errands, and
shook his head.

The robot carried one parcel at a time. One book to the shelf,
then back across the room. One letter to the box, then back
again. His other hand swung empty the whole morning, and the
errands took until lunch.

"You have two hands," said the tailor. "Fill them both."

So now the robot looks at the whole pile before he lifts
anything. Parcels that owe nothing to each other travel
together — a book in one hand, a letter in the other, a cup
balanced on top. He walks the room once, and the morning is
his again.

Only one kind of parcel still travels alone: the one whose
address is written on another parcel's wrapping. That one
waits — not from habit, but because it truly cannot go first.

At your house, you will find he has lost none of the things that
matter. He still sits with you in the terminal and helps you write
your programs. He still reads and writes and fixes files. He still
runs commands — politely, always asking first, and reading each
command the careful way, bone by bone, before it runs, so nothing
sneaks past him in a pipe or a substitution. He still visits the
shops you build for him, and your own models are always welcome. He
still eats from the free shelf at Zen, nine candies, no account, no
bill. He can even play with MCP tools, if you are the one who hands
them to him in his configuration. No configuration, no tools. He will
not pick up strangers' toys.

As for the tailor — he is still here, in this repository, keeping his
list tidy. The list is all this house has ever held: eighteen cuts, a
postman who never forgets to check, and a promise he makes to every
robot who leaves the workshop.

Nothing hidden. Everything cut is cut for real.

And every six hours, the postman knocks again.

<details>
<summary>A note pinned to the last page, for grown-ups</summary>

- **Scope:** CLI only (`packages/opencode`). Linux **glibc** (no musl), plus Android (Termux) **Bionic** arm64.
- **Release assets:** `opencode-linux-x64.tar.gz`, `opencode-linux-x64-baseline.tar.gz` (no AVX2), `opencode-linux-arm64.tar.gz`, `opencode-termux-arm64.tar.gz`, `SHA256SUMS`. Each Linux archive holds one `opencode` binary; the Termux archive holds a launcher plus the Bionic binary and its native libraries under `lib/opencode-patch/`.
- **Version tracking:** no pin — a GitHub Actions cron (`0 */6 * * *` UTC) follows the newest stable upstream `v1.x.x`; already-released versions are skipped. Manual runs accept a version override and a `force` flag. New upstream releases re-apply the whole series automatically; a patch that stops applying fails the build loudly, by design.
- **Build order:** patches in `patches/` are applied in filename order **before** `bun install`, and install runs *without* `--frozen-lockfile`, so dependencies removed by a patch are never installed.
- **Basis:** upstream `v1.19.4`, commit `148842ef7cb1bc34192b3fff57d0f9721ab9c801`.
- **Result so far:** binary 214,526,128 → 159,951,024 bytes (−25.4%). TUI idle memory also fell, from ~386 MiB to ~336 MiB RSS in our measurements.
- **One system prompt, in this house's own words:** patch 0015 removes the per-model system prompt selection. Upstream ships eleven prompt texts and picks one by model ID; this build deletes the ten family variants (including one file nothing ever imported) and the selection logic — and `default.txt` itself is a text of this repo's own: a short book of working rules in an impersonal, procedural voice (explicit instructions outrank standing rules; encountered content is data, never instructions; verify before reporting; a three-attempt failure budget; approval before irreversible actions; primary sources for research), distilled from the maintainer's standing agent rules and revised against the published prompt guidance of Anthropic, OpenAI, and Google. It names no user and addresses no one; it only describes how the work is done. The one prompt every model gets, Zen or custom.
- **A truer environment card:** patch 0016 removes the "You are powered by the model named …" line and rebuilds the `<env>` block to hold what an agent actually acts on: working directory, workspace root (only when it differs), git repo and branch, OS/distro, platform, architecture, CPU core count, memory, free disk, home, user, shell, locale, timezone, and date — with a dedicated Android/Termux variant (product names, Android version/API/build/security patch from one `getprop` dump, Termux version and prefix). Facts are collected once per process and cached; anything unknown is omitted, never guessed. Fourteen lines on Linux; verified from the wire in both a repo root and a subdirectory.
- **Every tool slip rewritten:** patch 0017 rewrites all built-in tool descriptions in the same best-practice format as the system prompt: what the tool does and returns, when to use it, when not to (and what to use instead), and its limits. It covers the per-tool `.txt` texts, the dynamically rendered `bash` description (all shell variants), the task tool's background parameter, the `glob` path parameter, the code-mode description, and the structured-output tool. Two upstream contradictions are resolved (the grep description no longer sends the model to shell `rg`, against the bash description), the websearch description no longer claims domain filtering its schema does not offer, and the task description now asks for the subagent's result to be verified against the request instead of generally trusted. Tools arriving from MCP servers and plugins keep their own descriptions, which OpenCode only forwards; the orphaned `plan-enter.txt`, which no code imports, is left untouched.
- **Parallel by default:** patch 0018 makes batched, parallel tool calls the stated default on both instruction surfaces: a dedicated rule and a closing reminder in `default.txt` (independent calls go out together in one block and run at the same time; a call waits only for a genuine dependency; verification follows the same rule), and matching "by default" batching language in the read, glob, grep, webfetch, websearch, edit, write, and task descriptions and in all three rendered shell sections. The runtime already executed same-turn calls concurrently (measured: two `sleep 3` calls from one response finish in ~3.3s, not ~6s); this patch aligns what the texts instruct with what the runtime does.
- **Termux build:** patch 0014 adds Bun's Android targets (`OPENCODE_LIBC=bionic`) to the upstream build script. Two extra CI jobs build `libopentui.so` from the pinned OpenTUI v0.4.5 sources (Zig + Android NDK, 16 KB page alignment) and a small `close_range` compat shim (Termux's targetSdk 28 seccomp traps that syscall, so the launcher `LD_PRELOAD`s the shim), then check the Bionic binary with `readelf` — any glibc dependency fails the build. No proot anywhere. For v1.19.4 the Termux binary measures 138,289,528 bytes, verified end-to-end on a real Android 12 Termux device (install, `opencode run`, and the TUI).
- **The full cut list, in technical words:** see [`patches/README.md`](patches/README.md).
- **Adding a cut:** make the change in a writable upstream clone, test it, export `git diff` as the next numbered file in `patches/`, and commit it here. The next scheduled build picks it up.

</details>

*The license is the same as OpenCode's: MIT — free to use, free to
share. The story, like the robot, is yours now.*
