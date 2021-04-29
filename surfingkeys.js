settings.scrollStepSize = 90;

map('J', 'd');
map('K', 'u');
map('u', 'S');
map('U', 'D');
map('F', 'af');
vmap('H', '0');
vmap('L', '$');

mapkey('f', 'Open a link in current tab', function() {
    Hints.create("", Hints.dispatchMouseClick, {tabbed: false});
});

mapkey('s', 'Pause video', function() {
    const vid = document.getElementsByTagName("video")[0];
    vid.paused ? vid.play() : vid.pause();
});

mapkey('S', 'Fullscreen video', function() {
    document.getElementsByClassName('ytp-fullscreen-button')[0].click();
});

mapkey('a', 'rewind video 5s', function() {
    document.getElementsByTagName("video")[0].currentTime -= 5;
});

mapkey('d', 'forward video 5s', function() {
    document.getElementsByTagName("video")[0].currentTime += 5;
});

mapkey('A', 'rewind video 30s', function() {
    document.getElementsByTagName("video")[0].currentTime -= 30;
});

mapkey('D', 'forward video 30s', function() {
    document.getElementsByTagName("video")[0].currentTime += 30;
});

mapkey('q', 'decrease video playback rate by 20%', function() {
    document.getElementsByTagName("video")[0].playbackRate -= 0.2;
});

mapkey('e', 'increase video playback rate by 20%', function() {
    document.getElementsByTagName("video")[0].playbackRate += 0.2;
});

mapkey('w', 'set speed of YT video', function() {
  const video = document.getElementsByTagName("video")[0];
  video.playbackRate = video.playbackRate === 1 ? 2 : 1;
});

mapkey('W', 'set speed of YT video', function() {
  const video = document.getElementsByTagName("video")[0];
  video.playbackRate = video.playbackRate === 1 ? 1.6 : 1;
});

unmapAllExcept(['a', 'd', 'q', 'w', 'W', 'e', 's', 'S', 'A', 'D', 'f', 'F', 'J', 'K', 'u', 'U', 'gg', 'G', 'j', 'k', 'i', 'v']);

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
addSearchAliasX('d', 'duckduckgo', 'https://www.duckduckgo.com/?q=');


Hints.style(`background: #37474F !important;
    color: #f0f0f0 !important;
    font-size: 13px;
    border-radius: 3px;
    border: none;
    padding: 3px 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
    font-family: 'Roboto Mono', monospace;
    opacity: 1 !important;
`);

Hints.style(`color: #37474F !important;
    background: #ccc !important;
    font-size: 13px;
    border-radius: 3px;
    border: none;
    padding: 3px 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
    font-family: 'Roboto Mono', monospace;
    opacity: 1 !important;
`, "text");
