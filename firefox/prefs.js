

// READER MODE
//  Reader mode is one of the best parts of firefox.
//  This makes it a tad easier on the eye.
user_pref("reader.color_scheme", "sepia");


// DOWNLOADS
//  Don't keep hiding the download icon.
user_pref("browser.download.autohideButton", false);


// EXTENSIONS
//  This ensures that any extensions listed inside `<profile>/extensions`
//  will be automatically installed and used by the profile.
//  The name of each extension must be the applications.gecko.id from
//  manifest.json (with a trailing .xpi).
//  If this is not defined then a UUID is used within braces which is
//  derived from the signature (find in about:debugging).
user_pref("extensions.autoDisableScopes", 14);
user_pref("extensions.pocket.enabled", false);
