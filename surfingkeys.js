settings.scrollStepSize = 90;

map('h', 'E');
map('l', 'R');
map('J', 'd');
map('K', 'u');
map('u', 'S');
map('U', 'D');
map('O', 't');
map('o', 'go');
map('F', 'af');
map('B', 'b');
map('<m-j>', 'R');
map('<m-k>', 'E');
vmap('H', '0');
vmap('L', '$');

mapkey('f', 'Open a link in current tab', function() {
    Hints.create("", Hints.dispatchMouseClick, {tabbed: false});
});

mapkey('b', 'Open a bookmark', function() {
    Front.openOmnibar(({type: "Bookmarks", tabbed: false}));
});

mapkey('s', 'Pause YT video', function() {
    document.getElementsByClassName('ytp-play-button')[0].click();
});

mapkey('S', 'fullscreen YT video', function() {
    document.getElementsByClassName('ytp-fullscreen-button')[0].click();
});

mapkey('a', 'rewind 30s YT video', function() {
    document.getElementsByTagName("video")[0].currentTime -= 5;
});

mapkey('d', 'forward 30s YT video', function() {
    document.getElementsByTagName("video")[0].currentTime += 5;
});

mapkey('A', 'rewind 30s YT video', function() {
    document.getElementsByTagName("video")[0].currentTime -= 30;
});

mapkey('D', 'forward 30s YT video', function() {
    document.getElementsByTagName("video")[0].currentTime += 30;
});

mapkey('q', 'decrease speed of YT video', function() {
    document.getElementsByTagName("video")[0].playbackRate -= 0.2;
});

mapkey('w', 'set speed of YT video', function() {
    document.getElementsByTagName("video")[0].playbackRate == 1 ? document.getElementsByTagName("video")[0].playbackRate = 2 : document.getElementsByTagName("video")[0].playbackRate = 1;
});

mapkey('W', 'set speed of YT video', function() {
    document.getElementsByTagName("video")[0].playbackRate == 1 ? document.getElementsByTagName("video")[0].playbackRate = 1.6 : document.getElementsByTagName("video")[0].playbackRate = 1;
});

mapkey('e', 'increase speed of YT video', function() {
    document.getElementsByTagName("video")[0].playbackRate += 0.2;
});

unmapAllExcept(['<m-j>', '<m-k>', 'a', 'd', 'q', 'w', 'W', 'e', '<Ctrl-f>', '<Ctrl-e>', '<Ctrl-u>', 'b', 'B', 's', 'S', 'A', 'D', 'o', 'O', 'f', 'F', 'n', 'N', 'h', 'l', 'J', 'K', 'u', 'U', '/', 'gg', 'G', 'j', 'k', 'i', 'r', 'x', 'X', 'v']);

Hints.characters = "asdfghjkl";
settings.modeAfterYank = "normal";
settings.hintAlign = "left";
settings.newTabPosition = "right";
settings.focusFirstCandidate = false;
settings.modeAfterYank = "Normal";

addSearchAliasX('r', 'reddit', 'https://www.google.com/search?q=site:reddit.com+');
addSearchAliasX('y', 'youtube', 'https://www.youtube.com/results?search_query=');
addSearchAliasX('h', 'github', 'https://github.com/search?q=sort:stars+');
addSearchAliasX('i', 'image', 'https://www.google.com/search?tbm=isch&q=');
addSearchAliasX('m', 'maps', 'https://www.google.com/maps?q=');


Hints.style(`background: #37474F;
    color: #f0f0f0;
    font-size: 14px;
    border-radius: 3px;
    border: none;
    padding: 4px 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
}
`);

Hints.style(`color-background: #37474F;
    background: #ccc;
    font-size: 14px;
    border-radius: 3px;
    border: none;
    padding: 4px 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
}
`, "text");

// set theme
settings.theme = `
.sk_theme {
    background: #212121;
    color: #f0f0f0;
    font-size: 16px;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d9dce0;
}
.sk_theme .url {
    color: #2173c5;
}
.sk_theme .annotation {
    color: #38f;
}
.sk_theme .omnibar_highlight {
    color: #f0f0f0;
    background: tomato;
}
.sk_theme ul>li:nth-child(odd) {
    background: #323232;
}
.sk_theme ul>li.focused {
    color: #212121;
    background: #ccc;
}`;
