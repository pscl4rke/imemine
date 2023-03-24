

// READER MODE
//  Reader mode is one of the best parts of firefox.
//  This makes it a tad easier on the eye.
user_pref("reader.color_scheme", "sepia");


// SCROLLING
user_pref("layout.testing.overlay-scrollbars.always-visible", true);
user_pref("widget.non-native-theme.gtk.scrollbar.thumb-size", 2);


// DOWNLOADS
//  Don't keep hiding the download icon.  But also don't let
//  the list get in the way.
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.alwaysOpenPanel", false);


// DEFAULTS
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");


// EXTENSIONS
//  This ensures that any extensions listed inside `<profile>/extensions`
//  will be automatically installed and used by the profile.
//  The name of each extension must be the applications.gecko.id from
//  manifest.json (with a trailing .xpi).
//  If this is not defined then a UUID is used within braces which is
//  derived from the signature (find in about:debugging).
user_pref("extensions.autoDisableScopes", 14);
user_pref("extensions.pocket.enabled", false);


// PHONING HOME
//  There seem to be so many ways my browser itself wants to talk to the
//  outside world about me.
user_pref("geo.enabled", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);


// SLIP UNDER THE RADAR
//  Note that this can break things
user_pref("webgl.disabled", true);
user_pref("webgl.renderer-string-override", " ");
user_pref("webgl.vendor-string-override", " ");


// UNKNOWN
user_pref("beacon.enabled", false);
user_pref("browser.send_pings", false);
