document.addEventListener('turbo:load', function() {
    console.log('Turbo:load event fired');
    lightbox.init();
});

document.addEventListener('turbo:frame-load', function() {
    console.log('Turbo:frame-load event fired');
    lightbox.init();
});

document.addEventListener('turbo:render', function() {
    console.log('Turbo:render event fired');
    lightbox.init();
});
