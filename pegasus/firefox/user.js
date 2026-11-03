// RAM
user_pref("dom.ipc.processCount", 4);
user_pref("browser.tabs.unloadOnLowMemory", true);

// Enable CSS Customization
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("ui.prefersReducedMotion", 1);

// HDD: session saves default to every 15s; 60s cuts constant small writes
user_pref("browser.sessionstore.interval", 60000);
user_pref("browser.cache.disk.smart_size.enabled", false);
user_pref("browser.cache.disk.capacity", 262144);

// Gemini Lake has no AV1 decoder; disabling AV1 makes YouTube serve VP9, which the GPU decodes
user_pref("media.av1.enabled", false);

// Background work
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// Telemetry
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);

// Local AI engine (runs its own inference process when used)
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("extensions.ml.enabled", false);
